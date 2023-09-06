import 'package:flutter/material.dart';
import 'package:iquiz_flutter/providers/questions_provider.dart';
import 'package:iquiz_flutter/widgets/level_select_button.dart';
import 'package:provider/provider.dart';

class SelectLevelPage extends StatelessWidget {
  const SelectLevelPage({super.key});

  static String id = "selectLevelId";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Select Level',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Consumer<QuestionsProvider>(
                builder: (context, questionsProvider, child) {
              return GridView.builder(
                itemCount: questionsProvider.questionsLength,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return LevelSelectButton(
                    index: index,
                    isEnabled:
                        questionsProvider.unlockedLevels.contains(index + 1),
                  );
                },
              );
            },),
          ),
        ),
      ),
    );
  }
}
