import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/services/apiService.dart';
import '../shared/global/globalVariables.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isInputValid(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<void> _submitLogin() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (!_isInputValid(email, password)) {
      _showDialog('Por favor, preencha todos os campos.');
      return;
    }

    _showLoading(true);

    try {
      final postResponse = await apiService.post('/login', {
        'email': email.trim(),
        'password': password.trim(),
      });

      if (_isLoginSuccessful(postResponse)) {
        await _handleSuccessfulLogin(postResponse["access_token"], email);
      } else {
        _showDialog('E-mail ou senha incorreto. Por favor, tente novamente.');
      }
    } catch (e) {
      print(e);
      _showDialog(
        'Erro ao realizar o login. Verifique sua conexão ou tente novamente.',
        backgroundColor: Colors.red,
      );
    } finally {
      _showLoading(false);
    }
  }

  bool _isLoginSuccessful(Map<String, dynamic> response) {
    return response.containsKey("access_token");
  }

  Future<void> _handleSuccessfulLogin(String token, String email) async {
    apiService.setAuthToken(token);
    final user = await apiService.get('/user/$email');
    Provider.of<GlobalVariables>(context, listen: false).setUser(user);
    Navigator.pushReplacementNamed(context, '/telaInicial');
  }

  void _showLoading(bool isLoading) {
    setState(() {
    });
  }

  void _showDialog(String message,
      {Color backgroundColor = const Color.fromRGBO(0, 20, 137, 1)}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(color: Colors.white),
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
          _buildBarraSuperior(), 
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 500, 
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Acesse',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'com e-mail e senha para entrar',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    _buildEmailField(),
                    const SizedBox(height: 20),
                    _buildPasswordField(),
                    const SizedBox(height: 20),
                    _buildCheckboxESenha(context),
                    const SizedBox(height: 20),
                    _submitButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarraSuperior() {
    return Container(
      width: double.infinity,
      height: 100,
      child: Image.asset(
        'assets/barraMetro.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('E-mail', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          controller: _emailController,
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

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Digite sua senha', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          controller: _passwordController,
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

  Widget _buildCheckboxESenha(BuildContext context) {
    return Row(
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
          onPressed: () {
            // Implementar a lógica de "Esqueci minha senha"
          },
          child: const Text(
            'Esqueci minha senha',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () {
            _submitLogin();
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
