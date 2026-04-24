// lib/features/home/presentation/widgets/fees_card_widget.dart

import 'package:flutter/material.dart';

class FeesCardWidget extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  final Color cardColor;
  final Color textColor;
  final VoidCallback onTap;

  const FeesCardWidget({
    super.key,
    required this.isDark,
    required this.isArabic,
    required this.cardColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF052e16).withOpacity(0.8),
                    const Color(0xFF1E293B),
                  ]
                : [const Color(0xFFf0fdf4), Colors.white],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF10B981).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.account_balance_wallet_rounded,
                color: Color(0xFF10B981),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? "تفاصيل المصروفات" : "Fees Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    isArabic
                        ? "اضغط لعرض التفاصيل"
                        : "Tap to view details",
                    style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF10B981),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}