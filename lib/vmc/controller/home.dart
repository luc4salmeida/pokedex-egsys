import 'dart:collection';
import 'dart:math';

import 'package:async/async.dart';
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

  int _initialFetch;
  int _fetchAmmount;

  bool _searchingForPokemon;
  bool get isSearchingForPokemon => _searchingForPokemon;

  List<String> _pokemonsName;
  UnmodifiableListView<String> get pokemonsName =>  UnmodifiableListView(_pokemonsName);

  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();

    _offset = 0;

    _initialFetch = 10;
    _fetchAmmount = 3;

    _database = Database();
    _pokemonsName = List();

    _searchingForPokemon = false;

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      _handleScrollEvents();
    });

    _fetch(_initialFetch);
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _fetch(int ammount) async {
    try {
      List<String> names = await _database.getPokemonsNameByRange(_offset, ammount);
      _offset += ammount;

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
      _fetch(_fetchAmmount);
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
      _changeSearchingForPokemonStatus(false);
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

