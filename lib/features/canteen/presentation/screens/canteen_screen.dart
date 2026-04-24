// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mica_school_app/features/canteen/presentation/cubit/canteen_cubit.dart';
// import 'package:mica_school_app/features/canteen/presentation/cubit/canteen_state.dart';
// import 'dart:math' as math;
// import 'package:mica_school_app/features/canteen/presentation/widgets/topup_widget.dart';

// class CanteenScreen extends StatefulWidget {
//   final bool isArabic;
//   final bool isDarkMode;
//   final String userId;

//   const CanteenScreen({
//     super.key,
//     required this.isArabic,
//     required this.isDarkMode,
//     required this.userId,
//   });

//   @override
//   State<CanteenScreen> createState() => _CanteenScreenState();
// }

// class _CanteenScreenState extends State<CanteenScreen>
//     with SingleTickerProviderStateMixin {
//   static const Color themeColor = Color(0xFF1D4ED8);
//   static const Color greenAccent = Color(0xFF10B981);

//   late AnimationController _animController;
//   late Animation<double> _fadeAnim;

//   final Map<String, String> monthTranslations = {
//     "September": "سبتمبر", "October": "أكتوبر", "November": "نوفمبر",
//     "December": "ديسمبر", "January": "يناير", "February": "فبراير",
//     "March": "مارس", "April": "أبريل", "May": "مايو", "June": "يونيو",
//     "July": "يوليو", "August": "أغسطس",
//   };

//   @override
//   void initState() {
//     super.initState();
//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
//     _animController.forward();

//     context.read<CanteenCubit>().loadMonths(widget.userId);
//   }

//   @override
//   void dispose() {
//     _animController.dispose();
//     super.dispose();
//   }

//   void _changeMonth(String? key) {
//     if (key == null) return;
//     _animController.reset();
//     context.read<CanteenCubit>().loadMonthData(
//       widget.userId,
//       key,
//       widget.isArabic,
//     );
//     _animController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = widget.isDarkMode;
//     final isAr = widget.isArabic;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: BlocBuilder<CanteenCubit, CanteenState>(
//         builder: (context, state) {
//           if (state is CanteenLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is CanteenError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 48, color: Colors.red),
//                   const SizedBox(height: 16),
//                   Text(state.message),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<CanteenCubit>().loadMonths(widget.userId);
//                     },
//                     child: Text(isAr ? "إعادة المحاولة" : "Retry"),
//                   ),
//                 ],
//               ),
//             );
//           }
//           if (state is CanteenLoaded) {
//             final data = state.data;
//             final nowBalance = data.balance;
//             final startBalance = data.startBalance;
//             final cur = isAr ? "ج.م" : "EGP";
//             final displayedMonth = isAr
//                 ? monthTranslations[state.selectedMonth] ?? state.selectedMonth
//                 : state.selectedMonth;
//             final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
//             final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

//             print("🔥🔥🔥 DAILY PURCHASES: ${data.dailyPurchases.length}");
//             print("🔥🔥🔥 Keys: ${data.dailyPurchases.keys}");

//             return FadeTransition(
//               opacity: _fadeAnim,
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
//                 child: Column(
//                   children: [
//                     _buildBalanceHero(
//                       isDark, startBalance, nowBalance, data, cur,
//                       displayedMonth, textColor, cardColor, state.availableMonths, state.selectedMonth,
//                     ),
//                     const SizedBox(height: 18),
//                     _buildStatsRow(
//                       isDark, cur, nowBalance, startBalance, data,
//                       cardColor, textColor,
//                     ),
//                     const SizedBox(height: 24),
//                     _buildSectionHeader(
//                       isAr ? "مشتريات يومية" : "Daily Purchases",
//                       isDark, textColor,
//                     ),
//                     const SizedBox(height: 14),
//                     _buildDailyPurchaseList(
//                       isDark, cur, data.dailyPurchases, cardColor, textColor,
//                     ),
//                     const SizedBox(height: 20),
//                     _buildTopUpButton(context),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   // ─── Balance Hero ──────────────────────────────────────────────
//   Widget _buildBalanceHero(
//     bool isDark, double start, double now, dynamic data,
//     String cur, String month, Color textColor, Color cardColor,
//     List<String> months, String selectedMonth,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: themeColor.withOpacity(0.1)),
//         boxShadow: [
//           BoxShadow(
//             color: themeColor.withOpacity(isDark ? 0.15 : 0.07),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildMonthPicker(isDark, months, selectedMonth),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     widget.isArabic ? "رصيد بداية $month" : "Start Balance $month",
//                     style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 12),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     "${start.toStringAsFixed(0)} $cur",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: textColor),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 28),
//           _buildDonutChart(
//             data.savings.toString(),
//             List<double>.from(data.ratios),
//             cur, isDark, textColor,
//           ),
//           const SizedBox(height: 20),
//           _buildSpendProgress(isDark, start, now, cur, textColor),
//         ],
//       ),
//     );
//   }

