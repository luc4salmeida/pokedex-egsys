import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/io/idatabase.dart';
import 'package:pokedex_egsys/data/pokemon.dart';
import 'package:pokedex_egsys/style.dart';
import 'package:pokedex_egsys/vmc/controller/pokemon.dart';
import 'package:pokedex_egsys/widgets/pokemon_list_tile.dart';


const List<String> pokemonTypes = [
  "normal",
  "fighting",
  "flying",
  "poison",
  "ground",
  "rock",
  "bug",
  "ghost",
  "steel",
  "fire",
  "water",
  "grass",
  "electric",
  "psychic",
  "ice",
  "dragon",
  "dark",
  "fairy"
];

class SearchPokemonDelegate extends SearchDelegate
{
  final DataBaseInterface _dataBaseInterface;

  SearchPokemonDelegate(this._dataBaseInterface);

  @override
  String get searchFieldLabel => "Nome ou tipo do pokémon";

  @override
  TextStyle get searchFieldStyle => MyTypography.MEDIUM.get();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: () => query = "",
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.keyboard_arrow_left),
      onPressed: () => Navigator.pop(context)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if(query.isEmpty) {
      return Container();
    }

    query = query.toLowerCase();
    
    if(pokemonTypes.contains(query)){ 
      return FutureBuilder<List<String>>(
      future: _dataBaseInterface.getPokemonsNameByType(query),
      builder: (context, namesSnap) {
        if(namesSnap.hasError) return _buildError(context);
        if(!namesSnap.hasData)return _buildLoading(context);
        return ListView.builder(
          itemCount: namesSnap.data.length,
          itemBuilder: (context, index) => FutureBuilder<PokemonData>(
            future: _dataBaseInterface.getPokemonByName(namesSnap.data[index]),
            builder: (context, pokeSnap) {
              if(pokeSnap.hasError) return _buildError(context);
              if(!pokeSnap.hasData) return PokemonLoadingListTile();
              return GestureDetector(
               onTap: () => _onPokemonPressed(context, pokeSnap.data),
                child: PokemonListTile(data: pokeSnap.data)
              );
            }
          )
        );
       }
      );
    }

    return FutureBuilder<PokemonData>(
      future: _dataBaseInterface.getPokemonByName(query),
      builder: (context, snap) {
        if(snap.hasError) return _buildError(context);
        if(!snap.hasData)return _buildLoading(context);
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _onPokemonPressed(context, snap.data),
              child: PokemonListTile(data: snap.data)
            ),
          )
        );
      }
    );
  }

  _onPokemonPressed(BuildContext context, PokemonData data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonScreen(
      data: data
    )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _buildError(BuildContext context) {
    return Center(child: Text("Ops! Não conseguimos encontrar algo parecido com $query", textAlign: TextAlign.center,));
  }

  Widget _buildLoading(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}