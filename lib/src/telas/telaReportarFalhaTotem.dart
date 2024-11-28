import 'package:flutter/material.dart';


class telaReportarFalhaTotem extends StatelessWidget {
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
                  _buildIDField(),
                  SizedBox(height: 20),
                  _buildDescriptionField(),
                  SizedBox(height: 20),
                  _buildReportButton(),
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
              'Reportar Falha Do Totem',
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

  Widget _buildThickerDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }

  Widget _buildIDField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Digite o I.D. do totem',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        TextField(
          obscureText: false,
          decoration: InputDecoration(
            hintText: 'I.D.totem',
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
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descreva a falha do totem a ser reportada',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        TextField(
          obscureText: false,
          decoration: InputDecoration(
            hintText: 'Descreva aqui...',
            filled: true,
            fillColor: Color.fromRGBO(0, 20, 137, 1),
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  Widget _buildReportButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () {
            // Ação do botão Reportar
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Reportar',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
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