//   Widget _buildSpendProgress(
//     bool isDark, double start, double now, String cur, Color textColor,
//   ) {
//     final spent = start - now;
//     final pct = spent / start;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "${spent.toStringAsFixed(0)} $cur ${widget.isArabic ? 'مصروف' : 'spent'}",
//               style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "${now.toStringAsFixed(0)} $cur ${widget.isArabic ? 'متبقي' : 'left'}",
//               style: const TextStyle(color: greenAccent, fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: LinearProgressIndicator(
//             value: pct.clamp(0.0, 1.0),
//             minHeight: 7,
//             backgroundColor: greenAccent.withOpacity(0.15),
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
//           ),
//         ),
//       ],
//     );
//   }

//   // ─── Stats Row ─────────────────────────────────────────────────
//   Widget _buildStatsRow(
//     bool isDark, String cur, double now, double start,
//     dynamic data, Color cardColor, Color textColor,
//   ) {
//     return Row(
//       children: [
//         _statCard(
//           isDark,
//           widget.isArabic ? "الرصيد الحالي" : "Balance",
//           "${now.toStringAsFixed(0)} $cur",
//           themeColor,
//           Icons.account_balance_wallet_rounded,
//           cardColor,
//         ),
//         const SizedBox(width: 12),
//         _statCard(
//           isDark,
//           widget.isArabic ? "التوفير" : "Saved",
//           "${data.savings.toStringAsFixed(0)} $cur",
//           greenAccent,
//           Icons.savings_rounded,
//           cardColor,
//         ),
//         const SizedBox(width: 12),
//         _statCard(
//           isDark,
//           widget.isArabic ? "المصروف" : "Spent",
//           "${(start - now).toStringAsFixed(0)} $cur",
//           Colors.redAccent,
//           Icons.trending_down_rounded,
//           cardColor,
//         ),
//       ],
//     );
//   }

//   Widget _statCard(
//     bool isDark, String label, String val, Color color,
//     IconData icon, Color cardColor,
//   ) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//         decoration: BoxDecoration(
//           color: cardColor,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: color.withOpacity(0.15)),
//           boxShadow: [
//             BoxShadow(color: color.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, 3)),
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 36, height: 36,
//               decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
//               child: Icon(icon, color: color, size: 18),
//             ),
//             const SizedBox(height: 7),
//             Text(val, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12),
//               textAlign: TextAlign.center),
//             Text(label, style: TextStyle(fontSize: 9, color: color.withOpacity(0.7), fontWeight: FontWeight.w600),
//               textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }

//   // ─── Section header ────────────────────────────────────────────
//   Widget _buildSectionHeader(String title, bool isDark, Color textColor) {
//     return Row(
//       children: [
//         Container(
//           width: 4, height: 20,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)]),
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: textColor)),
//       ],
//     );
//   }

//   // ─── Daily purchases ───────────────────────────────────────────
//   Widget _buildDailyPurchaseList(
//     bool isDark, String cur, Map<String, List<dynamic>> dailyData,
//     Color cardColor, Color textColor,
//   ) {
//     if (dailyData.isEmpty) {
//       return Container(
//         padding: const EdgeInsets.all(28),
//         decoration: BoxDecoration(
//           color: cardColor,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: themeColor.withOpacity(0.08)),
//         ),
//         child: Column(
//           children: [
//             Icon(Icons.shopping_basket_outlined, size: 44, color: textColor.withOpacity(0.2)),
//             const SizedBox(height: 10),
//             Text(
//               widget.isArabic ? "لا توجد مشتريات هذا الشهر" : "No purchases this month",
//               style: TextStyle(color: textColor.withOpacity(0.4), fontSize: 14),
//             ),
//           ],
//         ),
//       );
//     }

