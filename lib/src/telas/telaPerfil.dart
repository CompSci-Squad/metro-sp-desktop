import 'package:flutter/material.dart';

class telaPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra superior com a imagem, como na tela de login
          Container(
            width: double.infinity,
            height: 28,
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
                  _buildProfileImage(), // Adiciona a foto de perfil
                  SizedBox(height: 16), // Espaço entre a foto e o próximo item
                  _buildProfileItem('Número De Registro', 'xxxxxxxxxxxxxxxx'),
                  _buildThickerDivider(),
                  _buildProfileItem('E-mail @metro', 'xxxxxxxxxxxxxxxxxxxx'),
                  _buildThickerDivider(),
                  _buildProfileItem('Estação', 'xxxxxxxxxxxxxxxx'),
                  _buildThickerDivider(),
                  _buildProfileItem('Entrada Responsável', 'xxxxxxxxxxxxxxxxxxxx'),
                  Spacer(),
                  _buildBackButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
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
            Navigator.pushReplacementNamed(context, '/telaCadastrarNovoUsuario');
          }),
          _buildDrawerItem('Verificar Cadastro Usuário', () {
            Navigator.pushReplacementNamed(context, '/telaVerificarCadastro');
          }),
          _buildDrawerItem('Verificar Status Do Totem', () {
            Navigator.pushReplacementNamed(context, '/telaVerificarStatusTotem');
          }),
          _buildDrawerItem(
            'Reportar Falha De Totem',
            () {
              Navigator.pushReplacementNamed(context, '/telaReportarFalhaTotem');
            },
            textColor: Colors.red,
          ),
          _buildDrawerItem(
            'Desbloquear Totem',
            () {
              Navigator.pushReplacementNamed(context, '/telaDesbloquearTotem');
            },
            textColor: Colors.green,
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(String title, VoidCallback onTap, {Color? textColor}) {
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
        Padding(
          padding: const EdgeInsets.only(left: 80.0, top: 8.0, bottom: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Olá, Nome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 8,
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                size: 43,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: CircleAvatar(
        radius: 40, // Tamanho do círculo (ajuste conforme necessário)
        backgroundColor: Colors.grey[300], // Cor de fundo para simular um espaço para foto
        child: Icon(
          Icons.person,
          size: 50, // Ícone de "perfil" dentro do círculo
          color: Colors.black54,
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
