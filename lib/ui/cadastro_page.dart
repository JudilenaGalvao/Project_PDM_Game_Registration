import 'package:flutter/material.dart';
import 'package:segunda_prova/helpers/jogo_helper.dart';
import 'package:segunda_prova/ui/home_page.dart';
import 'package:segunda_prova/widgets/custom_form_field.dart';
import 'package:segunda_prova/widgets/custom_rating_bar.dart';

import '../domain/jogo.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Jogos"),
      ),
      body: const FormJogoBody(),
      backgroundColor: Colors.lightBlue[50],
    );
  }
}

class FormJogoBody extends StatefulWidget {
  const FormJogoBody({
    super.key,
  });

  @override
  State<FormJogoBody> createState() => _FormJogoBodyState();
}

class _FormJogoBodyState extends State<FormJogoBody> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final generoController = TextEditingController();
  final desenvolvedoresController = TextEditingController();
  final anoPublicacaoController = TextEditingController();
  final modosDeJogoController = TextEditingController();
  final precoController = TextEditingController();
  double avaliacao = 0.0;

  final jogoHelper = JogoHelper();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tela Cadastro",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            CustomFormField(
              controller: nomeController,
              labelText: "nome",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um nome';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: generoController,
              labelText: "genero",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione um genero';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: desenvolvedoresController,
              labelText: "desenvolvedores",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione os desenvolvedores';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: anoPublicacaoController,
              labelText: "anoPublicacao",
              keyboard_type: TextInputType.number,
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione o ano da publicação';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: modosDeJogoController,
              labelText: "modosDeJogo",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione o modo de jogo';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: precoController,
              labelText: "preço",
              keyboard_type: TextInputType.number,
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione o preço';
                }
                return null;
              },
            ),
            CustomRatingBar(
              ratingFunction: (value) {
                avaliacao = value;
              },
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Jogo j = Jogo(
                      nomeController.text,
                      generoController.text,
                      desenvolvedoresController.text,
                      int.parse(anoPublicacaoController.text),
                      modosDeJogoController.text,
                      double.parse(precoController.text),
                      avaliacao);
                  jogoHelper.saveJogo(j);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: const Text('Cadastro realizado com sucesso!'),
                    ),
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaHome()),
                    (route) => false,
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Cadastrar",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
