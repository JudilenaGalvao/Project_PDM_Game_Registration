import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/jogo.dart';
import 'package:segunda_prova/helpers/jogo_helper.dart';

class TelaDetalhes extends StatefulWidget {
  final int id;

  const TelaDetalhes({Key? key, required this.id}) : super(key: key);

  @override
  _TelaDetalhesState createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  late Future<Jogo?> _jogoFuture;
  final JogoHelper _jogoHelper = JogoHelper();

  @override
  void initState() {
    super.initState();
    _jogoFuture = _jogoHelper.getJogo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          'Detalhes',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: FutureBuilder<Jogo?>(
          future: _jogoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text('Nenhum dado encontrado'),
              );
            } else {
              final Jogo jogo = snapshot.data!;
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfo('Nome:', jogo.nome),
                      _buildInfo('Gênero:', jogo.genero),
                      _buildInfo('Desenvolvedores:', jogo.desenvolvedores),
                      _buildInfo(
                          'Ano de Publicação:', jogo.anoPublicacao.toString()),
                      _buildInfo('Modos de Jogo:', jogo.modosDeJogo),
                      _buildInfo('Preço:', jogo.preco.toString()),
                      _buildInfo('Avaliação:', jogo.avaliacao.toString()),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
