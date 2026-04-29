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

  Future<void> _onRefresh() async {
    final state = context.read<CanteenCubit>().state;
    if (state is CanteenLoaded) {
      await context.read<CanteenCubit>().loadMonthData(
        widget.userId,
        state.selectedMonth,
        widget.isArabic,
      );
    } else {
      await context.read<CanteenCubit>().loadMonths(widget.userId);
    }
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

            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: themeColor,
              backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              displacement: 20,
              edgeOffset: 0,
              notificationPredicate: (notification) {
                // Only trigger when scrolling at the top
                return notification.metrics.extentBefore == 0;
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
                child: FadeTransition(
                  opacity: _fadeAnim,
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