import 'package:segunda_prova/domain/jogo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class JogoHelper {
  static final JogoHelper _instance = JogoHelper.internal();

  factory JogoHelper() => _instance;
  JogoHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    if (databasesPath == null) databasesPath = "";
    String path = join(databasesPath, "jogos.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE ${Jogo.jogoTable}(${Jogo.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "                                 ${Jogo.nomeColumn} TEXT, "
          "                                 ${Jogo.generoColumn} TEXT, "
          "                                 ${Jogo.desenvolvedoresColumn} TEXT, "
          "                                 ${Jogo.anoPublicacaoColumn} INTEGER, "
          "                                 ${Jogo.modosDeJogoColumn} TEXT, "
          "                                 ${Jogo.precoColumn} DOUBLE,"
          "                                 ${Jogo.avaliacaoColumn} REAL) ");
    });
  }

  Future<Jogo> saveJogo(Jogo j) async {
    Database? dbJogo = await db;
    if (dbJogo != null) {
      j.id = await dbJogo.insert(Jogo.jogoTable, j.toMap());
    }
    return j;
  }

  Future<Jogo?> getJogo(int id) async {
    Database? dbJogo = await db;
    if (dbJogo != null) {
      List<Map> maps = await dbJogo.query(Jogo.jogoTable,
          columns: [
            Jogo.idColumn,
            Jogo.nomeColumn,
            Jogo.generoColumn,
            Jogo.desenvolvedoresColumn,
            Jogo.anoPublicacaoColumn,
            Jogo.modosDeJogoColumn,
            Jogo.precoColumn,
            Jogo.avaliacaoColumn
          ],
          where: "${Jogo.idColumn} = ?",
          whereArgs: [id]);
      if (maps.length > 0)
        return Jogo.fromMap(maps.first);
      else
        return null;
    }
    return null;
  }

  Future<int> updateJogo(Jogo j) async {
    Database? dbJogo = await db;
    if (dbJogo != null) {
      print('Antes de atualizar: $j');
      int result = await dbJogo.update(Jogo.jogoTable, j.toMap(),
          where: "${Jogo.idColumn} = ?", whereArgs: [j.id]);
      print('Após a atualização: $result');
      return result;
    } else {
      return 0;
    }
  }

  Future<List> getAll() async {
    Database? dbJogo = await db;
    if (dbJogo != null) {
      List listMap = await dbJogo.query(Jogo.jogoTable);
      List<Jogo> listJogo = [];

      for (Map m in listMap) {
        listJogo.add(Jogo.fromMap(m));
      }
      return listJogo;
    } else {
      return [];
    }
  }
}
