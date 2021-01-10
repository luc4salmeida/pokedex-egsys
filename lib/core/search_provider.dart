import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/io/idatabase.dart';
import 'package:meta/meta.dart';
import 'package:pokedex_egsys/data/pokemon.dart';

class SearchProvider
{
  DataBaseInterface _dataBaseInterface;
  List<PokemonData> _cachedPokemons;

  List<String> _suggestionList;
  UnmodifiableListView<String> get suggestionList => UnmodifiableListView(_suggestionList);

  final TextEditingController controller = TextEditingController();
  
  SearchProvider({@required DataBaseInterface database}) {

    _cachedPokemons = List();
    _suggestionList = List();

    _dataBaseInterface = database;
  }

  void addSuggestionsToList(List<String> suggestions) {
    _suggestionList.addAll(suggestions);
  }

  Future<PokemonData> getPokemonByName(String name) async {
    
    if(_cachedPokemons.any((element) => element.name == name)){
      return _cachedPokemons.firstWhere((element) => element.name == name);
    }

    PokemonData data = await  _dataBaseInterface.getPokemonByName(name);
    _cachedPokemons.add(data);

    return data;
  }

  Future<PokemonData> getRandomPokemon() async {
    Random rng = Random();
    int id = rng.nextInt(898);

    if(_cachedPokemons.any((element) => element.id == id)) {
      return _cachedPokemons.firstWhere((element) => element.id == id);
    }

    return await _dataBaseInterface.getPokemonById(id);
  }

  Future<List<String>> getPokemonsByRange(int offset, int ammount) async {
    return await _dataBaseInterface.getPokemonsNameByRange(offset, ammount);
  }

  Future<List<String>> getPokemonsByType(String type) async {
    return await _dataBaseInterface.getPokemonsNameByType(type);
  }

}