import 'package:flutter/material.dart';
import 'package:game/models/player.dart';
import 'package:game/services/database_helper.dart';

class ScoreBoardPage extends StatefulWidget {
  const ScoreBoardPage({Key? key}) : super(key: key);
  static String id = "scoreboardId";

  @override
  State<ScoreBoardPage> createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage> {
  List<Player>? _players = [];

  void _refreshPlayers() async {
    final data = await DatabaseHelper.getAllData();
    setState(() {
      _players = data;
    });
  }

  void _deletePlayer(int id) async {
    await DatabaseHelper.deletePlayer(id);
    _refreshPlayers();
  }

  @override
  void initState() {
    super.initState();
    _refreshPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'SCOREBOARD',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _players != null
            ? ListView.separated(
                shrinkWrap: true,
                itemCount: _players!.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () =>
                        _deletePlayer(_players![index].id ?? index),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                    title: Text(
                      _players![index].name,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    trailing: Text(
                      _players![index].score.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  "Scoreboard is Empty",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
      ),
    );
  }
}
