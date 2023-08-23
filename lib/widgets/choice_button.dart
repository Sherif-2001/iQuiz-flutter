import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton(
      {Key? key, required this.buttonText, required this.onPress})
      : super(key: key);
  final VoidCallback onPress;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: Colors.white, width: 3),
        backgroundColor: Colors.black45,
        foregroundColor: Colors.white,
      ),
      onPressed: onPress,
      child: Text(buttonText, style: TextStyle(fontSize: 18 / scaleFactor)),
    );
  }
}
