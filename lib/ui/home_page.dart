import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/jogo.dart';
import 'package:segunda_prova/helpers/jogo_helper.dart';
import 'package:segunda_prova/ui/ScreenDetails.dart';
import 'package:segunda_prova/ui/altera_page.dart';
import 'package:segunda_prova/ui/cadastro_page.dart';
import 'package:segunda_prova/ui/sobre_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: TelaHome(),
    );
  }
}

class TelaHome extends StatelessWidget {
  const TelaHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Jogos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TelaSobre(),
                ),
              );
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue[100]!, Colors.white],
          ),
        ),
        child: const HomeBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.red[100],
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final jogoHelper = JogoHelper();
  late Future<List> jogo;

  @override
  void initState() {
    super.initState();
    jogo = jogoHelper.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: jogo,
      builder: (context, snapshot) {
        return snapshot.hasData  ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return HomeItem(jogo: snapshot.data![i]);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class HomeItem extends StatelessWidget {
  final Jogo jogo;
  const HomeItem({Key? key, required this.jogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaDetalhes(id: jogo.id)),
        );
      },
      onLongPress: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaAltera(id: jogo.id)),
        );
      },
      child: ListTile(
        title: Text(jogo.nome),
        subtitle: Text('Preço: ${jogo.preco.toStringAsFixed(2)}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Avaliação: ${jogo.avaliacao.toStringAsFixed(1)}'),
            SizedBox(
              width: 85,
              height: 12,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDetalhes(id: jogo.id),
                    ),
                  );
                },
                child: const Text(
                  'Detalhes',
                  style: TextStyle(fontSize: 9),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 85,
              height: 12,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaAltera(id: jogo.id),
                    ),
                  );
                },
                child: const Text(
                  'Editar',
                  style: TextStyle(fontSize: 9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



