import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './globalVariables.dart';

class TelaVerificarCadastroEncontrado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final passenger = Provider.of<GlobalVariables>(context, listen: false).passengerResponse!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Barra superior ajustada
          _buildTopBar(),
          // Conteúdo principal com limite de largura
          Expanded(
            child: Center(
              child: Container(
                width: 600, // Limita a largura do conteúdo
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGreetingSection(context),
                    _buildThickerDivider(),
                    // Foto do passageiro antes do nome
                    _buildPhotoSection(passenger["image"]),
                    _buildInfoField('Nome', passenger["name"].split(" ")[0]),
                    _buildInfoField('Sobrenome', passenger["name"].split(" ")[1]),
                    _buildInfoField('C.P.F.', passenger["cpf"]),
                    _buildInfoField('Motivo da Gratuidade', passenger["justificationType"]),
                    _buildInfoField('direitoGratuidade', passenger["justificationDetails"]),
                  ],
                ),
              ),
            ),
          ),
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
          'Verificar Cadastro Usuário',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Alinha os textos ao centro
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, // Centraliza o texto
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 20, 137, 1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center, // Centraliza o texto dentro da caixa
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoSection(String? imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Foto do Passageiro',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, // Centraliza o texto
        ),
        const SizedBox(height: 8),
        Center(
          child: CircleAvatar(
            radius: 80, // Tamanho ajustado
            backgroundColor: Colors.grey[300],
            backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : null,
            child: imageUrl == null || imageUrl.isEmpty
                ? const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.black54,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
