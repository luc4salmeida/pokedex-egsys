import 'package:flutter/material.dart';
import 'package:pokedex_egsys/data/pokemon.dart';
import 'package:pokedex_egsys/widgets/base_view.dart';

import '../controller/home.dart';

class HomeScreenView extends WidgetView<HomeScreen, HomeScreenController> {
  HomeScreenView(HomeScreenController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _buildPokemonStream(context))
    );
  }
  
  Widget _buildPokemonStream(BuildContext context) {
    return StreamBuilder(
      stream: state.model.randomPokemon,
      builder: (context, snap) {
        if(snap.hasError) return _buildPokemonError(context);
        else if(!snap.hasData) return _buildPokemonLoading(context);
        else return _buildPokemon(context, snap.data);
      }
    );
  }

  Widget _buildPokemonLoading(BuildContext context) {
    return CircularProgressIndicator();
  }

  Widget _buildPokemonError(BuildContext context) {
    return Text("Algo de errado aconteceu!");
  }

  Widget _buildPokemon(BuildContext context, PokemonData data) {
    return Column(
      children: [
        Text(data.name),
        Image.network(data.imageUrl)
      ],
    );
  }
}
