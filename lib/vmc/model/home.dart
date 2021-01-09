import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:pokedex_egsys/core/search_provider.dart';
import 'package:pokedex_egsys/data/pokemon.dart';

const INITIAL_FETCH_AMMOUNT = 10;
const FETCH_AMMOUNT = 5;

class HomeModel
{
  SearchProvider _searchProvider;

  int _currentOffset;
  ValueNotifier<List<String>> pokemonNames;

  List<PokemonData> _cachedPokemons;

  HomeModel({@required SearchProvider provider}) {

    _searchProvider = provider;
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

    final request = await _searchProvider.getPokemonsByRange(_currentOffset, fetchAmmount);
    request.insertAll(0, pokemonNames.value);

    pokemonNames.value = request;

    _currentOffset += fetchAmmount;
  }

  Future<PokemonData> getPokemonByName(String name) async {
    return await _searchProvider.getPokemonByName(name);
  }

  Future<PokemonData> getRandomPokemon() async {
    return await _searchProvider.getRandomPokemon();
  }
}