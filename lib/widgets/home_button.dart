import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton(
      {Key? key,
      required this.onPress,
      required this.label,
      required this.icon})
      : super(key: key);
  final VoidCallback onPress;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 25),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: const BorderSide(color: Colors.white, width: 5),
        backgroundColor: Colors.black38,
      ),
      onPressed: onPress,
      icon: Icon(icon, color: Colors.white, size: 25),
      label: Text(label,
          style: const TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
