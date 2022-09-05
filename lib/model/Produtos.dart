
class Produtos {

  int? id;
  late String nome;
  late String fornecedor;
  late double preco;

  Produtos({this.id, required this.nome,required this.fornecedor,required this.preco});

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