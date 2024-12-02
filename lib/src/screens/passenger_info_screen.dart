import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/global/globalVariables.dart';

class PassengerInfoScreen extends StatefulWidget {
  @override
  _PassengerInfoScreenState createState() => _PassengerInfoScreenState();
}

class _PassengerInfoScreenState extends State<PassengerInfoScreen> {
  late Map<String, dynamic> passenger;

  @override
  void initState() {
    super.initState();
    passenger =
        Provider.of<GlobalVariables>(context, listen: false).passengerResponse!;
    _onScreenRendered();
  }

  void _onScreenRendered() {
    print(passenger);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildAppDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
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
                SizedBox(height: 10),

                _buildGreetingSection(context),
                _buildThickerDivider(),
                SizedBox(height: 20),

                Center(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 400), // Limita a largura
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildProfileImage(passenger["image"]),
                        SizedBox(height: 30), // Aumenta o espaçamento
                        _buildNameField(),
                        SizedBox(height: 15), // Aumenta o espaçamento
                        _buildSurnameField(),
                        SizedBox(height: 15),
                        _buildCPFField(),
                        SizedBox(height: 15),
                        _buildReasonField(),
                        SizedBox(height: 15),
                        _buildRightField(),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
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
        Padding(
          padding: const EdgeInsets.only(left: 60.0, top: 8),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Verificar Cadastro Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Builder(
              builder: (context) => IconButton(
                    icon: Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
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

  Widget _buildProfileImage(String? imageUrl) {
    return CircleAvatar(
      radius: 80, 
      backgroundColor: Colors.grey[300],
      backgroundImage: imageUrl != null && imageUrl.isNotEmpty
          ? NetworkImage(imageUrl)
          : null,
      child: imageUrl == null || imageUrl.isEmpty
          ? Icon(
              Icons.person,
              size: 70, 
              color: Colors.black54,
            )
          : null,
    );
  }

  Widget _buildNameField() {
    return _buildField('Nome', passenger["name"].split(" ")[0]);
  }

  Widget _buildSurnameField() {
    return _buildField('Sobrenome', passenger["name"].split(" ")[1]);
  }

  Widget _buildCPFField() {
    return _buildField('C.P.F.', passenger["cpf"]);
  }

  Widget _buildReasonField() {
    return _buildField('Motivo da Gratuidade', passenger['justificationType']);
  }

  Widget _buildRightField() {
    return _buildField(
        'Direito à Gratuidade', passenger['justificationDetails']);
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: 50, 
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 20, 137, 1),
              borderRadius: BorderRadius.circular(8), 
              border: Border.all(color: Colors.grey, width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0), 
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16), 
            ),
          ),
        ),
      ],
    );
  }
}
