// lib/widgets/option_widget.dart
import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool disabled;
  final bool isCorrect;
  final bool isSelected;

  OptionWidget({
    required this.text,
    required this.onTap,
    required this.disabled,
    required this.isCorrect,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (!disabled) return Colors.blue;
      if (isCorrect) return Colors.green;
      if (isSelected) return Colors.red;
      return Colors.grey;
    }

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }
}
