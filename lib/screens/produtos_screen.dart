import 'package:app_lista_compra_fluttrer/screens/widgets/menu_drawer.dart';
import 'package:app_lista_compra_fluttrer/util/ProdutosHelpers.dart';
import 'package:flutter/material.dart';

import '../model/Produtos.dart';
import 'cadastro_screen.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({Key? key}) : super(key: key);

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {

  ProdutosHelpers db = ProdutosHelpers();
  List<Produtos> listaProdutos = [];

  void recuperarProdutos () async {
    List produtosRecuperados = await db.listarProdutos();
    List<Produtos> listaTemp = [];

    for(var item in produtosRecuperados){
      Produtos obj = Produtos.fromMap(item);
      listaTemp.add(obj);
    }

    setState(() {
      listaProdutos = listaTemp;
    });

  }

  void removeProduto (int? id) async {
    int resultado = await db.deleteProduto(id);
    recuperarProdutos();
  }

  void confirmarDelete (int? id) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Excluir produto"),
            content:  const Text("Você tem certeza que deseja excluir o produto?"),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: (){
                  removeProduto(id);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text("Sim"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text("Não"),
              )
            ],
          );
        }
    );
  }




  @override
  void initState() {
    super.initState();
    recuperarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Produtos"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: menuDrawer(context),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: listaProdutos.length,
                itemBuilder: (context, index) {
                  final Produtos p = listaProdutos[index];
                  return Card(
                    child: ListTile(
                      title: Text(p.nome, style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      subtitle: Text("R\$ ${p.preco}", style:const TextStyle(fontSize: 15, color: Colors.red),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadastro(produto: p)));
                            },
                            child: const Padding(
                              padding:EdgeInsets.only(right: 16),
                              child: Icon(Icons.edit, color: Colors.blue,),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              confirmarDelete(p.id);
                            },
                            child: const  Padding(
                              padding:EdgeInsets.only(right: 16),
                              child: Icon(Icons.delete, color: Colors.red,),
                            )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}
