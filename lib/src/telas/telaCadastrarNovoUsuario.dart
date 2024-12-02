import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class TelaCadastrarNovoUsuario extends StatefulWidget {
  @override
  _TelaCadastrarNovoUsuarioState createState() =>
      _TelaCadastrarNovoUsuarioState();
}

class _TelaCadastrarNovoUsuarioState extends State<TelaCadastrarNovoUsuario> {
  final List<String> reasons = ["Idade", "P.C.D.", "Desempregado", "Policial"];
  String? selectedReason;

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  Future<void> _submitUser() async {
    final String cpf = _cpfController.text;
    final String nome = _nomeController.text;
    final String sobrenome = _sobrenomeController.text;
    final String descricao = _descricaoController.text;

    if (cpf.isEmpty || nome.isEmpty || sobrenome.isEmpty || descricao.isEmpty) {
      _showErrorDialog();
      return;
    }

    print('CPF: $cpf');
    print('Nome: $nome');
    print('Sobrenome: $sobrenome');
    print('Descrição: $descricao');

    final postResponse = await apiService.post('/login', {
      'CPF': cpf,
      'Nome': nome,
      'Sobrenome': sobrenome,
      'Descrição': descricao,
    });

    print(postResponse);

    if (!postResponse.containsKey("accessToken")) {
      _showErrorDialog();
    } else {
      print("Cadastro realizado com sucesso!");
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Dados Incompletos',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color.fromRGBO(0, 20, 137, 1)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Center(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGreetingSection(context),
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
      height: 80,
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
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 16),
        const Text(
          'Cadastro de Novo Passageiro',
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
      controller: _cpfController,
      label: 'Digite o C.P.F. Do Passageiro',
      hintText: '***.***.***-**',
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildNameField() {
    return _buildField(
      controller: _nomeController,
      label: 'Digite O Nome do Passageiro',
      hintText: '________',
    );
  }

  Widget _buildSurnameField() {
    return _buildField(
      controller: _sobrenomeController,
      label: 'Digite o Sobrenome Do Passageiro',
      hintText: '________',
    );
  }

  Widget _buildRightField() {
    return _buildField(
      controller: _descricaoController,
      label: 'Digite direitoGratuidade',
      hintText: '',
    );
  }

  Widget _buildNumeroBilheteUnicoField() {
    return _buildField(
      label: 'Digite o Número do Bilhete Único de Gratuidade (Se o Passageiro Possuir)',
      hintText: '***.***.***-**',
      keyboardType: TextInputType.number,
      controller: null,
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

  Widget _buildField({
    required TextEditingController? controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
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
              onPressed: () {},
              icon: const Icon(Icons.camera_alt, size: 40, color: Colors.black),
            ),
            const SizedBox(width: 100),
            IconButton(
              onPressed: () {},
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
          _submitUser();
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
