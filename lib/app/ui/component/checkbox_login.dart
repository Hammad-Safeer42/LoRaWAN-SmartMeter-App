import 'package:flutter/material.dart';

class RectangularCheckbox extends StatefulWidget {
  final Function(bool) onChanged;
  final bool isChecked; // Add initial checked state

  const RectangularCheckbox({super.key, 
    required this.onChanged,
    required this.isChecked, // Initialize isChecked
  });

  @override
  _RectangularCheckboxState createState() => _RectangularCheckboxState();
}

class _RectangularCheckboxState extends State<RectangularCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked; // Initialize isChecked from widget property
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChanged(isChecked); // Call onChanged callback with new state
        });
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.grey,
          ),
          color: isChecked ? Colors.blue : Colors.transparent,
        ),
        child: isChecked
            ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
