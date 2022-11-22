import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class PokemonTile extends StatelessWidget {
  const PokemonTile({required this.pokemon, Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: pokemon.spriteUrl.isNotEmpty
          ? CircleAvatar(backgroundImage: NetworkImage(pokemon.spriteUrl))
          : null,
      title: Text(
        pokemon.nome,
        textAlign: TextAlign.center,
      ),
    );
  }
}
