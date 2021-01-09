import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/io/database.dart';
import 'package:pokedex_egsys/core/io/exception.dart';
import 'package:pokedex_egsys/data/pokemon.dart';
import 'package:pokedex_egsys/vmc/controller/pokemon.dart';
import 'package:pokedex_egsys/widgets/search_pokemon.dart';
import 'package:toast/toast.dart';
import '../view/home.dart';

class HomeScreen extends StatefulWidget {

  static String route = "home";

  @override
  HomeScreenController createState() => HomeScreenController();
}

class HomeScreenController extends State<HomeScreen> {

  Database _database;
  int _offset;
  int _fetchAmmount;

  bool _searchingForPokemon;
  bool get isSearchingForPokemon => _searchingForPokemon;

  List<String> _pokemonsName;
  UnmodifiableListView<String> get pokemonsName =>  UnmodifiableListView(_pokemonsName);

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  @override
  void initState() {
    super.initState();

    _offset = 0;
    _fetchAmmount = 10;

    _database = Database();
    _pokemonsName = List();

    _searchingForPokemon = false;

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      _handleScrollEvents();
    });

    _fetch();
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _fetch() async {
    try {
      List<String> names = await _database.getPokemonsNameByRange(_offset, _fetchAmmount);
      _offset += _fetchAmmount;

      setState(() {
        _pokemonsName.addAll(names);
      });
      
    } 
    on IOException catch (ex) {
      _showToast(ex.message);
    }
  }

  _handleScrollEvents() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetch();
    }
  }

  Future<void> onRandomButtonPressed() async {

    Random rng = Random();
    int id = rng.nextInt(898);
  
    try {
      
      _changeSearchingForPokemonStatus(true);
      PokemonData pokemonData = await _database.getPokemonById(id);
      _changeSearchingForPokemonStatus(false);

      Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonScreen(
        data: pokemonData
      )));

    } 
    on IOException catch(ex) {
      _showToast(ex.message);
    }
    
  }

  Future<void> onSearchPressed() async {

    FocusScope.of(context).requestFocus(new FocusNode());

    showSearch(
      context: context, delegate: SearchPokemonDelegate(
        _database
      ),
    );
  }

  onPokemonPressed(PokemonData data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonScreen(
      data: data
    )));
  }

  Future<PokemonData> getPokemonName(String name) async {
    return _database.getPokemonByName(name);
  }

  _showToast(String message) {
    Toast.show(message, context);
  }

  _changeSearchingForPokemonStatus(bool status) {
    setState(() {
      _searchingForPokemon = status;
    });
  }

  @override
  Widget build(BuildContext context) => HomeScreenView(this);
}

