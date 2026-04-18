// lib/features/homework/presentation/screens/homework_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';
import 'package:mica_school_app/features/homework/presentation/cubit/homework_cubit.dart';
import 'package:mica_school_app/features/homework/presentation/cubit/homework_state.dart';

class HomeworkScreen extends StatefulWidget {
  final bool isArabic;
  final String userId;

  const HomeworkScreen({
    super.key,
    required this.isArabic,
    required this.userId,
  });

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller.forward();
    
    context.read<HomeworkCubit>().getHomeworks(widget.userId);
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
    final textColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);

    return BlocBuilder<HomeworkCubit, HomeworkState>(
      builder: (context, state) {
        if (state is HomeworkLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeworkError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeworkCubit>().getHomeworks(widget.userId);
                    },
                    child: Text(widget.isArabic ? "إعادة المحاولة" : "Retry"),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is HomeworkLoaded) {
          final homeworks = state.homeworks;
          final done = homeworks.where((h) => h.isDone).length;
          final total = homeworks.length;
          final progress = total > 0 ? done / total : 0.0;

          return Directionality(
            textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
              body: Column(
                children: [
                  // Header
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1A237E), Color(0xFF1D4ED8), Color(0xFF0284C7)],
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  widget.isArabic ? "واجباتي الدراسية" : "My Homework",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "$done/$total",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.isArabic ? "إجمالي التقدم" : "Overall Progress",
                                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                                    ),
                                    Text(
                                      "${(progress * 100).toInt()}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 8,
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF10B981),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Tasks list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeworks.length,
                      itemBuilder: (context, index) {
                        final homework = homeworks[index];
                        final isDone = homework.isDone;
                        final color = homework.color;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: isDone ? color.withOpacity(0.06) : cardColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDone ? color.withOpacity(0.4) : color.withOpacity(0.15),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(isDone ? 0.12 : 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Check button
                                GestureDetector(
                                  onTap: () {
                                    context.read<HomeworkCubit>().toggleHomeworkStatus(
                                      widget.userId,
                                      homework.id,
                                      homework.isDone,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: isDone ? color : color.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                      boxShadow: isDone
                                          ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 10)]
                                          : null,
                                    ),
                                    child: Icon(
                                      isDone ? Icons.check_rounded : Icons.radio_button_unchecked_rounded,
                                      color: isDone ? Colors.white : color,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Emoji
                                Text(homework.emoji, style: const TextStyle(fontSize: 26)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.isArabic ? homework.subjectAr : homework.subjectEn,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                          color: isDone ? textColor.withOpacity(0.4) : textColor,
                                          decoration: isDone ? TextDecoration.lineThrough : null,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        widget.isArabic ? homework.taskAr : homework.taskEn,
                                        style: TextStyle(
                                          color: textColor.withOpacity(isDone ? 0.3 : 0.55),
                                          fontSize: 12,
                                          decoration: isDone ? TextDecoration.lineThrough : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Due date chip
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(isDone ? 0.06 : 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.isArabic ? homework.dueTextAr : homework.dueTextEn,
                                    style: TextStyle(
                                      color: isDone ? color.withOpacity(0.4) : color,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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

        return const SizedBox();
      },
    );
  }
}