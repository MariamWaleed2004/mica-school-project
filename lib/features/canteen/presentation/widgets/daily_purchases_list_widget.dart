// lib/features/canteen/presentation/widgets/daily_purchases_list_widget.dart

import 'package:flutter/material.dart';

class DailyPurchasesListWidget extends StatelessWidget {
  final bool isDark;
  final String cur;
  final Map<String, List<dynamic>> dailyData;
  final Color cardColor;
  final Color textColor;
  final bool isArabic;

  const DailyPurchasesListWidget({
    super.key,
    required this.isDark,
    required this.cur,
    required this.dailyData,
    required this.cardColor,
    required this.textColor,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    if (dailyData.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1D4ED8).withOpacity(0.08)),
        ),
        child: Column(
          children: [
            Icon(Icons.shopping_basket_outlined, size: 44, color: textColor.withOpacity(0.2)),
            const SizedBox(height: 10),
            Text(
              isArabic ? "لا توجد مشتريات هذا الشهر" : "No purchases this month",
              style: TextStyle(color: textColor.withOpacity(0.4), fontSize: 14),
            ),
          ],
        ),
      );
    }

    return Column(
      children: dailyData.entries.map<Widget>((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(width: 6, height: 6,
                    decoration: const BoxDecoration(color: Color(0xFF1D4ED8), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Text(entry.key,
                    style: const TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
            ...List.generate(entry.value.length, (i) {
              final p = entry.value[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1D4ED8).withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
                      blurRadius: 8, offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(color: const Color(0xFF1D4ED8).withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.shopping_cart_rounded, color: Color(0xFF1D4ED8), size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name,
                            style: TextStyle(fontWeight: FontWeight.w600, color: textColor, fontSize: 13)),
                          const SizedBox(height: 2),
                          Text(p.time,
                            style: TextStyle(color: textColor.withOpacity(0.4), fontSize: 11)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: Text("-${p.price.toStringAsFixed(0)} $cur",
                        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      }).toList(),
    );
  }
}