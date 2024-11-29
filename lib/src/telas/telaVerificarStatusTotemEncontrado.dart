import 'package:flutter/material.dart';

class telaVerificarStatusTotemEncontrado extends StatelessWidget {
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
            width: double.infinity, // Ocupa toda a largura da tela
            height: 28, // Define a altura para 28
            child: Image.asset(
              'assets/barraMetro.png', // Caminho da imagem
              fit: BoxFit.cover, // A imagem cobre a largura total
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
                  _buildOperationButtons(),
                  _buildEstacaoField(),
                  SizedBox(height: 5),
                  _buildStatusField(),
                  SizedBox(height: 5),
                  _buildLastDayField(),
                  SizedBox(height: 5),
                  _buildLastHourField(),
                  SizedBox(height: 5),
                  _buildHistoryField(),
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
          padding: const EdgeInsets.only(left: 80.0, top: 8.0, bottom: 8.0), // Ajusta o espaçamento ao redor do ListTile
          child: ListTile(
            contentPadding: EdgeInsets.zero, // Remove o padding interno do ListTile
            title: const Text(
              'Verificar Status Do Totem',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: 0, // Ícone alinhado bem ao canto esquerdo
          top: 8, // Alinhamento vertical com o ListTile
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                size: 43, // Tamanho do ícone
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre o Drawer ao clicar nas três barrinhas
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

  Widget _buildOperationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0), // Espaço extra ao redor dos botões
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 200, // Ajuste a largura conforme necessário
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a próxima tela
                    //Navigator.pushNamed(context, '');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
                    padding: EdgeInsets.symmetric(vertical: 20), // Aumenta a altura do botão
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
            )
          ],
        ),
      ),
    );
  }


  Widget _buildEstacaoField(/*String text*/) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Estação',
        style: TextStyle(fontSize: 12),
      ),
      SizedBox(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 20, 137, 1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
      ),
    ],
  );
}

Widget _buildStatusField(/*String text*/) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Status',
        style: TextStyle(fontSize: 12),
      ),
      SizedBox(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 20, 137, 1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
      ),
    ],
  );
}

Widget _buildLastDayField(/*String text*/) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Data Última Operação',
        style: TextStyle(fontSize: 12),
      ),
      SizedBox(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 20, 137, 1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
      ),
    ],
  );
}

Widget _buildLastHourField(/*String text*/) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Horário Última Operação',
        style: TextStyle(fontSize: 12),
      ),
      SizedBox(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 20, 137, 1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
      ),
    ],
  );
}

Widget _buildHistoryField(/*String text*/) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Verifique o histórico de falhas',
        style: TextStyle(fontSize: 12),
      ),
      SizedBox(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 20, 137, 1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          /*child: const Text(
            text, // O texto que será exibido, vindo do backend
            style: TextStyle(color: Colors.white, fontSize: 14),
          )*/
        ),
      ),
    ],
  );
}

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back, size: 30),
        onPressed: () {
          Navigator.pop(context); // Retorna à tela anterior
        },
      ),
    );
  }
}
