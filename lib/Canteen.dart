import 'package:flutter/material.dart';
import 'dart:math' as math;

class CanteenPage extends StatefulWidget {
  final bool isArabic;
  final bool isDarkMode;

  const CanteenPage({
    super.key,
    required this.isArabic,
    required this.isDarkMode,
  });

  @override
  State<CanteenPage> createState() => _CanteenPageState();
}

class _CanteenPageState extends State<CanteenPage>
    with SingleTickerProviderStateMixin {
  static const Color themeColor = Color(0xFF1D4ED8);
  static const Color greenAccent = Color(0xFF10B981);
  String selectedMonthKey = "March";

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  final Map<String, String> monthTranslations = {
    "September": "سبتمبر",
    "October": "أكتوبر",
    "November": "نوفمبر",
    "December": "ديسمبر",
    "January": "يناير",
    "February": "فبراير",
    "March": "مارس",
    "April": "أبريل",
    "May": "مايو",
  };

  final Map<String, Map<String, dynamic>> monthlyData = {
    "September": {
      "balance": 400.0,
      "savings": 120.0,
      "ratios": [0.3, 0.2, 0.3, 0.2],
      "daily": {
        "الأحد 15": [
          {"item": "كشكول سلك كبير", "price": "65", "time": "08:30 AM"},
          {"item": "قلم جاف روترنج", "price": "15", "time": "09:00 AM"}
        ],
        "الاثنين 16": [
          {"item": "ساندوتش كبدة", "price": "35", "time": "11:00 AM"}
        ]
      }
    },
    "October": {
      "balance": 350.0,
      "savings": 90.0,
      "ratios": [0.4, 0.1, 0.3, 0.2],
      "daily": {
        "الثلاثاء 3": [
          {"item": "تصوير ملازم ميكانيكا", "price": "40", "time": "12:00 PM"},
          {"item": "قهوة فرنسي", "price": "30", "time": "01:00 PM"}
        ]
      }
    },
    "November": {
      "balance": 300.0,
      "savings": 50.0,
      "ratios": [0.2, 0.4, 0.2, 0.2],
      "daily": {
        "الأربعاء 8": [
          {"item": "باتيه جبنة", "price": "20", "time": "10:00 AM"},
          {"item": "كانز بيبسي", "price": "15", "time": "11:30 AM"}
        ]
      }
    },
    "December": {
      "balance": 280.0,
      "savings": 40.0,
      "ratios": [0.3, 0.3, 0.2, 0.2],
      "daily": {
        "الخميس 14": [
          {"item": "تغليف مشروع", "price": "50", "time": "02:00 PM"}
        ]
      }
    },
    "January": {
      "balance": 600.0,
      "savings": 250.0,
      "ratios": [0.5, 0.1, 0.2, 0.2],
      "daily": {
        "الأحد 2": [
          {"item": "أقلام رصاص فابر كاستل", "price": "45", "time": "09:00 AM"}
        ]
      }
    },
    "February": {
      "balance": 420.0,
      "savings": 160.0,
      "ratios": [0.4, 0.2, 0.2, 0.2],
      "daily": {}
    },
    "March": {
      "balance": 460.0,
      "savings": 150.0,
      "ratios": [0.4, 0.25, 0.2, 0.15],
      "daily": {
        "الأحد 1": [
          {"item": "ساندوتش جبنة رومي", "price": "25", "time": "10:30 AM"},
          {"item": "عصير جهينة", "price": "15", "time": "12:15 PM"}
        ],
        "الاثنين 2": [
          {"item": "قلم سنون 0.5", "price": "35", "time": "09:00 AM"},
          {"item": "أستيكة روترنج", "price": "10", "time": "09:05 AM"}
        ]
      }
    },
    "April": {
      "balance": 390.0,
      "savings": 110.0,
      "ratios": [0.3, 0.3, 0.2, 0.2],
      "daily": {}
    },
    "May": {
      "balance": 220.0,
      "savings": 45.0,
      "ratios": [0.2, 0.2, 0.3, 0.3],
      "daily": {}
    },
  };

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _changeMonth(String? key) {
    if (key == null) return;
    _animController.reset();
    setState(() => selectedMonthKey = key);
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final data = monthlyData[selectedMonthKey] ?? monthlyData["March"]!;
    final double nowBalance = data['balance'];
    final double startBalance = nowBalance + data['savings'] + 50;
    final String cur = widget.isArabic ? "ج.م" : "EGP";
    final String displayedMonth = widget.isArabic
        ? monthTranslations[selectedMonthKey]!
        : selectedMonthKey;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
          child: Column(children: [
            // ===== Balance Hero Card =====
            _buildBalanceHero(isDark, startBalance, nowBalance, data, cur,
                displayedMonth, textColor, cardColor),
            const SizedBox(height: 18),

            // ===== Stats Row =====
            _buildStatsRow(isDark, cur, nowBalance, startBalance, data,
                cardColor, textColor),
            const SizedBox(height: 24),

            // ===== Daily Purchases =====
            _buildSectionHeader(
                widget.isArabic ? "مشتريات يومية" : "Daily Purchases",
                isDark,
                textColor),
            const SizedBox(height: 14),
            _buildDailyPurchaseList(
                isDark, cur, data['daily'], cardColor, textColor),
            const SizedBox(height: 20),

            // ===== Top Up Button =====
            _buildTopUpButton(context),
            const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }

  // ─── Balance Hero ──────────────────────────────────────────────
  Widget _buildBalanceHero(bool isDark, double start, double now, Map data,
      String cur, String month, Color textColor, Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: themeColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
              color: themeColor.withOpacity(isDark ? 0.15 : 0.07),
              blurRadius: 20,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(children: [
        // Top row
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _buildMonthPicker(isDark),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(widget.isArabic ? "رصيد بداية $month" : "Start Balance $month",
                style:
                    TextStyle(color: textColor.withOpacity(0.5), fontSize: 12)),
            const SizedBox(height: 2),
            Text("${start.toStringAsFixed(0)} $cur",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: textColor)),
          ]),
        ]),
        const SizedBox(height: 28),
        // Donut chart
        _buildDonutChart(data['savings'].toString(),
            List<double>.from(data['ratios']), cur, isDark, textColor),
        const SizedBox(height: 20),
        // Spend progress
        _buildSpendProgress(isDark, start, now, cur, textColor),
      ]),
    );
  }

  Widget _buildSpendProgress(
      bool isDark, double start, double now, String cur, Color textColor) {
    final spent = start - now;
    final pct = spent / start;
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
            "${spent.toStringAsFixed(0)} $cur ${widget.isArabic ? 'مصروف' : 'spent'}",
            style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        Text(
            "${now.toStringAsFixed(0)} $cur ${widget.isArabic ? 'متبقي' : 'left'}",
            style: const TextStyle(
                color: greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
      ]),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: pct.clamp(0.0, 1.0),
          minHeight: 7,
          backgroundColor: greenAccent.withOpacity(0.15),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    ]);
  }

  // ─── Stats Row ─────────────────────────────────────────────────
  Widget _buildStatsRow(bool isDark, String cur, double now, double start,
      Map data, Color cardColor, Color textColor) {
    return Row(children: [
      _statCard(
          isDark,
          widget.isArabic ? "الرصيد الحالي" : "Balance",
          "${now.toStringAsFixed(0)} $cur",
          themeColor,
          Icons.account_balance_wallet_rounded,
          cardColor),
      const SizedBox(width: 12),
      _statCard(
          isDark,
          widget.isArabic ? "التوفير" : "Saved",
          "${data['savings'].toStringAsFixed(0)} $cur",
          greenAccent,
          Icons.savings_rounded,
          cardColor),
      const SizedBox(width: 12),
      _statCard(
          isDark,
          widget.isArabic ? "المصروف" : "Spent",
          "${(start - now).toStringAsFixed(0)} $cur",
          Colors.redAccent,
          Icons.trending_down_rounded,
          cardColor),
    ]);
  }

  Widget _statCard(bool isDark, String label, String val, Color color,
          IconData icon, Color cardColor) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Column(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.12), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 7),
            Text(val,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.w900, fontSize: 12),
                textAlign: TextAlign.center),
            Text(label,
                style: TextStyle(
                    fontSize: 9,
                    color: color.withOpacity(0.7),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ]),
        ),
      );

  // ─── Section header ────────────────────────────────────────────
  Widget _buildSectionHeader(String title, bool isDark, Color textColor) =>
      Row(children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(title,
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w800, color: textColor)),
      ]);

  // ─── Daily purchases ───────────────────────────────────────────
  Widget _buildDailyPurchaseList(bool isDark, String cur, Map dailyData,
      Color cardColor, Color textColor) {
    if (dailyData.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: themeColor.withOpacity(0.08)),
        ),
        child: Column(children: [
          Icon(Icons.shopping_basket_outlined,
              size: 44, color: textColor.withOpacity(0.2)),
          const SizedBox(height: 10),
          Text(
              widget.isArabic
                  ? "لا توجد مشتريات هذا الشهر"
                  : "No purchases this month",
              style:
                  TextStyle(color: textColor.withOpacity(0.4), fontSize: 14)),
        ]),
      );
    }

    return Column(
      children: dailyData.entries.map<Widget>((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                      color: themeColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(entry.key,
                    style: const TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ]),
            ),
            ...List.generate(entry.value.length, (i) {
              final p = entry.value[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: themeColor.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Row(children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.shopping_cart_rounded,
                        color: themeColor, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(p['item'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: textColor,
                                fontSize: 13)),
                        const SizedBox(height: 2),
                        Text(p['time'],
                            style: TextStyle(
                                color: textColor.withOpacity(0.4),
                                fontSize: 11)),
                      ])),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("-${p['price']} $cur",
                        style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                ]),
              );
            }),
          ],
        );
      }).toList(),
    );
  }

  // ─── Top up button ─────────────────────────────────────────────
  Widget _buildTopUpButton(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => TopUpPage(
                    isArabic: widget.isArabic, themeColor: themeColor))),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF10B981)],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                  color: greenAccent.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 7))
            ],
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  const Icon(Icons.add_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Text(widget.isArabic ? "اشحن محفظتك الآن" : "Top Up Your Wallet",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ]),
        ),
      );

  // ─── Month picker ──────────────────────────────────────────────
  Widget _buildMonthPicker(bool isDark) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF1D4ED8)]),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: themeColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedMonthKey,
            dropdownColor: const Color(0xFF1A237E),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.white, size: 20),
            onChanged: _changeMonth,
            items: monthlyData.keys
                .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(widget.isArabic ? monthTranslations[m]! : m,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ))
                .toList(),
          ),
        ),
      );

  // ─── Donut chart ───────────────────────────────────────────────
  Widget _buildDonutChart(String savings, List<double> ratios, String cur,
          bool isDark, Color textColor) =>
      Stack(alignment: Alignment.center, children: [
        SizedBox(
          width: 160,
          height: 160,
          child: CustomPaint(
              painter:
                  DonutChartPainter(ratios: ratios, themeColor: themeColor)),
        ),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text("$savings $cur",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, color: textColor)),
          const SizedBox(height: 2),
          Text(widget.isArabic ? "وفّرتي 🎉" : "Saved 🎉",
              style: const TextStyle(
                  color: greenAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ]),
      ]);
}

