import 'package:flutter/material.dart';
import 'package:pokedex_egsys/data/pokemon.dart';
import '../view/pokemon.dart';

class PokemonScreen extends StatefulWidget {

  final PokemonData data;

  const PokemonScreen({Key key, this.data}) : super(key: key);

  @override
  PokemonScreenController createState() => PokemonScreenController();
}

class PokemonScreenController extends State<PokemonScreen> {

  @override
  void initState() {
    super.initState();
  }

  onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => PokemonScreenView(this);
}


