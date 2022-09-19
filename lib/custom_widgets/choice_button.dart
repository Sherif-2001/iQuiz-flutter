import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  ChoiceButton({this.buttonText, this.onPress});
  final onPress;
  final buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: Colors.white, width: 3),
        primary: Colors.black38,
        onPrimary: Colors.white,
      ),
      onPressed: onPress,
      child: Text(buttonText, style: TextStyle(fontSize: 20)),
    );
  }
}
