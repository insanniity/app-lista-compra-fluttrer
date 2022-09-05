import 'package:app_lista_compra_fluttrer/screens/produtos_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_lista_compra_fluttrer/screens/widgets/menu_drawer.dart';
import 'package:app_lista_compra_fluttrer/util/ProdutosHelpers.dart';


import '../model/Produtos.dart';


class TelaCadastro extends StatefulWidget {
  Produtos? produto;

  TelaCadastro({Key? key, this.produto}) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtFornecedor = TextEditingController();
  TextEditingController txtPreco = TextEditingController();

  String txtBotao = 'Adicionar produto';
  String txtAppBar = 'Cadastrar produto';

  int? idProduto;

  ProdutosHelpers db = ProdutosHelpers();

  void salvarProduto({Produtos? p}) async {
    final navigator = Navigator.of(context);
    setState(() async {
      int? res;
      if(p == null){
        Produtos obj = Produtos(id: null, nome: txtNome.text, fornecedor: txtFornecedor.text, preco: double.parse(txtPreco.text));
        res = await db.addProduto(obj);
      }else{
        p.nome = txtNome.text;
        p.fornecedor = txtFornecedor.text;
        p.preco = double.parse(txtPreco.text);
        p.id = idProduto;
        res = await db.alterarProduto(p);
      }
      navigator.pop();
      navigator.push(MaterialPageRoute(builder: (context) => const TelaProdutos()));
    });
  }


  @override
  void initState() {
    super.initState();
    if(widget.produto != null){
      idProduto = widget.produto!.id;
      txtNome.text = widget.produto!.nome;
      txtFornecedor.text = widget.produto!.fornecedor;
      txtPreco.text = widget.produto!.preco.toString();
      txtBotao = 'Editar produto';
      txtAppBar = 'Editar produto';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txtAppBar),
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
                          onPressed: (){
                            salvarProduto(p: widget.produto);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            onPrimary: Colors.white,
                          ),
                          child:Text(txtBotao, style:const TextStyle(fontSize: 16),),
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
