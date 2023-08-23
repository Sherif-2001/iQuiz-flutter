import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.onPress,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPress;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: Colors.white, width: 5),
        backgroundColor: Colors.black38,
      ),
      onPressed: onPress,
      icon: Icon(icon, color: Colors.white, size: 20 / scaleFactor),
      label: Text(
        label,
        style: TextStyle(fontSize: 17 / scaleFactor, color: Colors.white),
      ),
    );
  }
}
