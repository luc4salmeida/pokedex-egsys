import 'package:pokedex_egsys/data/pokemon.dart';

abstract class DataBaseInterface
{
  Future<PokemonData> getPokemonByName(String name);
  Future<List<String>> getPokemonsNameByType(String type);
  Future<PokemonData> getPokemonById(int id);
  Future<List<String>> getPokemonsNameByRange(int offset, int quantity);
}