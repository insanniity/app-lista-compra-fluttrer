
class Produtos {

  int? id;
  String? nome;
  String? fornecedor;
  double? preco;

  Produtos({this.id, this.nome, this.fornecedor, this.preco});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'fornecedor': fornecedor,
      'preco': preco
    };
  }

  Produtos.fromMap(Map map){
    id = map['id'];
    nome = map['nome'];
    fornecedor = map['fornecedor'];
    preco = map['preco'];
  }


}