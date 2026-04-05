import 'package:flutter/material.dart';
import 'dart:math' as math;


class LoginBgPainter extends CustomPainter {
  final double t;
  final bool isDark;
  LoginBgPainter(this.t, this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0xFF0F172A),
                const Color(0xFF1a1040),
                const Color(0xFF0F172A)
              ]
            : [
                const Color(0xFFEEF2FF),
                const Color(0xFFE0F2FE),
                const Color(0xFFEEF2FF)
              ],
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    final orbs = [
      [0.2, 0.15, 180.0, const Color(0xFF4F46E5)],
      [0.8, 0.3, 140.0, const Color(0xFF06B6D4)],
      [0.1, 0.75, 120.0, const Color(0xFF7C3AED)],
      [0.9, 0.85, 100.0, const Color(0xFF0EA5E9)],
    ];

    for (var orb in orbs) {
      final dx = (orb[0] as double) * size.width +
          math.sin(t * 2 * math.pi + orbs.indexOf(orb)) * 20;
      final dy = (orb[1] as double) * size.height +
          math.cos(t * 2 * math.pi + orbs.indexOf(orb)) * 15;
      final r = orb[2] as double;
      final color = orb[3] as Color;

      final orbPaint = Paint()
        ..shader = RadialGradient(colors: [
          color.withOpacity(isDark ? 0.18 : 0.10),
          Colors.transparent
        ]).createShader(Rect.fromCircle(center: Offset(dx, dy), radius: r));
      canvas.drawCircle(Offset(dx, dy), r, orbPaint);
    }
  }

  @override
  bool shouldRepaint(LoginBgPainter old) => true;
}
