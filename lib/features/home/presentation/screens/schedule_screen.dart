import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/home/presentation/cubit/schedule_cubit/schedule_cubit.dart';
import 'package:mica_school_app/features/home/presentation/widgets/schedule_widgets/section_header_widget.dart';
import 'package:mica_school_app/features/home/presentation/widgets/schedule_widgets/build_exam_card_widget.dart';
import 'package:mica_school_app/features/home/presentation/widgets/schedule_widgets/build_subject_card_widget.dart';

class ScheduleScreen extends StatefulWidget {
  final bool isArabic;

  const ScheduleScreen({super.key, required this.isArabic,});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;






// ========================================= Init State ======================================================
  @override
void initState() {
  super.initState();
  _loadData();
  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  _controller.forward();
}



// ========================================= Load Data Function =============================================
void _loadData() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  if (uid == null) return;

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();

  final majorId = doc['majorId'];

  context.read<ScheduleCubit>().getSchedule(majorId);
}




// ========================================= DISPOSE ======================================================
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



// ========================================== BUILD METHOD ============================================
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor =
        isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),

      body: BlocConsumer<ScheduleCubit, ScheduleState>(
        listener: (context, state) {},

        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ScheduleFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is ScheduleLoaded) {
            final exams = state.exams;
            final subjects = state.subjects;
            final subjectsCount = subjects.length;

            return Directionality(
              textDirection:
                  widget.isArabic ? TextDirection.rtl : TextDirection.ltr,

              child: FadeTransition(
                opacity: _fade,

                child: Column(
                  children: [
       
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF1A237E),
                            Color(0xFF1D4ED8),
                            Color(0xFF0284C7),
                          ],
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
                          child: Row(
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


// =========================================  APP BAR ======================================================
                              Text(
                                widget.isArabic
                                    ? "المواد والجدول الدراسي"
                                    : "Courses & Schedule",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),

                              const Spacer(),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "$subjectsCount ${widget.isArabic ? 'مواد' : 'Subjects'}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),


// ========================================= SUBJECT LIST =============================================
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SectionHeaderWidget(
                            isDark: isDark,
                            textColor: textColor,
                            title: widget.isArabic
                                ? "جدول حصص اليوم"
                                : "Today's Schedule",
                          ),

                          const SizedBox(height: 14),

                    
                          ...subjects.map((subject) {

        // -------------------- Build Subject Card Widget --------------------
                            return BuildSubjectCardWidget(
                              subject: subject,
                              cardColor: cardColor,
                              isDark: isDark,
                              isArabic: widget.isArabic,
                            );
                          }).toList(),

                          const SizedBox(height: 24),

        // -------------------- Section Header Widget --------------------
                          SectionHeaderWidget(
                            isDark: isDark,
                            textColor: textColor,
                            title: widget.isArabic
                                ? "مواعيد الامتحانات"
                                : "Exams Dates",
                          ),
                          const SizedBox(height: 14),

// ========================================= Exams List =============================================
                          ...exams.map((exam) {
          // -------------------- Build Exam Card Widget --------------------
                            return BuildExamCardWidget(
                              exam: exam,
                              cardColor: cardColor,
                              textColor: textColor,
                              isDark: isDark,
                              isArabic: widget.isArabic,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
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
}