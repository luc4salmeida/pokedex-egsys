import 'dart:convert';

class PokemonData
{
  int id;
  String name;

  int weight;
  int height;

  String imageUrl;

  List<String> types;


  PokemonData.fromJson(String body) {

    Map<String, dynamic> data = jsonDecode(body);
    types = List();

    id = data['id'];
    name = data['name'];
    weight = data['weight'];
    height = data['height'];

    if(data['sprites'] != null ){
      imageUrl = data['sprites']['front_default'];
    }

    if(data['types'] != null) {
      List<dynamic> rawTypes = data['types'];
      rawTypes.forEach((element) {
        types.add(element['type']['name']);
      });
    }
  }
}