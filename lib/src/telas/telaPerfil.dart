import 'package:flutter/material.dart';
import '../../services/api_service.dart'; // Certifique-se de que o caminho esteja correto
import 'package:provider/provider.dart';
import './globalVariables.dart'; // Import da classe GlobalVariables

class TelaPerfil extends StatefulWidget {
  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  late Future<Map<String, dynamic>> _dataFuture;

  Future<Map<String, dynamic>> fetchData(String userEmail) async {
    final response = await apiService.get('/user/$userEmail');
    return response;
  }

  @override
  void initState() {
    super.initState();
    final userEmail = Provider.of<GlobalVariables>(context, listen: false).user?["email"];
    _dataFuture = fetchData(userEmail ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return Column(
              children: [
                // Barra superior ajustada
                _buildTopBar(),
                // Conteúdo principal
                Expanded(
                  child: Center(
                    child: Container(
                      width: 600, // Limita a largura do conteúdo
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
                        crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                        children: [
                          // Cabeçalho ajustado com seta à esquerda e texto ao lado
                          _buildHeaderWithBackButton(),
                          const SizedBox(height: 16),
                          _buildProfileImage(), // Foto de perfil
                          const SizedBox(height: 16),
                          _buildProfileItem('Número De Registro', data["id"]),
                          _buildThinDivider(),
                          _buildProfileItem('E-mail @metro', data["email"]),
                          _buildThinDivider(),
                          _buildProfileItem('Estação', data["stations"][0]["name"]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      height: 80, // Altura ajustada para 80px
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/barraMetro.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeaderWithBackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centraliza a Row horizontalmente
      children: [
        // Seta de voltar
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 8), // Espaçamento entre a seta e o texto
        const Text(
          'Perfil do Usuario',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 60, // Tamanho do círculo
      backgroundColor: Colors.grey[300], // Cor de fundo para simular um espaço para foto
      child: Icon(
        Icons.person,
        size: 80, // Ícone de "perfil" dentro do círculo
        color: Colors.black54,
      ),
    );
  }

  Widget _buildThinDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1, // Reduz a espessura
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Reduz espaçamento entre itens
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os textos
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Centraliza o texto
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center, // Centraliza o valor
          ),
        ],
      ),
    );
  }
}
