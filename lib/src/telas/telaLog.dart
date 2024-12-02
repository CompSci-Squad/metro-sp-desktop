import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart'; // Certifique-se de que o caminho esteja correto
import './globalVariables.dart'; // Import da classe GlobalVariables

class TelaLog extends StatefulWidget {
  @override
  _TelaLogState createState() => _TelaLogState();
}

class _TelaLogState extends State<TelaLog> {
  late Future<List<Map<String, dynamic>>> _logsFuture;

  Future<List<Map<String, dynamic>>> fetchLogs() async {
  final response = await apiService.get('/logs');
  
  // Verifica se a resposta é uma lista de logs
  if (response is List) {
    return List<Map<String, dynamic>>.from(response);
  }

  // Se for um único objeto, encapsula-o em uma lista
  if (response is Map) {
    return [Map<String, dynamic>.from(response)];
  }

  // Caso contrário, lança um erro
  throw Exception('Formato inesperado na resposta do servidor');
}


  @override
  void initState() {
    super.initState();
    _logsFuture = fetchLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Center(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildHeaderSection(context),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _logsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Erro ao carregar logs: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          final logs = snapshot.data!;
                          Provider.of<GlobalVariables>(context, listen: false).setLogs(logs);
                          return _buildLogSection(logs);
                        } else {
                          return const Center(child: Text('Nenhum log encontrado'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/barraMetro.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 16),
        const Text(
          'Registros do Sistema',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildThickerDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }

  Widget _buildLogSection(List<Map<String, dynamic>> logs) {
    return Expanded(
      child: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return Column(
            children: [
              _buildLogItem(
                title: log["message"] ?? "Sem mensagem",
                date: log["timestamp"].split('T')[0],
                time: log["timestamp"].split('T')[1].split('.')[0],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLogItem({
    required String title,
    required String date,
    required String time,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
      leading: const Icon(
        Icons.info_outline,
        color: Colors.black54,
        size: 30,
      ),
    );
  }
}
