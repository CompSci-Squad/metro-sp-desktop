import 'package:flutter/material.dart';

class TelaLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Barra superior ajustada
          _buildTopBar(),
          // Conteúdo principal centralizado verticalmente
          Expanded(
            child: Center(
              child: Container(
                width: 600, // Limita a largura do conteúdo
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildHeaderSection(context),
                    _buildLogSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Barra superior com imagem ajustada
  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      height: 80, // Altura ajustada
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/barraMetro.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Cabeçalho com saudação e título
  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      children: [
        // Seta de voltar
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        const SizedBox(width: 16), // Espaçamento entre a seta e o texto
        const Text(
          'Registros de Usuários',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Seção de log com dados fictícios
  Widget _buildLogSection() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10, // Número de registros fictícios
        itemBuilder: (context, index) {
          return Column(
            children: [
              _buildLogItem(
                title: 'Registro #${index + 1}',
                date: '27/11/2024', // Data fictícia para exemplo
                time: '14:35', // Horário fictício para exemplo
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ],
          );
        },
      ),
    );
  }

  // Item individual do log (somente informações, sem funcionalidade de botão)
  Widget _buildLogItem({
    required String title,
    required String date, // Data mantida
    required String time, // Horário adicionado
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            date, // Exibição da data
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Text(
            time, // Exibição do horário
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
      leading: const Icon(
        Icons.info_outline,
        color: Colors.black54,
        size: 30,
      ),
    );
  }
}
