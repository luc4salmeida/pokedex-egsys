import 'dart:convert';

class PokemonData
{
  int id;
  String name;

  int weight;
  int height;

  String imageUrl;


  PokemonData.fromJson(String body) {

    Map<String, dynamic> data = jsonDecode(body);

    id = data['id'];
    name = data['name'];
    weight = data['weight'];
    height = data['height'];

    if(data['sprites'] != null ){
      imageUrl = data['sprites']['front_default'];
    }
  }
}