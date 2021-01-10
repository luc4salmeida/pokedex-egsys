import 'package:flutter/material.dart';

import 'package:pokedex_egsys/core/search_provider.dart';
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


// NECESSÁRIO ALTERAÇÃO NO CÓDIGO FONTE material/search.dart para mantainState => true
class SearchPokemonDelegate extends SearchDelegate
{
  SearchProvider _searchProvider;

  SearchPokemonDelegate(this._searchProvider);

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
      onPressed: () => this.close(context, null)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if(query.isEmpty) {
      return Container();
    }

    query = query.replaceAll(' ', '')..toLowerCase();

    if(pokemonTypes.contains(query)){ 
      return FutureBuilder<List<String>>(
      future: _searchProvider.getPokemonsByType(query),
      builder: (context, namesSnap) {
        if(namesSnap.hasError) return _buildError(context);
        if(!namesSnap.hasData)return _buildLoading(context);
        return ListView.builder(
          itemCount: namesSnap.data.length,
          itemBuilder: (context, index) => FutureBuilder<PokemonData>(
            future: _searchProvider.getPokemonByName(namesSnap.data[index]),
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
      future: _searchProvider.getPokemonByName(query),
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

    if(query.length < 3) {
      return Container();
    }

    List<String> suggestions = List();
    String myQuery = query.replaceAll(' ', '')..toLowerCase();

    _searchProvider.suggestionList.forEach((pokemonName) {
      pokemonName = pokemonName.toLowerCase();
      if(pokemonName.contains(myQuery)) {
        suggestions.add(pokemonName);
      }
    });
    
    return ListView.separated(
      separatorBuilder: (contex, index) => Divider(),
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.search),
        title: Text(suggestions[index]),
        onTap: () {
          query = suggestions[index].replaceAll(new RegExp(r"\s+"), "");
          showResults(context);
        },
      )
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(child: Text("Ops! Não conseguimos encontrar algo parecido com $query", textAlign: TextAlign.center,));
  }

  Widget _buildLoading(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}