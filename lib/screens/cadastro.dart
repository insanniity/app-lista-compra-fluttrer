import 'package:flutter/material.dart';
import 'package:app_lista_compra_fluttrer/screens/widgets/menu_drawer.dart';
import 'package:app_lista_compra_fluttrer/util/ProdutosHelpers.dart';


import '../model/Produtos.dart';


class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtFornecedor = TextEditingController();
  TextEditingController txtPreco = TextEditingController();

  ProdutosHelpers db = ProdutosHelpers();

  void salvarProduto() async {
    Produtos obj = Produtos(null, txtNome.text, txtFornecedor.text, double.parse(txtPreco.text));
    int res = await db.addProduto(obj);
    if(res != null){
      print("Cadastrado com sucesso: $res");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de produto"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: menuDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const  EdgeInsets.all(8.0),
          child: Form(
                key: null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: txtNome,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(labelText: "Alimento"),
                      style:const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 60,),
                    TextFormField(
                      controller: txtFornecedor,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(labelText: "Fornecedor"),
                      style:const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 60,),
                    TextFormField(
                      controller: txtPreco,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(labelText: "Preço"),
                      style:const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: salvarProduto,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            onPrimary: Colors.white,
                          ),
                          child:const Text("Adicionar produto", style: TextStyle(fontSize: 16),),
                      ),
                    ),
                  ],
                ),
              ),
        )
      ),
    );
  }
}
