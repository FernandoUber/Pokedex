import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pokedex2/components/pokemon_tile.dart';
import 'package:pokedex2/models/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int page = 0;
  String? urlImagem;

  List<Pokemon> pokemons = [];

  void getPokemons() async {
    try {
      var response = await Dio().get(
          'https://pokeapi.co/api/v2/pokemon?limit=50&offset=${page * 50}');

      print(response);
      setState(() {
        // urlImagem = response.data['sprites']['front_default'];
        pokemons = (response.data['results'] ?? [])
            .map<Pokemon>((pokemon) => Pokemon.fromJson(pokemon))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // criando um Listview, chamando o método construtor nomeado;
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Esta Pokédex vai retornar o nome dos 50 pokémons!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (BuildContext context, int index) => PokemonTile(
                pokemon: pokemons[index],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          page++;
          getPokemons();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
