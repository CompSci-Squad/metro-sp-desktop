import 'package:flutter/material.dart';
import 'src/telas/telaCadastrarNovoUsuario.dart';
import 'src/telas/telaPerfil.dart';
import 'src/telas/telaVerificarStatusTotemEncontrado.dart';
import 'src/telas/telaVerificarCadastro.dart';
import 'src/telas/telaVerificarStatusTotem.dart';
import 'src/telas/telaReportarFalhaTotem.dart';
import 'src/telas/telaDesbloquearTotem.dart';
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
        '/telaInicial': (context) => telaInicial(),
        '/telaVerificarCadastro': (context) => telaVerificarCadastro(),
        '/telaVerificarStatusTotem': (context) => telaVerificarStatusTotem(),
        '/telaVerificarStatusTotemEncontrado': (context) => telaVerificarStatusTotemEncontrado(),
        '/telaReportarFalhaTotem' : (context) => telaReportarFalhaTotem(),
        '/telaDesbloquearTotem': (context) => telaDesbloquearTotem(),
        '/telaPerfil': (context) => telaPerfil(),
        '/telaCadastrarNovoUsuario': (context) => telaCadastrarNovoUsuario(),
        // Adicione mais rotas aqui conforme criar novas telas
      },
    );
  }
}
