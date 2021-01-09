import 'package:flutter/material.dart';

import 'package:pokedex_egsys/data/pokemon.dart';
import 'package:pokedex_egsys/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../style.dart';

class PokemonListTile extends StatelessWidget {

  final PokemonData data;

  const PokemonListTile({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Hero(
            tag: data.name,
            child: Image.network(
              data.imageUrl,
              width: 100.0,
              height: 125.0,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(data.name.firstCaps, style: MyTypography.MEDIUM.get()),
        ),
        Divider()
      ],
    );
  }
}

class PokemonLoadingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Column(
        children: [
          ListTile(
            leading: Container(height: 125.0, width: 100.0, color: Colors.white),
            title: Container(height: 30.0, width: double.infinity, color: Colors.white),
          ),
          Divider()
        ],
      ),
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
    );
  }
}