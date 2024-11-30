import 'package:flutter/material.dart';
import 'package:metro_sp_desktop/src/telas/telaLog.dart';
import 'src/telas/telaCadastrarNovoUsuario.dart';
import 'src/telas/telaPerfil.dart';

import 'src/telas/telaVerificarCadastro.dart';

import 'src/telas/telaLogin.dart';
import 'src/telas/telaInicial.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Define a tela de login como inicial
      routes: {
        '/': (context) => LoginPage(),
        '/telaInicial': (context) => TelaInicial(),
        '/telaVerificarCadastro': (context) => TelaVerificarCadastro(),
        '/telaPerfil': (context) => TelaPerfil(),
        '/telaCadastrarNovoUsuario': (context) => TelaCadastrarNovoUsuario(),
        '/telaLog': (context) => TelaLog(),
        // Adicione mais rotas aqui conforme criar novas telas
      },
    );
  }
}
