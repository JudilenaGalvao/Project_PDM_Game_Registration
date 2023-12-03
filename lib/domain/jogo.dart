class Jogo{

  static const String jogoTable = "jogoTable";
  static const String idColumn = "id";
  static const String nomeColumn = "nome";
  static const String generoColumn = "genero";
  static const String desenvolvedoresColumn = "desenvolvedores";
  static const String anoPublicacaoColumn = "anoPublicacao";
  static const String modosDeJogoColumn = "modosDeJogo";
  static const String precoColumn = "preco";
  static const String avaliacaoColumn = "avaliacao";

  int id = 0;
  String nome = '';
  String genero = '';
  String desenvolvedores = '';
  int anoPublicacao = 0;
  String modosDeJogo = '';
  double preco = 0;
  double avaliacao = 0;

  Jogo(this.nome, this.genero, this.desenvolvedores, this.anoPublicacao, this.modosDeJogo, this.preco, this.avaliacao);

  Jogo.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    genero = map[generoColumn];
    desenvolvedores = map[desenvolvedoresColumn];
    anoPublicacao = map[anoPublicacaoColumn];
    modosDeJogo = map[modosDeJogoColumn];
    preco = map[precoColumn];
    avaliacao = map[avaliacaoColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      nomeColumn: nome,
      generoColumn: genero,
      desenvolvedoresColumn: desenvolvedores,
      anoPublicacaoColumn:anoPublicacao,
      modosDeJogoColumn:modosDeJogo,
      precoColumn: preco,
      avaliacaoColumn:avaliacao
    };
  }

  @override
  String toString() {
    return 'Jogo{nome: $nome, genero: $genero, desenvolvedores: $desenvolvedores, anoPublicacao: $anoPublicacao, modosDeJogo: $modosDeJogo, preco: $preco, avaliacao: $avaliacao}';
  }
}