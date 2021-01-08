import 'dart:math';

import 'package:pokedex_egsys/core/io/exception.dart';
import 'package:pokedex_egsys/core/io/idatabase.dart';
import 'package:pokedex_egsys/data/pokemon.dart';


import 'package:http/http.dart' as http;


class Database implements DataBaseInterface
{
  String apiBase = "https://pokeapi.co/api/v2/";

  @override
  Future<PokemonData> getPokemonByName(String name) async {
    try {
      final request = await http.get(apiBase + "/pokemon/$name");
      return PokemonData.fromJson(request.body);
    } 
    catch (ex) {
      throw IOException(message: ex);
    }
  }
  
  @override
  Future<List<PokemonData>> getPokemonByType(String type) {
    throw UnimplementedError();
  }

  @override
  Future<PokemonData> getRandomPokemon() async {

    var rng = Random();
    int id = rng.nextInt(898);

    try {
      http.Response request = await http.get(apiBase + "/pokemon/$id");
      return PokemonData.fromJson(request.body);
    } 
    catch (ex) {
      throw IOException(message: ex);
    }
  }
  
}