import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/services/apiService.dart';
import '../shared/global/globalVariables.dart';

class VerifyPassengerScreen extends StatefulWidget {
  @override
  _VerifyPassengerScreenState createState() => _VerifyPassengerScreenState();
}

class _VerifyPassengerScreenState extends State<VerifyPassengerScreen> {
  final TextEditingController _cpfController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> findUser() async {
    final String cpf = _cpfController.text;

    if (cpf.isEmpty) {
      setState(() {
        _showErrorDialog();
      });
      return;
    }

    final passenger = await apiService.get("/passenger/cpf/$cpf");

    if (!passenger.containsValue(cpf)) {
      setState(() {
        _showErrorDialog();
      });
    } else {
      Provider.of<GlobalVariables>(context, listen: false)
          .setPassengerResponse(passenger);
      Navigator.pushReplacementNamed(
          context, '/telaVerificarCadastroEncontrado');
    }
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            child: Image.asset(
              'assets/barraMetro.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreetingSection(context),
                  _buildThickerDivider(),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  if (_isLoading) Center(child: CircularProgressIndicator()),
                  Spacer(),
                  Center(child: _buildOperationButtons(context)),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Usuário não encontrado no banco de dados',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color.fromRGBO(0, 20, 137, 1)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Drawer buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 20, 137, 1),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem('Cadastrar Novo Usuário', () {
            Navigator.pushReplacementNamed(
                context, '/telaCadastrarNovoUsuario');
          }),
          _buildDrawerItem('Verificar Cadastro Usuário', () {
            Navigator.pushReplacementNamed(context, '/telaVerificarCadastro');
          }),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(String title, VoidCallback onTap,
      {Color? textColor}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black),
      ),
      onTap: onTap,
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Verificar Cadastro Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
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

  Widget _buildOperationButtons(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Digite o C.P.F. Do Usuário',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          TextField(
            controller: _cpfController,
            decoration: InputDecoration(
              hintText: '***.***.***-**',
              filled: true,
              fillColor: Color.fromRGBO(0, 20, 137, 1),
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: findUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Verificar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}
