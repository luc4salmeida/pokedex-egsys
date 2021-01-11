import 'package:pokedex_egsys/core/search_provider.dart';

import 'package:flutter/services.dart' show rootBundle;

class SplashModel
{
  SearchProvider _searchProvider;

  SplashModel(this._searchProvider);

  Future<void> loadSuggestions() async {
    _loadPokemonsName();
    _loadTypesName();
  }

  _loadPokemonsName() async {
    String list = await rootBundle.loadString("assets/pokemon_list.txt")..split('\n');
    List<String> names = list.split('\n');

    _searchProvider.addSuggestionsToList(names);
  }

  _loadTypesName() async {
    String list = await rootBundle.loadString("assets/types_list.txt");
    List<String> names = list.split('\n');
  
    _searchProvider.addSuggestionsToList(names);
  }
}