import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart';
import './globalVariables.dart';

class TelaVerificarCadastro extends StatefulWidget {
  @override
  _TelaVerificarCadastroState createState() => _TelaVerificarCadastroState();
}

class _TelaVerificarCadastroState extends State<TelaVerificarCadastro> {
  final TextEditingController _cpfController = TextEditingController();
  bool _isLoading = false;

  Future<void> findUser() async {
    final String cpf = _cpfController.text;

    if (cpf.isEmpty) {
      _showErrorDialog('Por favor, insira um CPF válido.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final passenger = await apiService.get("/passenger/cpf/$cpf");

      if (!passenger.containsValue(cpf)) {
        _showErrorDialog('Usuário não encontrado no banco de dados.');
      } else {
        Provider.of<GlobalVariables>(context, listen: false).setPassengerResponse(passenger);
        Navigator.pushReplacementNamed(context, '/telaVerificarCadastroEncontrado');
      }
    } catch (error) {
      _showErrorDialog('Erro ao buscar o usuário. Tente novamente.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
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
              Text(
                message,
                style: const TextStyle(color: Colors.white),
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
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Barra superior com a imagem
          Container(
            width: double.infinity,
            height: 80,
            child: Image.asset(
              'assets/barraMetro.png',
              fit: BoxFit.cover,
            ),
          ),
          // Conteúdo principal
          Expanded(
            child: Center(
              child: Container(
                width: 600, // Define a largura fixa para o conteúdo
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabeçalho com seta e título
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Verificar Passageiro',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    const SizedBox(height: 20),
                    // Campo para CPF
                    const Text(
                      'Digite o C.P.F. Do Usuário',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _cpfController,
                      decoration: InputDecoration(
                        hintText: '***.***.***-**',
                        filled: true,
                        fillColor: const Color.fromRGBO(0, 20, 137, 1),
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    // Botão Verificar
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : findUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Verificar',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                        ),
                      ),
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
}
