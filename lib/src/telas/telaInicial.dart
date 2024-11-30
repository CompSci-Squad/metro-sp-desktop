import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import necessário para abrir URLs

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Cabeçalho (Barra Superior + Saudações)
          _buildHeader(context),
          // Conteúdo principal centralizado verticalmente
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildCentralContent(context), // Contexto passado aqui
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cabeçalho que inclui a barra superior e as saudações
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Barra superior
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/barraMetro.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Saudações
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: const Text(
              'Olá, Nome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Verifique suas informações aqui',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/telaPerfil');
            },
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
      ],
    );
  }

  // Conteúdo Centralizado Verticalmente
  Widget _buildCentralContent(BuildContext context) {
    return Container(
      width: 800, // Define a largura máxima do conteúdo centralizado
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Mapa das vias
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Acesse O Mapa Completo Das Vias',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Fonte igual à do botão
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    _openLink(
                      'https://www.metro.sp.gov.br/sua-viagem/linhas-estacoes/',
                    );
                  },
                  child: Container(
                    width: 400, // Largura maior da imagem
                    height: 300, // Altura maior da imagem
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/linhasMetro.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32), // Espaço entre o mapa e os botões
          // Operações principais
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Principais Operações',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Fonte igual à do botão
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Botão Cadastrar Novo Usuário
                buildStyledButton(
                  context,
                  'Cadastrar Novo Passageiro',
                  () {
                    Navigator.pushNamed(context, '/telaCadastrarNovoUsuario');
                  },
                ),
                const SizedBox(height: 20), // Espaço entre os botões
                // Botão Verificar Registros
                buildStyledButton(
                  context,
                  'Verificar Registros',
                  () {
                    Navigator.pushNamed(context, '/telaLog');
                  },
                ),
                const SizedBox(height: 20), // Espaço entre os botões
                // Botão Verificar Passageiro
                buildStyledButton(
                  context,
                  'Verificar Passageiro',
                  () {
                    Navigator.pushNamed(context, '/telaVerificarCadastro');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Função para abrir o link no navegador
  void _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url); // Abre o link
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  // Botões estilizados
  ElevatedButton buildStyledButton(
    BuildContext context, // Adicionado aqui
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 20, 137, 1),
        padding: const EdgeInsets.symmetric(vertical: 20), // Altura maior
        minimumSize: const Size(250, 60), // Largura e altura maiores
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18), // Texto maior
      ),
    );
  }
}
