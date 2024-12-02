import 'package:flutter/material.dart';
import 'package:tela_login/src/screens/log_screen.dart';
import 'src/shared/global/globalVariables.dart';
import 'src/screens/register_passenger_screen.dart';
import 'src/screens/profile_screen.dart';
import 'src/screens/verify_passenger_screen.dart';
import 'src/screens/passenger_info_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/inicial_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(
    create: (_) => GlobalVariables(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Define a tela de login como inicial
      routes: {
        '/': (context) => LoginScreen(),
        '/telaInicial': (context) => const InicialScreen(),
        '/telaVerificarCadastro': (context) => VerifyPassengerScreen(),
        '/telaPerfil': (context) => ProfileScreen(),
        '/telaCadastrarNovoUsuario': (context) =>
            const RegisterPassengerScreen(),
        '/telaVerificarCadastroEncontrado': (context) =>
            PassengerInfoScreen(),
        '/telaLog': (context) => LogScreen()
      },
    );
  }
}
