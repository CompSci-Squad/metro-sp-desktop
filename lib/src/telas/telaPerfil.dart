import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGreetingSection(context),
                    _buildProfileImage(), // Adiciona a foto de perfil
                    _buildProfileItem('Número De Registro', 'xxxxxxxxxxxxxxxx'),
                    _buildThickerDivider(),
                    _buildProfileItem('E-mail @metro', 'xxxxxxxxxxxxxxxxxxxx'),
                    _buildThickerDivider(),
                    _buildProfileItem('Estação', 'xxxxxxxxxxxxxxxx'),
                    _buildThickerDivider(),
                    _buildProfileItem('Entrada Responsável', 'xxxxxxxxxxxxxxxxxxxx'),
                  ],
                ),
              ),
            ),
          ),
          // Botão de Voltar
          _buildBackButton(context),
        ],
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

  Widget _buildGreetingSection(BuildContext context) {
    return Row(
      children: [
        // Seta de voltar
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 16), // Espaçamento entre a seta e o texto
        const Text(
          'Olá, Nome',
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

  Widget _buildThickerDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
