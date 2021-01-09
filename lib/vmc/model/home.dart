import 'dart:core';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:pokedex_egsys/core/io/idatabase.dart';
import 'package:pokedex_egsys/data/pokemon.dart';

const INITIAL_FETCH_AMMOUNT = 10;
const FETCH_AMMOUNT = 5;

class HomeModel
{
  DataBaseInterface _dataBaseInterface;

  int _currentOffset;
  ValueNotifier<List<String>> pokemonNames;

  List<PokemonData> _cachedPokemons;

  HomeModel({@required DataBaseInterface dataBase}) {

    _dataBaseInterface = dataBase;
    pokemonNames = ValueNotifier(List());
    _cachedPokemons = List();

    _currentOffset = 0;
  }

  dispose() {
    pokemonNames.dispose();
    _cachedPokemons.clear();
  }

  Future<void> getPokemonsOnRange(bool initial) async {

    int fetchAmmount = initial ? INITIAL_FETCH_AMMOUNT : FETCH_AMMOUNT;

    final request = await _dataBaseInterface.getPokemonsNameByRange(_currentOffset, fetchAmmount);
    request.insertAll(0, pokemonNames.value);

    pokemonNames.value = request;

    _currentOffset += fetchAmmount;
  }

  Future<PokemonData> getPokemonByName(String name) async {
    if(_cachedPokemons.where((element) => element.name == name).isNotEmpty) {
      return _cachedPokemons.firstWhere((element) => element.name == name);
    }

    PokemonData data = await  _dataBaseInterface.getPokemonByName(name);
    _cachedPokemons.add(data);

    return data;
  }

  Future<PokemonData> getRandomPokemon() async {
    Random rng = Random();
    int id = rng.nextInt(898);
    return await _dataBaseInterface.getPokemonById(id);
  }
}