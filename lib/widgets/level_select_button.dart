import 'package:flutter/material.dart';
import 'package:iquiz_flutter/pages/gameplay_page.dart';
import 'package:iquiz_flutter/providers/questions_provider.dart';
import 'package:provider/provider.dart';

class LevelSelectButton extends StatelessWidget {
  const LevelSelectButton(
      {super.key, this.isEnabled = false, required this.index});

  final int index;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsProvider>(
        builder: (context, questionsProvider, child) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black38,
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isEnabled
            ? () {
                questionsProvider.selectLevel(index);
                Navigator.pushReplacementNamed(context, GameplayPage.id);
              }
            : null,
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    });
  }
}
