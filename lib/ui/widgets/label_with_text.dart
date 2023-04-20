import 'package:flutter/material.dart';

class LabelWithText extends StatelessWidget {
  final String label, text;
  final CrossAxisAlignment alignment;
  const LabelWithText({
    super.key,
    required this.label,
    required this.text,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
