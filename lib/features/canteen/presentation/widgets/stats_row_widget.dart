// lib/features/canteen/presentation/widgets/stats_row_widget.dart

import 'package:flutter/material.dart';

class StatsRowWidget extends StatelessWidget {
  final bool isDark;
  final String cur;
  final double nowBalance;
  final double startBalance;
  final dynamic data;
  final Color cardColor;
  final Color textColor;
  final bool isArabic;

  const StatsRowWidget({
    super.key,
    required this.isDark,
    required this.cur,
    required this.nowBalance,
    required this.startBalance,
    required this.data,
    required this.cardColor,
    required this.textColor,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _statCard(
          isArabic ? "الرصيد الحالي" : "Balance",
          "${nowBalance.toStringAsFixed(0)} $cur",
          const Color(0xFF1D4ED8),
          Icons.account_balance_wallet_rounded,
        ),
        const SizedBox(width: 12),
        _statCard(
          isArabic ? "التوفير" : "Saved",
          "${data.savings.toStringAsFixed(0)} $cur",
          const Color(0xFF10B981),
          Icons.savings_rounded,
        ),
        const SizedBox(width: 12),
        _statCard(
          isArabic ? "المصروف" : "Spent",
          "${(startBalance - nowBalance).toStringAsFixed(0)} $cur",
          Colors.redAccent,
          Icons.trending_down_rounded,
        ),
      ],
    );
  }

  Widget _statCard(String label, String val, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 7),
            Text(val, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12),
              textAlign: TextAlign.center),
            Text(label, style: TextStyle(fontSize: 9, color: color.withOpacity(0.7), fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}