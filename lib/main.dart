import 'package:flutter/material.dart';
import 'package:metro_sp_desktop/src/telas/telaLog.dart';
import 'package:metro_sp_desktop/src/telas/telaVerificarCadastroEncontrado.dart';
import 'package:provider/provider.dart';
import 'src/telas/globalVariables.dart';
import 'src/telas/telaCadastrarNovoUsuario.dart';
import 'src/telas/telaPerfil.dart';

import 'src/telas/telaVerificarCadastro.dart';

import 'src/telas/telaLogin.dart';
import 'src/telas/telaInicial.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalVariables(),
      child: MyApp(),
    ));
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
        '/telaVerificarCadastroEncontrado': (context) => TelaVerificarCadastroEncontrado(),
        // Adicione mais rotas aqui conforme criar novas telas
      },
    );
  }
}
