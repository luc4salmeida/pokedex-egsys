import 'package:pokedex_egsys/data/pokemon.dart';

abstract class DataBaseInterface
{
  Future<PokemonData> getPokemonByName(String name);
  Future<List<PokemonData>> getPokemonByType(String type);
  Future<PokemonData> getRandomPokemon();
}