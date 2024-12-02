import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir URLs

import '../shared/global/globalVariables.dart';

class InicialScreen extends StatelessWidget {
  const InicialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra superior com a imagem
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
                  _buildHorizontalContent(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    final user = Provider.of<GlobalVariables>(context).user;
    final userName = user != null
        ? user["name"] ?? "Nome não disponível"
        : "Nome não disponível";
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: ListTile(
            title: Text(
              userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Verifique suas informações aqui',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/telaPerfil');
            },
          ),
        ),
        Positioned(
          left: 0,
          top: 8,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: const Icon(
              Icons.person,
              size: 30,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalContent(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Alinha verticalmente
        children: [
          // Mapa com título acima
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Acesse O Mapa Completo Das Vias',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Espaço entre texto e mapa
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                      'https://www.metro.sp.gov.br/pt_BR/sua-viagem/linhas-estacoes/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Não foi possível abrir o link $url';
                  }
                },
                child: Container(
                  width: 500, // Largura do mapa
                  height: 500, // Altura do mapa
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/linhasMetro.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 30), // Espaçamento entre mapa e botões
          // Botões com título acima
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Principais Operações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Espaço entre texto e botão
              buildStyledButton('Cadastrar Novo Usuário', () {
                Navigator.pushNamed(context, '/telaCadastrarNovoUsuario');
              }),
              const SizedBox(height: 20), // Espaço entre os botões
              buildStyledButton('Verificar Cadastro Usuário', () {
                Navigator.pushNamed(context, '/telaVerificarCadastro');
              }),
              const SizedBox(height: 20), // Espaço entre os botões
              buildStyledButton('Registros do Sistema', () {
                Navigator.pushNamed(context, '/telaLog');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThickerDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }

  ElevatedButton buildStyledButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
        padding: const EdgeInsets.symmetric(vertical: 15),
        minimumSize: const Size(206, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
