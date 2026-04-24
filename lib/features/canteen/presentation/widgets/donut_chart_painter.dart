// lib/features/canteen/presentation/widgets/donut_chart_painter.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

class DonutChartPainter extends CustomPainter {
  final List<double> ratios;
  static const Color themeColor = Color(0xFF1D4ED8);

  DonutChartPainter({required this.ratios});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;
    final colors = [
      themeColor,
      themeColor.withOpacity(0.55),
      themeColor.withOpacity(0.25),
      Colors.grey.shade200,
    ];
    double startAngle = -math.pi / 2;
    for (int i = 0; i < ratios.length; i++) {
      final sweepAngle = ratios[i] * 2 * math.pi;
      paint.color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2 - 9),
        startAngle + 0.06,
        sweepAngle - 0.12,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => true;
}