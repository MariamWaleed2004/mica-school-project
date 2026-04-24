// lib/features/canteen/presentation/widgets/donut_chart_widget.dart

import 'package:flutter/material.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/donut_chart_painter.dart';

class DonutChartWidget extends StatelessWidget {
  final String savings;
  final List<double> ratios;
  final String cur;
  final bool isDark;
  final Color textColor;
  final bool isArabic;

  const DonutChartWidget({
    super.key,
    required this.savings,
    required this.ratios,
    required this.cur,
    required this.isDark,
    required this.textColor,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 160, height: 160,
          child: CustomPaint(painter: DonutChartPainter(ratios: ratios)),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$savings $cur",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: textColor)),
            const SizedBox(height: 2),
            Text(isArabic ? "وفّرتي 🎉" : "Saved 🎉",
              style: const TextStyle(color: Color(0xFF10B981), fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}