//     return Column(
//       children: dailyData.entries.map<Widget>((entry) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 children: [
//                   Container(width: 6, height: 6,
//                     decoration: const BoxDecoration(color: themeColor, shape: BoxShape.circle)),
//                   const SizedBox(width: 8),
//                   Text(entry.key,
//                     style: const TextStyle(color: themeColor, fontWeight: FontWeight.bold, fontSize: 13)),
//                 ],
//               ),
//             ),
//             ...List.generate(entry.value.length, (i) {
//               final p = entry.value[i];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: cardColor,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: themeColor.withOpacity(0.08)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
//                       blurRadius: 8, offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 38, height: 38,
//                       decoration: BoxDecoration(color: themeColor.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
//                       child: const Icon(Icons.shopping_cart_rounded, color: themeColor, size: 18),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(p.name,
//                             style: TextStyle(fontWeight: FontWeight.w600, color: textColor, fontSize: 13)),
//                           const SizedBox(height: 2),
//                           Text(p.time,
//                             style: TextStyle(color: textColor.withOpacity(0.4), fontSize: 11)),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
//                       child: Text("-${p.price.toStringAsFixed(0)} $cur",
//                         style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         );
//       }).toList(),
//     );
//   }

//   // ─── Top up button ─────────────────────────────────────────────
//   Widget _buildTopUpButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => TopUpWidget(
//             isArabic: widget.isArabic,
//             themeColor: themeColor,
//           ),
//         ),
//       ),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(colors: [Color(0xFF059669), Color(0xFF10B981)]),
//           borderRadius: BorderRadius.circular(22),
//           boxShadow: [
//             BoxShadow(color: greenAccent.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 7)),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
//               child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
//             ),
//             const SizedBox(width: 12),
//             Text(
//               widget.isArabic ? "اشحن محفظتك الآن" : "Top Up Your Wallet",
//               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ─── Month picker ──────────────────────────────────────────────
//   Widget _buildMonthPicker(bool isDark, List<String> months, String selectedMonth) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF1D4ED8)]),
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(color: themeColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3)),
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: selectedMonth,
//           dropdownColor: const Color(0xFF1A237E),
//           icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 20),
//           onChanged: _changeMonth,
//           items: months.map((m) {
//             return DropdownMenuItem(
//               value: m,
//               child: Text(
//                 widget.isArabic ? monthTranslations[m]! : m,
//                 style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   // ─── Donut chart ───────────────────────────────────────────────
//   Widget _buildDonutChart(String savings, List<double> ratios, String cur, bool isDark, Color textColor) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         SizedBox(
//           width: 160, height: 160,
//           child: CustomPaint(painter: DonutChartPainter(ratios: ratios, themeColor: themeColor)),
//         ),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("$savings $cur",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: textColor)),
//             const SizedBox(height: 2),
//             Text(widget.isArabic ? "وفّرتي 🎉" : "Saved 🎉",
//               style: const TextStyle(color: greenAccent, fontSize: 12, fontWeight: FontWeight.w600)),
//           ],
//         ),
//       ],
//     );
//   }
// }

// // ══════════════════════════════════════════════════════════════
// // DonutChartPainter
// // ══════════════════════════════════════════════════════════════
// class DonutChartPainter extends CustomPainter {
//   final List<double> ratios;
//   final Color themeColor;
//   DonutChartPainter({required this.ratios, required this.themeColor});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 18
//       ..strokeCap = StrokeCap.round;
//     final colors = [
//       themeColor,
//       themeColor.withOpacity(0.55),
//       themeColor.withOpacity(0.25),
//       Colors.grey.shade200,
//     ];
//     double startAngle = -math.pi / 2;
//     for (int i = 0; i < ratios.length; i++) {
//       final sweepAngle = ratios[i] * 2 * math.pi;
//       paint.color = colors[i % colors.length];
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: size.width / 2 - 9),
//         startAngle + 0.06,
//         sweepAngle - 0.12,
//         false,
//         paint,
//       );
//       startAngle += sweepAngle;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter _) => true;
// }


