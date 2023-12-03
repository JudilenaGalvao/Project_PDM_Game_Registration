import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/jogo.dart';
import 'package:segunda_prova/helpers/jogo_helper.dart';

class TelaAltera extends StatefulWidget {
  final int id;

  TelaAltera({Key? key, required this.id}) : super(key: key);

  @override
  _TelaAlteraState createState() => _TelaAlteraState();
}

class _TelaAlteraState extends State<TelaAltera> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final generoController = TextEditingController();
  final desenvolvedoresController = TextEditingController();
  final anoPublicacaoController = TextEditingController();
  final modosDeJogoController = TextEditingController();
  final precoController = TextEditingController();
  double rating = 0.0;

  final jogoHelper = JogoHelper();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Jogo? jogo = await jogoHelper.getJogo(widget.id);

    setState(() {
      nomeController.text = jogo!.nome;
      generoController.text = jogo.genero;
      desenvolvedoresController.text = jogo.desenvolvedores;
      anoPublicacaoController.text = jogo.anoPublicacao.toString();
      modosDeJogoController.text = jogo.modosDeJogo;
      precoController.text = jogo.preco.toString();
      double avaliacao = jogo.avaliacao;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alterar Jogo"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: generoController,
                decoration: const InputDecoration(labelText: 'Genero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: desenvolvedoresController,
                decoration: const InputDecoration(labelText: 'Desenvolvedores'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: anoPublicacaoController,
                decoration: const InputDecoration(labelText: 'Ano Publicado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: modosDeJogoController,
                decoration: const InputDecoration(labelText: 'Modos de jogo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Jogo jogo = Jogo(
                      nomeController.text,
                      generoController.text,
                      desenvolvedoresController.text,
                      int.parse(anoPublicacaoController.text),
                      modosDeJogoController.text,
                      double.parse(precoController.text),
                      rating,
                    );

                    await jogoHelper.updateJogo(jogo);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Alteração realizada com sucesso!'),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
