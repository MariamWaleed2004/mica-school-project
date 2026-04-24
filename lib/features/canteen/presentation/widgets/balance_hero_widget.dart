// lib/features/canteen/presentation/widgets/balance_hero_widget.dart

import 'package:flutter/material.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/donut_chart_widget.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/month_picker_widget.dart';

class BalanceHeroWidget extends StatelessWidget {
  final bool isDark;
  final double startBalance;
  final double nowBalance;
  final dynamic data;
  final String cur;
  final String month;
  final Color textColor;
  final Color cardColor;
  final List<String> months;
  final String selectedMonth;
  final bool isArabic;
  final Function(String?) onMonthChanged;

  const BalanceHeroWidget({
    super.key,
    required this.isDark,
    required this.startBalance,
    required this.nowBalance,
    required this.data,
    required this.cur,
    required this.month,
    required this.textColor,
    required this.cardColor,
    required this.months,
    required this.selectedMonth,
    required this.isArabic,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    final spent = startBalance - nowBalance;
    final pct = spent / startBalance;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1D4ED8).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(isDark ? 0.15 : 0.07),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MonthPickerWidget(
                isDark: isDark,
                months: months,
                selectedMonth: selectedMonth,
                isArabic: isArabic,
                onMonthChanged: onMonthChanged,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isArabic ? "رصيد بداية $month" : "Start Balance $month",
                    style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${startBalance.toStringAsFixed(0)} $cur",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: textColor),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          DonutChartWidget(
            savings: data.savings.toString(),
            ratios: List<double>.from(data.ratios),
            cur: cur,
            isDark: isDark,
            textColor: textColor,
            isArabic: isArabic,
          ),
          const SizedBox(height: 20),
          _buildSpendProgress(),
        ],
      ),
    );
  }

  Widget _buildSpendProgress() {
    final spent = startBalance - nowBalance;
    final pct = spent / startBalance;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${spent.toStringAsFixed(0)} $cur ${isArabic ? 'مصروف' : 'spent'}",
              style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              "${nowBalance.toStringAsFixed(0)} $cur ${isArabic ? 'متبقي' : 'left'}",
              style: const TextStyle(color: Color(0xFF10B981), fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: pct.clamp(0.0, 1.0),
            minHeight: 7,
            backgroundColor: const Color(0xFF10B981).withOpacity(0.15),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
        ),
      ],
    );
  }
}