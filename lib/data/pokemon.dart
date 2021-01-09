import 'dart:convert';

class PokemonData
{
  int id;
  String name;

  int weight;
  int height;

  String imageUrl;

  List<String> types;
  List<int> stats;


  PokemonData.fromJson(String body) {

    Map<String, dynamic> data = jsonDecode(body);
    types = List();
    stats = List();

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

    if(data['stats'] != null) {
      List<dynamic> rawTypes = data['stats'];
      rawTypes.forEach((element) {
        int stat = element['base_stat'];
        stats.add(stat);
      });
    }
  }
}