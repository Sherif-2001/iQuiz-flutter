import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  DrawerButton({this.onPress, this.buttonText});
  final buttonText;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 7, color: Colors.blue),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.blue.withOpacity(0.3),
        ),
        onPressed: onPress,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }
}
