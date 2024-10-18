import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String buttonText;
  final bool selected;
  final VoidCallback onPressed;
  // Initialize with a default value

  const ToggleButton({
    super.key,
    required this.buttonText,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return selected
        ? ColoredButton(
            buttonText: buttonText,
            onPressed: onPressed,
          )
        : ChartButton(
            buttonText: buttonText,
            onPressed: onPressed,
          );
  }
}

class ColoredButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const ColoredButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 79,
      height: 30,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffFDC830), Color(0xffF37335)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          transform: GradientRotation(30 * 3.14159 / 180),
        ),
        borderRadius: BorderRadius.circular(60),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontFamily: 'lato',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class ChartButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const ChartButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(79, 28),
        backgroundColor: const Color.fromARGB(255, 246, 244, 244),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 164, 166, 183),
        ),
      ),
    );
  }
}
