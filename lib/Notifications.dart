import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final bool isArabic;
  const NotificationsPage({super.key, required this.isArabic});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Set<int> _readItems = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
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
    final isAr = widget.isArabic;

    final notifications = [
      {
        "title": isAr ? "تذكير بالقسط القادم" : "Next Installment",
        "body": isAr
            ? "موعد القسط القادم مطلع الشهر، يرجى الالتزام بالموعد."
            : "Next installment is due early next month.",
        "time": isAr ? "الآن" : "Now",
        "icon": Icons.account_balance_wallet_rounded,
        "color": const Color(0xFF3B82F6),
        "tag": isAr ? "مالي" : "Finance"
      },
      {
        "title": isAr ? "تأكيد الدفع" : "Payment Confirmed",
        "body": isAr
            ? "تم استلام القسط بنجاح. شكراً لك."
            : "Installment received successfully. Thank you.",
        "time": isAr ? "منذ ساعة" : "1h ago",
        "icon": Icons.check_circle_rounded,
        "color": const Color(0xFF10B981),
        "tag": isAr ? "دفع" : "Paid"
      },
      {
        "title": isAr ? "الزي الدراسي" : "School Uniform",
        "body": isAr
            ? "يرجى الحضور بالزي الكامل غداً لوجود تفتيش."
            : "Please wear the full uniform tomorrow.",
        "time": isAr ? "منذ 3 ساعات" : "3h ago",
        "icon": Icons.checkroom_rounded,
        "color": const Color(0xFFF59E0B),
        "tag": isAr ? "انضباط" : "Uniform"
      },
      {
        "title": isAr ? "تنبيه الحضور" : "Attendance Alert",
        "body": isAr
            ? "الحضور 7:30 ص. ممنوع التأخير حفاظاً على مصلحتكم."
            : "Arrival at 7:30 AM. No delays.",
        "time": isAr ? "منذ 5 ساعات" : "5h ago",
        "icon": Icons.timer_rounded,
        "color": const Color(0xFFEF4444),
        "tag": isAr ? "هام" : "Urgent"
      },
      {
        "title": isAr ? "تسليم صور" : "Submit Photos",
        "body": isAr
            ? "آخر موعد لتسليم (3) صور شخصية هو الأحد القادم."
            : "Deadline for 3 photos is next Sunday.",
        "time": isAr ? "أمس" : "Yesterday",
        "icon": Icons.camera_alt_rounded,
        "color": const Color(0xFF8B5CF6),
        "tag": isAr ? "إداري" : "Admin"
      },
    ];

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
      body: Column(
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
                  Text(
                      widget.isArabic
                          ? "مركز التنبيهات"
                          : "Notification Center",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFFEF4444).withOpacity(0.3)),
                    ),
                    child: Text("${notifications.length - _readItems.length}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ),
                ]),
              ),
            ),
          ),

          // Notifications list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
              physics: const BouncingScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                final isRead = _readItems.contains(index);
                final color = item['color'] as Color;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: isDark
                        ? (isRead
                            ? const Color(0xFF1E293B).withOpacity(0.5)
                            : const Color(0xFF1E293B))
                        : (isRead
                            ? Colors.white.withOpacity(0.6)
                            : Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: isRead
                            ? Colors.transparent
                            : color.withOpacity(0.2),
                        width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(isRead ? 0.03 : 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => setState(() => _readItems.add(index)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      color.withOpacity(isRead ? 0.06 : 0.12),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(item['icon'] as IconData,
                                    color:
                                        isRead ? color.withOpacity(0.5) : color,
                                    size: 26),
                              ),
                              const SizedBox(width: 14),
                              // Content
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: color.withOpacity(
                                                  isRead ? 0.05 : 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(item['tag'] as String,
                                                style: TextStyle(
                                                    color: isRead
                                                        ? color.withOpacity(0.5)
                                                        : color,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Row(children: [
                                            if (!isRead)
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                    color: color,
                                                    shape: BoxShape.circle),
                                                margin: const EdgeInsets.only(
                                                    left: 6, right: 6),
                                              ),
                                            Text(item['time'] as String,
                                                style: TextStyle(
                                                    color: isDark
                                                        ? Colors.grey[500]
                                                        : Colors.grey[400],
                                                    fontSize: 11)),
                                          ]),
                                        ]),
                                    const SizedBox(height: 8),
                                    Text(item['title'] as String,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: isRead
                                                ? (isDark
                                                    ? Colors.white60
                                                    : Colors.black45)
                                                : (isDark
                                                    ? Colors.white
                                                    : const Color(
                                                        0xFF0D1333)))),
                                    const SizedBox(height: 5),
                                    Text(item['body'] as String,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: isRead
                                                ? (isDark
                                                    ? Colors.grey[600]
                                                    : Colors.grey[400])
                                                : (isDark
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600]),
                                            height: 1.5)),
                                  ])),
                            ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
