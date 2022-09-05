import 'package:app_lista_compra_fluttrer/screens/cadastro_screen.dart';
import 'package:app_lista_compra_fluttrer/screens/produtos_screen.dart';
import 'package:flutter/material.dart';

import '../cadastro_screen.dart';


Widget menuDrawer (BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          width: double.infinity,
          height: 250,
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top:30),
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("images/grocery-1232944_960_720.jpg"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                const SizedBox( height: 10),
                const Text(
                    "Minhas compras",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox( height: 10),
                const Text(
                    "Desenvolvido por insannity",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.food_bank, color: Colors.blueGrey,),
          title: const Text("Meus Produtos", style:  TextStyle(fontSize: 16),),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaProdutos()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.add, color: Colors.blueGrey,),
          title: const Text("Novo Produto", style: TextStyle(fontSize: 16),),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadastro()));
          },
        ),
      ],
    ),
  );
}