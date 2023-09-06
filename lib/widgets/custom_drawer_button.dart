import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  const CustomDrawerButton(
      {Key? key, required this.onPress, required this.buttonText})
      : super(key: key);
  final String buttonText;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 30),
        side: const BorderSide(width: 7, color: Colors.blue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.blue.withOpacity(0.3),
      ),
      onPressed: onPress,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 25 / scaleFactor, color: Colors.white),
      ),
    );
  }
}