// lib/features/canteen/presentation/screens/canteen_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/canteen/presentation/cubit/canteen_cubit.dart';
import 'package:mica_school_app/features/canteen/presentation/cubit/canteen_state.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/topup_widget.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/balance_hero_widget.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/stats_row_widget.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/section_header_widget.dart';
import 'package:mica_school_app/features/canteen/presentation/widgets/daily_purchases_list_widget.dart';

class CanteenScreen extends StatefulWidget {
  final bool isArabic;
  final bool isDarkMode;
  final String userId;

  const CanteenScreen({
    super.key,
    required this.isArabic,
    required this.isDarkMode,
    required this.userId,
  });

  @override
  State<CanteenScreen> createState() => _CanteenScreenState();
}

class _CanteenScreenState extends State<CanteenScreen>
    with SingleTickerProviderStateMixin {
  static const Color themeColor = Color(0xFF1D4ED8);
  static const Color greenAccent = Color(0xFF10B981);

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();

    context.read<CanteenCubit>().loadMonths(widget.userId);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _changeMonth(String? key) {
    if (key == null) return;
    _animController.reset();
    context.read<CanteenCubit>().loadMonthData(
      widget.userId,
      key,
      widget.isArabic,
    );
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final isAr = widget.isArabic;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<CanteenCubit, CanteenState>(
        builder: (context, state) {
          if (state is CanteenLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CanteenError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CanteenCubit>().loadMonths(widget.userId);
                    },
                    child: Text(isAr ? "إعادة المحاولة" : "Retry"),
                  ),
                ],
              ),
            );
          }
          if (state is CanteenLoaded) {
            final data = state.data;
            final nowBalance = data.balance;
            final startBalance = data.startBalance;
            final cur = isAr ? "ج.م" : "EGP";
            final displayedMonth = isAr
                ? _getMonthTranslation(state.selectedMonth)
                : state.selectedMonth;
            final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
            final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

            return FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
                child: Column(
                  children: [
                    BalanceHeroWidget(
                      isDark: isDark,
                      startBalance: startBalance,
                      nowBalance: nowBalance,
                      data: data,
                      cur: cur,
                      month: displayedMonth,
                      textColor: textColor,
                      cardColor: cardColor,
                      months: state.availableMonths,
                      selectedMonth: state.selectedMonth,
                      isArabic: isAr,
                      onMonthChanged: _changeMonth,
                    ),
                    const SizedBox(height: 18),
                    StatsRowWidget(
                      isDark: isDark,
                      cur: cur,
                      nowBalance: nowBalance,
                      startBalance: startBalance,
                      data: data,
                      cardColor: cardColor,
                      textColor: textColor,
                      isArabic: isAr,
                    ),
                    const SizedBox(height: 24),
                    SectionHeaderWidget(
                      title: isAr ? "مشتريات يومية" : "Daily Purchases",
                      isDark: isDark,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 14),
                    DailyPurchasesListWidget(
                      isDark: isDark,
                      cur: cur,
                      dailyData: data.dailyPurchases,
                      cardColor: cardColor,
                      textColor: textColor,
                      isArabic: isAr,
                    ),
                    const SizedBox(height: 20),
                    _buildTopUpButton(context),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  String _getMonthTranslation(String monthKey) {
    const translations = {
      "September": "سبتمبر", "October": "أكتوبر", "November": "نوفمبر",
      "December": "ديسمبر", "January": "يناير", "February": "فبراير",
      "March": "مارس", "April": "أبريل", "May": "مايو", "June": "يونيو",
      "July": "يوليو", "August": "أغسطس",
    };
    return translations[monthKey] ?? monthKey;
  }

  Widget _buildTopUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TopUpWidget(
            isArabic: widget.isArabic,
            themeColor: themeColor,
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF059669), Color(0xFF10B981)]),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(color: greenAccent.withOpacity(0.35), blurRadius: 18, offset: const Offset(0, 7)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              widget.isArabic ? "اشحن محفظتك الآن" : "Top Up Your Wallet",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}