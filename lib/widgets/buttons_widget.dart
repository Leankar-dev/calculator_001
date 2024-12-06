import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback buttonTapped;
  final double fontSize;
  final double borderRadius;

  const ButtonsWidget({
    super.key,
    required this.color,
    required this.textColor,
    required this.buttonText,
    required this.buttonTapped,
    required this.fontSize,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Material(
          color: color,
          child: InkWell(
            onTap: buttonTapped,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
