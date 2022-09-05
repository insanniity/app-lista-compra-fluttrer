import 'dart:io';
import 'package:app_lista_compra_fluttrer/model/Produtos.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProdutosHelpers {

  static Database? _database;
  static final ProdutosHelpers _databasehelper = ProdutosHelpers._createInstance();

  String nomeTabela = 'tb_produtos';

  String colunaId     = 'id';
  String colunaNome   = 'nome';
  String colunaForn   = 'fornecedor';
  String colunaPreco  = 'preco';

  ProdutosHelpers._createInstance();

  factory ProdutosHelpers(){
    return _databasehelper;
  }

  void _criarBanco (Database db, int version) async {
    String sql = """CREATE TABLE $nomeTabela(
                    $colunaId INTEGER PRIMARY KEY AUTOINCREMENT,
                    $colunaNome Text,
                    $colunaForn Text,
                    $colunaPreco float
                  )""";

    await db.execute(sql);
  }

  Future<Database> inicializaBanco ( )async{
    Directory directory = await getApplicationDocumentsDirectory();
    String caminho = '${directory.path}bdprodutos.bd';
    var bd = await openDatabase(caminho, version: 1, onCreate: _criarBanco);

    return bd;
  }

  Future<Database> get database async {
    _database ??= await inicializaBanco();
    return _database!;
  }

  listarProdutos () async {
    Database db = await database;
    String sql = 'SELECT * FROM $nomeTabela';
    List lista = await db.rawQuery(sql);
    return lista;
  }

  Future<int> addProduto (Produtos obj) async {
    Database db = await database;
    var res = await db.insert(nomeTabela, obj.toMap());
    return res;
  }

  Future<int> deleteProduto(int? id) async {
    Database db = await database;
    var res = await db.delete(nomeTabela, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> alterarProduto(Produtos obj) async {
    Database db = await database;
    var res = await db.update(nomeTabela, obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
    return res;
  }


}




