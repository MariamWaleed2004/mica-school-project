import 'package:flutter/material.dart';

class FeesPage extends StatefulWidget {
  final bool isArabic;
  const FeesPage({super.key, required this.isArabic});

  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor =
        isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    final isAr = widget.isArabic;

    // 29,300 paid, 10,000 remaining, total = 39,300
    const double totalAmount = 39300;
    const double paidAmount = 29300;
    const double remaining = 10000;
    final double paidPct = paidAmount / totalAmount;

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
        body: FadeTransition(
          opacity: _fade,
          child: Column(
            children: [
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
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                    child: Column(children: [
                      Row(children: [
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
                        Text(isAr ? "السجلات المالية" : "Financial Records",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                        const Spacer(),
                        const SizedBox(width: 38),
                      ]),
                      const SizedBox(height: 24),
                      // Balance display
                      Text(isAr ? "إجمالي المبلغ المتبقي" : "Total Remaining",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      const Text("10,000 EGP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w900)),
                      const SizedBox(height: 20),
                      // Progress
                      Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${(paidPct * 100).toInt()}% ${isAr ? 'مدفوع' : 'Paid'}",
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              Text(
                                  "${isAr ? 'المتبقي' : 'Remaining'}: 10,000 EGP",
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                            ]),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: paidPct,
                            minHeight: 8,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF10B981)),
                          ),
                        ),
                      ]),
                    ]),
                  ),
                ),
              ),

              // Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    // Stats row
                    Row(children: [
                      _miniStatCard(
                          isAr ? "إجمالي المصاريف" : "Total",
                          "39,300",
                          const Color(0xFF6366F1),
                          Icons.receipt_long_rounded,
                          isDark),
                      const SizedBox(width: 12),
                      _miniStatCard(
                          isAr ? "المدفوع" : "Paid",
                          "29,300",
                          const Color(0xFF10B981),
                          Icons.check_circle_rounded,
                          isDark),
                      const SizedBox(width: 12),
                      _miniStatCard(
                          isAr ? "المتبقي" : "Due",
                          "10,000",
                          const Color(0xFFEF4444),
                          Icons.pending_rounded,
                          isDark),
                    ]),
                    const SizedBox(height: 24),

                    _sectionHeader(
                        isAr ? "المصاريف الدراسية" : "Academic Fees", isDark),
                    const SizedBox(height: 12),
                    _buildFeeRow(
                      isAr ? "القسط الأول" : "1st Installment",
                      "15,000",
                      isAr ? "مدفوع" : "Paid",
                      const Color(0xFF10B981),
                      cardColor,
                      textColor,
                      isDark,
                      icon: Icons.school_rounded,
                    ),
                    _buildFeeRow(
                      isAr ? "القسط الثاني" : "2nd Installment",
                      "10,000",
                      isAr ? "متبقي" : "Pending",
                      const Color(0xFFEF4444),
                      cardColor,
                      textColor,
                      isDark,
                      icon: Icons.hourglass_top_rounded,
                    ),
                    const SizedBox(height: 16),

                    _sectionHeader(
                        isAr ? "المستلزمات والخدمات" : "Supplies & Services",
                        isDark),
                    const SizedBox(height: 12),
                    _buildFeeRow(
                      isAr ? "الزي المدرسي" : "School Uniform",
                      "2,500",
                      isAr ? "مدفوع" : "Paid",
                      const Color(0xFF10B981),
                      cardColor,
                      textColor,
                      isDark,
                      icon: Icons.checkroom_rounded,
                    ),
                    _buildFeeRow(
                      isAr ? "الكتب الدراسية" : "Textbooks",
                      "1,800",
                      isAr ? "مدفوع" : "Paid",
                      const Color(0xFF10B981),
                      cardColor,
                      textColor,
                      isDark,
                      icon: Icons.menu_book_rounded,
                    ),
                    const SizedBox(height: 24),

                    // Pay now button
                    Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1A237E), Color(0xFF1D4ED8)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF1D4ED8).withOpacity(0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6)),
                        ],
                      ),
                      child: Center(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.payment_rounded,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 10),
                          Text(
                              isAr ? "دفع القسط الثاني" : "Pay 2nd Installment",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ]),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniStatCard(
          String label, String val, Color color, IconData icon, bool isDark) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
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
                  color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 6),
            Text(val,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.w900, fontSize: 13)),
            Text(label,
                style: TextStyle(
                    fontSize: 9,
                    color: color.withOpacity(0.7),
                    fontWeight: FontWeight.w600)),
          ]),
        ),
      );

  Widget _sectionHeader(String title, bool isDark) => Row(children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0D1333))),
      ]);

  Widget _buildFeeRow(String title, String amount, String status, Color color,
      Color cardColor, Color textColor, bool isDark,
      {required IconData icon}) {
    final isPaid = status == "مدفوع" || status == "Paid";
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 14, color: textColor)),
          const SizedBox(height: 3),
          Text("$amount EGP",
              style: const TextStyle(
                  color: Color(0xFF1D4ED8),
                  fontWeight: FontWeight.w900,
                  fontSize: 15)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(isPaid ? Icons.check_rounded : Icons.schedule_rounded,
                color: color, size: 14),
            const SizedBox(width: 5),
            Text(status,
                style: TextStyle(
                    color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          ]),
        ),
      ]),
    );
  }
}
