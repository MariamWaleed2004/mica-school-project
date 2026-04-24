// lib/features/home/presentation/widgets/section_label_widget.dart

import 'package:flutter/material.dart';

class SectionLabelWidget extends StatelessWidget {
  final String text;
  final Color color;

  const SectionLabelWidget({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: 0.2,
      ),
    );
  }
}