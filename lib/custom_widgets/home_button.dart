import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  HomeButton({Key? key, this.onPress, this.label, this.icon}) : super(key: key);
  final onPress;
  final label;
  final icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: BorderSide(color: Colors.white, width: 5),
        primary: Colors.black38,
      ),
      onPressed: onPress,
      icon: Icon(icon, color: Colors.white, size: 25),
      label: Text(label, style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
