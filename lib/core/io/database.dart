import 'dart:convert';

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
      if(request.statusCode == 200) {
        return PokemonData.fromJson(request.body);
      } 
      else {
        throw IOException(message: "Can't get pokemon by name $name");
      }
    } 
    catch (ex) {
      throw IOException(message: "Algo de errado aconteceu!");
    }
  }
  
  @override
  Future<List<String>> getPokemonsNameByType(String type) async {
    try {
      final request = await http.get(apiBase + "/type/$type");

      if(request.statusCode != 200) {
        throw IOException(message: "Can't get pokemons by type $type");
      }
      
      Map<String, dynamic> data = jsonDecode(request.body);
      List<dynamic> results = data['pokemon'];
    
      return results.map<String>((e) => e['pokemon']['name']).toList();
    } 
    catch (ex) {
      throw IOException(message: "Algo de errado aconteceu!");
    }
  }

  @override
  Future<PokemonData> getPokemonById(int id) async {
    try {
      http.Response request = await http.get(apiBase + "/pokemon/$id");
      if(request.statusCode == 200) {
        return PokemonData.fromJson(request.body);
      } 
      else {
        throw IOException(message: "Can't get pokemon by id $id");
      }
    } 
    catch (ex) {
      throw IOException(message: "Algo de errado aconteceu!");
    }
  }

  @override
  Future<List<String>> getPokemonsNameByRange(int offset, int quantity) async {
    try {
      http.Response request = await http.get(apiBase + "pokemon?limit=$quantity&offset=$offset");

      if(request.statusCode != 200) {
        throw IOException(message: "Can't get pokemons by range $offset");
      }

      Map<String, dynamic> data = jsonDecode(request.body);
      List<dynamic> results = data['results'];

      return results.map<String>((e) => e['name']).toList();
    } 
    catch (ex) {
      throw IOException(message: "Algo de errado aconteceu@!");
    }
  }
  
}