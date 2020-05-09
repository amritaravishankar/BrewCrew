import 'package:flutter/material.dart';
import 'package:brew_crew/home/brew_tile.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context) ?? [];

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.95), BlendMode.dstATop),
            fit: BoxFit.fitHeight,
          )
      ),
      child: ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index){
          return BrewTile(brew: brews[index]);
        },
      ),
    );
  }
}
