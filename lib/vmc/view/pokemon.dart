import 'package:flutter/material.dart';
import 'package:pokedex_egsys/helpers.dart';
import 'package:pokedex_egsys/style.dart';
import '../controller/pokemon.dart';

import 'package:pokedex_egsys/extensions.dart';
import 'package:pokedex_egsys/widgets/base_view.dart';

class PokemonScreenView
    extends WidgetView<PokemonScreen, PokemonScreenController> {
  PokemonScreenView(PokemonScreenController state) : super(state);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: Color(0xFFFF2b292c)
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildTopContent(context),
        SizedBox(height: 20.0),
        Expanded(
          child: Container(
            child: Column(
              children: [
                Text(widget.data.name.firstCaps, style: MyTypography.BIG.get().copyWith(color: Colors.white)),
                SizedBox(height: 20.0),
                _buildPokemonTypes(context),
                SizedBox(height: 20.0),
                _buildPokemonWeightAndHeight(context)
              ],
            )
          )
        )
      ],
    );
  }

  Widget _buildPokemonTypes(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.data.types.map(
        (e) => Container(

          decoration: BoxDecoration(
            color: typeColors[e],
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 4.0, top: 4.0),
            child: Text(e, style: MyTypography.MEDIUM.get().copyWith(color: Colors.white)),
          )
        )
      ).toList()
    );
  }

  Widget _buildPokemonWeightAndHeight(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(widget.data.weight.toString() + " KG", style: MyTypography.BIG.get().copyWith(color: Colors.white)),
            Text("Peso", style: MyTypography.MEDIUM.get().copyWith(color: Colors.grey))
          ],
        ),
        Column(
          children: [
            Text(widget.data.height.toString() + " M", style: MyTypography.BIG.get().copyWith(color: Colors.white)),
            Text("Altura", style: MyTypography.MEDIUM.get().copyWith(color: Colors.grey))
          ],
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: state.onBackPressed),
              Text("#" + widget.data.id.toString(), style: MyTypography.MEDIUM.get().copyWith(color: Colors.white))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTopContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: typeColors[widget.data.types.first],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            )
          ),
        ),
        _buildAppBar(context),
        _buildPokemonImage(context)
      ],
    );
  }

  Widget _buildPokemonImage(BuildContext context) {
    return Hero(
      tag: widget.data.name,
      child: Image.network(
        widget.data.imageUrl,
        width: 200.0,
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }
}