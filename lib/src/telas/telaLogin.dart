import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  // Função para exibir o diálogo de "Esqueci minha senha"
  void _showForgotPasswordDialog() {
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
                'Caso tenha esquecido a senha, favor entrar em contato com setor de T.I. por meio de ti@metro.com, com assunto "Esqueci minha senha". Informar também seu número de registro.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBarraSuperior(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Acesse',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'com e-mail e senha para entrar',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildCheckboxESenha(context),
            const SizedBox(height: 20),
            _submitButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Barra superior
  Widget _buildBarraSuperior() {
    return Container(
      width: double.infinity,
      height: 28,
      child: Image.asset(
        'assets/barraMetro.png',
        fit: BoxFit.cover,
      ),
    );
  }

  // Campo de e-mail
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('E-mail', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: 'Digite seu e-mail @metro',
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  // Campo de senha
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Digite sua senha', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Digite sua senha',
            filled: true,
            fillColor: const Color.fromRGBO(0, 20, 137, 1),
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  // Checkbox e "Esqueci minha senha"
  Widget _buildCheckboxESenha(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
              ),
              const Text('Lembrar minha senha'),
            ],
          ),
          TextButton(
            onPressed: _showForgotPasswordDialog,
            child: const Text(
              'Esqueci minha senha',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Botão de login
  Widget _submitButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/telaInicial');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'Acessar',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
