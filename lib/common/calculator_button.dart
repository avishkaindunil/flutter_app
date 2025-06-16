import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const CalculatorButton({Key? key, required this.label, required this.color, required this.textColor, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Center(child: Text(label, style: TextStyle(fontSize: 24, color: textColor))),
      ),
    );
  }
}