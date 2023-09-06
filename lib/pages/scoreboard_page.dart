import 'package:flutter/material.dart';
import 'package:iquiz_flutter/models/player.dart';
import 'package:iquiz_flutter/services/database_helper.dart';

class ScoreBoardPage extends StatefulWidget {
  const ScoreBoardPage({Key? key}) : super(key: key);
  static String id = "scoreboardId";

  @override
  State<ScoreBoardPage> createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage> {
  List<Player> _players = [];

  void _refreshPlayers() async {
    final data = await DatabaseHelper.getScoreboardData();
    setState(() {
      List<Player> playersList = data ?? [];
      if (playersList.isNotEmpty) {
        playersList.sort((a, b) => a.score.compareTo(b.score));
        playersList = playersList.reversed.toList();
      }
      _players = playersList;
    });
  }

  void _deletePlayer(int id) async {
    await DatabaseHelper.deleteScoreboardPlayer(id);
    _refreshPlayers();
  }

  @override
  void initState() {
    super.initState();
    _refreshPlayers();
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'scoreboard'.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 30 / scaleFactor),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _players.isNotEmpty
            ? ListView.separated(
                shrinkWrap: true,
                itemCount: _players.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () =>
                        _deletePlayer(_players[index].id ?? index),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                    title: Text(
                      _players[index].name,
                      style: TextStyle(
                          color: Colors.white, fontSize: 30 / scaleFactor),
                    ),
                    trailing: Text(
                      _players[index].score.toString(),
                      style: TextStyle(
                          color: Colors.white, fontSize: 25 / scaleFactor),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "Scoreboard is Empty",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25 / scaleFactor,
                  ),
                ),
              ),
      ),
    );
  }
}
