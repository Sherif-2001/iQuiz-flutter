// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:game/quiz_brain.dart';
import 'package:provider/provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);
  static String id = "scoreboardId";
  @override
  Widget build(BuildContext context) {
    var playersList = Provider.of<Brain>(context).getPlayersList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('SCOREBOARD',
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: playersList.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              thickness: 2,
              indent: 30,
              endIndent: 30,
            ),
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () => Provider.of<Brain>(context, listen: false)
                    .deletePlayer(index),
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                title: Text(playersList[index].playerName,
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                trailing: Text(playersList[index].playerScore.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              );
            },
          ),
        ],
      ),
    );
  }
}
