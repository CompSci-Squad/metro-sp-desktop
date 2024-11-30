import 'package:flutter/material.dart';

class TelaCadastrarNovoUsuario extends StatelessWidget {
  final List<String> reasons = ["Idade", "P.C.D.", "Desempregado", "Policial"];
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Barra superior ajustada
          _buildTopBar(),
          // Conteúdo principal com limite de altura
          Expanded(
            child: Center(
              child: Container(
                width: 600, // Limita a largura do conteúdo
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGreetingSection(context), // Inclui a seta no título
                    _buildThickerDivider(),
                    _buildCPFField(),
                    _buildNameField(),
                    _buildSurnameField(),
                    _buildReasonField(),
                    _buildRightField(),
                    _buildNumeroBilheteUnicoField(),
                    _buildPhotoSection(),
                    _buildSubmitButton(),
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
          'Cadastro de Novos Passageiros',
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

  Widget _buildCPFField() {
    return _buildField(
      label: 'Digite o C.F.P. Do Passageiro',
      hintText: '***.***.***-**',
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildNameField() {
    return _buildField(
      label: 'Digite O Nome do Passageiro',
      hintText: '________',
    );
  }

  Widget _buildSurnameField() {
    return _buildField(
      label: 'Digite o Sobrenome Do Passageiro',
      hintText: '________',
    );
  }

  Widget _buildRightField() {
    return _buildField(
      label: 'Digite direitoGratuidade',
      hintText: '',
    );
  }

  Widget _buildNumeroBilheteUnicoField() {
    return _buildField(
      label: 'Digite o Número do Bilhete Único de Gratuidade (Se o Passageiro Possuir)',
      hintText: '***.***.***-**',
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildReasonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione O Motivo da Gratuidade',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedReason,
          items: reasons.map((String reason) {
            return DropdownMenuItem<String>(
              value: reason,
              child: Text(reason, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            selectedReason = newValue;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          style: const TextStyle(color: Colors.white),
          dropdownColor: const Color.fromRGBO(0, 20, 137, 1),
        ),
      ],
    );
  }

  Widget _buildField({required String label, required String hintText, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: keyboardType ?? TextInputType.text,
        ),
      ],
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fotografe o Passageiro',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Ação para tirar foto
              },
              icon: const Icon(Icons.camera_alt, size: 40, color: Colors.black),
            ),
            const SizedBox(width: 100),
            IconButton(
              onPressed: () {
                // Ação para visualizar foto
              },
              icon: const Icon(Icons.person, size: 40, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Ação do botão Cadastrar
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'Cadastrar',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
