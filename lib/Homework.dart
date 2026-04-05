import 'package:flutter/material.dart';

class HomeworkPage extends StatefulWidget {
  final bool isArabic;
  const HomeworkPage({super.key, required this.isArabic});

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Set<int> _doneItems = {};

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
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor =
        isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);

    final tasks = [
      {
        "sub": widget.isArabic ? "ميكانيكا" : "Mechanics",
        "task": widget.isArabic ? "حل مسائل الحركة" : "Solve motion problems",
        "due": widget.isArabic ? "غداً" : "Tomorrow",
        "color": const Color(0xFF3B82F6),
        "emoji": "⚙️"
      },
      {
        "sub": widget.isArabic ? "إنجليزي" : "English",
        "task":
            widget.isArabic ? "ترجمة الدرس الأول" : "Translate first lesson",
        "due": widget.isArabic ? "الأحد" : "Sunday",
        "color": const Color(0xFF6366F1),
        "emoji": "📖"
      },
      {
        "sub": widget.isArabic ? "مشروعات برمجية" : "Software Projects",
        "task": widget.isArabic ? "تصميم واجهة الهوم" : "Design home interface",
        "due": widget.isArabic ? "هذا الأسبوع" : "This week",
        "color": const Color(0xFF10B981),
        "emoji": "💻"
      },
      {
        "sub": widget.isArabic ? "تكنولوجيا مقايسات" : "Estimates Tech",
        "task": widget.isArabic
            ? "بحث عن أنواع المقايسات"
            : "Research types of estimates",
        "due": widget.isArabic ? "الخميس" : "Thursday",
        "color": const Color(0xFFF59E0B),
        "emoji": "🔬"
      },
      {
        "sub": widget.isArabic ? "تدريب عملي" : "Practical Training",
        "task": widget.isArabic
            ? "تجهيز التقرير الفني"
            : "Prepare technical report",
        "due": widget.isArabic ? "الأسبوع القادم" : "Next week",
        "color": const Color(0xFFEC4899),
        "emoji": "📋"
      },
    ];

    final done = _doneItems.length;
    final total = tasks.length;
    final progress = total > 0 ? done / total : 0.0;

    return Directionality(
      textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
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
                      Text(widget.isArabic ? "واجباتي الدراسية" : "My Homework",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text("$done/$total",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    // Progress bar
                    Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                widget.isArabic
                                    ? "إجمالي التقدم"
                                    : "Overall Progress",
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12)),
                            Text("${(progress * 100).toInt()}%",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ]),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
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

            // Tasks list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                physics: const BouncingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final isDone = _doneItems.contains(index);
                  final color = task['color'] as Color;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: isDone ? color.withOpacity(0.06) : cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDone
                            ? color.withOpacity(0.4)
                            : color.withOpacity(0.15),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(isDone ? 0.12 : 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        // Check button
                        GestureDetector(
                          onTap: () => setState(() {
                            if (isDone)
                              _doneItems.remove(index);
                            else
                              _doneItems.add(index);
                          }),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: isDone ? color : color.withOpacity(0.1),
                              shape: BoxShape.circle,
                              boxShadow: isDone
                                  ? [
                                      BoxShadow(
                                          color: color.withOpacity(0.4),
                                          blurRadius: 10)
                                    ]
                                  : null,
                            ),
                            child: Icon(
                              isDone
                                  ? Icons.check_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              color: isDone ? Colors.white : color,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Emoji
                        Text(task['emoji'] as String,
                            style: const TextStyle(fontSize: 26)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task['sub'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: isDone
                                      ? textColor.withOpacity(0.4)
                                      : textColor,
                                  decoration: isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                )),
                            const SizedBox(height: 3),
                            Text(task['task'] as String,
                                style: TextStyle(
                                  color: textColor
                                      .withOpacity(isDone ? 0.3 : 0.55),
                                  fontSize: 12,
                                  decoration: isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                )),
                          ],
                        )),
                        // Due date chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: color.withOpacity(isDone ? 0.06 : 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(task['due'] as String,
                              style: TextStyle(
                                  color:
                                      isDone ? color.withOpacity(0.4) : color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
