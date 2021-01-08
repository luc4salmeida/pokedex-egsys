import 'dart:async';

import 'package:pokedex_egsys/core/io/database.dart';
import 'package:pokedex_egsys/data/pokemon.dart';

class HomeModel
{
  Database _dataBase;

  StreamController<PokemonData> _randPokemonStreamController;
  Stream<PokemonData> randomPokemon;

  HomeModel() {
    _dataBase = Database();
    _randPokemonStreamController = StreamController();

    randomPokemon = _randPokemonStreamController.stream;
  }

  dispose() {
    _randPokemonStreamController.close();
  }

  Future<void> getRandomPokemon() async {
    PokemonData pokemon = await _dataBase.getRandomPokemon();
    _randPokemonStreamController.sink.add(pokemon);
  }

}