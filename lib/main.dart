import 'dart:html';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Início da Pokedex em Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? urlImagem;

  List pokemons = [];

  void getHttp() async {
    try {
      var response =
          await Dio().get('https://pokeapi.co/api/v2/pokemon?limit=50');

      print(response);
      setState(() {
        // urlImagem = response.data['sprites']['front_default'];
        pokemons = response.data['results'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // criando um Listview, chamando o método construtor nomeado;
      body: Column(children: [
        Text('Esta Pokédex vai retornar o nome dos 50 pokémons!'),
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                width: double.maxFinite,
                height: 75,
                child: Text(pokemons[index]['name']),
              );
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: getHttp,
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