// ══════════════════════════════════════════════════════════════
// TopUpPage
// ══════════════════════════════════════════════════════════════
class TopUpPage extends StatefulWidget {
  final bool isArabic;
  final Color themeColor;
  const TopUpPage(
      {super.key, required this.isArabic, required this.themeColor});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TextEditingController _amountController =
      TextEditingController(text: "100");
  final TextEditingController _pinController = TextEditingController();
  int? selectedQuickAmount = 100;
  String selectedMethod = "card";
  String? pinError;

  void _showSuccessBanner(String msg) {
    late OverlayEntry entry;
    entry = OverlayEntry(
        builder: (_) => Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF059669), Color(0xFF10B981)]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6))
                    ],
                  ),
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(msg,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))),
                  ]),
                ),
              ),
            ));
    Overlay.of(context).insert(entry);
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
      if (mounted) Navigator.pop(context);
    });
  }

  void _handleConfirmation() {
    final pin = _pinController.text;
    if (pin.isEmpty) {
      setState(() =>
          pinError = widget.isArabic ? "يرجى إدخال الرقم السري" : "Enter PIN");
    } else if (pin.startsWith('0') || double.tryParse(pin) == null) {
      setState(() =>
          pinError = widget.isArabic ? "الرقم السري غير صحيح" : "Invalid PIN");
    } else {
      setState(() => pinError = null);
      _showSuccessBanner(widget.isArabic
          ? "تمت عملية الشحن بنجاح ✅ ${_amountController.text} ج.م"
          : "Top up successful ✅ ${_amountController.text} EGP");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

    return Directionality(
      textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
        body: Column(children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF1D4ED8),
                  Color(0xFF0284C7)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const Spacer(),
                  Text(widget.isArabic ? "شحن المحفظة" : "Top Up Wallet",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  const Spacer(),
                  const SizedBox(width: 38),
                ]),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    // Quick amounts
                    _sectionLabel(
                        widget.isArabic ? "اختر مبلغاً سريعاً" : "Quick Amount",
                        textColor),
                    const SizedBox(height: 12),
                    Row(
                        children: [50, 100, 250, 500].map((amt) {
                      final isSelected = selectedQuickAmount == amt;
                      return Expanded(
                          child: GestureDetector(
                        onTap: () => setState(() {
                          selectedQuickAmount = amt;
                          _amountController.text = amt.toString();
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1D4ED8)
                                : cardColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF1D4ED8)
                                    : Colors.grey.withOpacity(0.2)),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                        color: const Color(0xFF1D4ED8)
                                            .withOpacity(0.3),
                                        blurRadius: 10)
                                  ]
                                : null,
                          ),
                          child: Column(children: [
                            Text("$amt",
                                style: TextStyle(
                                    color:
                                        isSelected ? Colors.white : textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Text(widget.isArabic ? "ج.م" : "EGP",
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white70
                                        : textColor.withOpacity(0.5),
                                    fontSize: 10)),
                          ]),
                        ),
                      ));
                    }).toList()),

                    const SizedBox(height: 24),
                    _sectionLabel(
                        widget.isArabic ? "المبلغ" : "Amount", textColor),
                    const SizedBox(height: 10),
                    _inputField(
                      isDark,
                      cardColor,
                      textColor,
                      controller: _amountController,
                      hint: widget.isArabic ? "أدخل المبلغ" : "Enter amount",
                      icon: Icons.payments_rounded,
                      keyboardType: TextInputType.number,
                      suffix: widget.isArabic ? "ج.م" : "EGP",
                    ),
                    const SizedBox(height: 16),
                    _sectionLabel("PIN", textColor),
                    const SizedBox(height: 10),
                    _inputField(
                      isDark,
                      cardColor,
                      textColor,
                      controller: _pinController,
                      hint: "••••",
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                    ),
                    if (pinError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(children: [
                          const Icon(Icons.error_rounded,
                              color: Colors.redAccent, size: 15),
                          const SizedBox(width: 6),
                          Text(pinError!,
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),

                    const SizedBox(height: 24),
                    _sectionLabel(
                        widget.isArabic ? "طريقة الدفع" : "Payment Method",
                        textColor),
                    const SizedBox(height: 12),
                    _methodTile(
                        "card",
                        Icons.credit_card_rounded,
                        widget.isArabic ? "بطاقة بنكية" : "Credit Card",
                        isDark,
                        cardColor,
                        textColor),
                    _methodTile("wallet", Icons.account_balance_wallet_rounded,
                        "Vodafone Cash", isDark, cardColor, textColor),

                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: _handleConfirmation,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xFF059669), Color(0xFF10B981)],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xFF10B981).withOpacity(0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6))
                          ],
                        ),
                        child: Center(
                          child: Text(
                              widget.isArabic
                                  ? "تأكيد الشحن"
                                  : "Confirm Top Up",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _sectionLabel(String t, Color textColor) => Text(t,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: textColor.withOpacity(0.6)));

  Widget _inputField(bool isDark, Color cardColor, Color textColor,
      {required TextEditingController controller,
      required String hint,
      required IconData icon,
      bool isPassword = false,
      int? maxLength,
      TextInputType? keyboardType,
      String? suffix}) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1D4ED8).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.1 : 0.04),
              blurRadius: 8)
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        maxLength: maxLength,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: textColor.withOpacity(0.3)),
          prefixIcon: Icon(icon, color: const Color(0xFF1D4ED8), size: 20),
          suffixText: suffix,
          suffixStyle: TextStyle(
              color: textColor.withOpacity(0.5), fontWeight: FontWeight.bold),
          border: InputBorder.none,
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _methodTile(String id, IconData icon, String title, bool isDark,
      Color cardColor, Color textColor) {
    final isSelected = selectedMethod == id;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1D4ED8).withOpacity(0.06)
              : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected
                  ? const Color(0xFF1D4ED8)
                  : Colors.grey.withOpacity(0.15),
              width: isSelected ? 1.5 : 1),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: const Color(0xFF1D4ED8).withOpacity(0.1),
                      blurRadius: 8)
                ]
              : null,
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: (isSelected ? const Color(0xFF1D4ED8) : Colors.grey)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                color: isSelected ? const Color(0xFF1D4ED8) : Colors.grey,
                size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color:
                          isSelected ? const Color(0xFF1D4ED8) : textColor))),
          if (isSelected)
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                  color: Color(0xFF1D4ED8), shape: BoxShape.circle),
              child: const Icon(Icons.check_rounded,
                  color: Colors.white, size: 14),
            ),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// DonutChartPainter
// ══════════════════════════════════════════════════════════════
class DonutChartPainter extends CustomPainter {
  final List<double> ratios;
  final Color themeColor;
  DonutChartPainter({required this.ratios, required this.themeColor});

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
