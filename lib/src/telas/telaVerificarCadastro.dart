import 'package:flutter/material.dart';

class TelaVerificarCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Cabeçalho (Barra Superior + Título)
          _buildHeader(),
          // Conteúdo principal centralizado verticalmente
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildCentralContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cabeçalho que inclui a barra superior e o título
  Widget _buildHeader() {
    return Column(
      children: [
        // Barra superior
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/barraMetro.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Título da página
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: const Text(
              'Verificar Passageiro',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
      ],
    );
  }

  // Conteúdo centralizado
  Widget _buildCentralContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Campo de CPF
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Digite o C.P.F. Do Usuário',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 400, // Define a largura máxima do campo
              child: TextField(
                obscureText: false,
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
            ),
          ],
        ),
        const SizedBox(height: 20), // Espaço entre o campo e o botão
        // Botão Verificar
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () {
              // Ação do botão Verificar
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Verificar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
