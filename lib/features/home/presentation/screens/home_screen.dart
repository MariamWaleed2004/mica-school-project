import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:mica_school_app/features/home/presentation/cubit/teacher_rating_cubit/teacher_rating_cubit.dart';
import 'package:mica_school_app/features/home/presentation/widgets/build_grade_badge_widget.dart';
import 'package:mica_school_app/features/home/presentation/widgets/build_header.dart';
import 'package:mica_school_app/features/home/presentation/widgets/schedule_card_widget.dart';
import 'package:mica_school_app/features/home/presentation/widgets/section_label_widget.dart';
import 'package:mica_school_app/features/home/presentation/widgets/fees_card_widget.dart';
import 'package:mica_school_app/features/homework/presentation/widgets/homework_card_widget.dart';
import 'package:mica_school_app/features/home/presentation/widgets/teacher_rating_section_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onNavigate;
  final bool isArabic;
  final String? profileImage;

  const HomeScreen({
    super.key,
    required this.onNavigate,
    required this.isArabic,
    this.profileImage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  final RefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _loadData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  Future<void> _loadData() async {
    context.read<GetSingleUserCubit>().getSingleUser(
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    context.read<TeacherRatingCubit>().getTeacherRatings(
      FirebaseAuth.instance.currentUser!.uid,
    );
  }

  Future<void> _onRefresh() async {
    await _loadData();
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
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);
    final bg = isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF);

    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, userState) {
        if (userState is GetSingleUserLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (userState is GetSingleUserLoaded) {
          final user = userState.user;

          return Scaffold(
            backgroundColor: bg,
            body: RefreshIndicator(
              key: RefreshIndicatorKey,
              onRefresh: _onRefresh,
              color: Colors.white,
              backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              strokeWidth: 2,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      BuildHeaderWidget(
                        isDark: false,
                        isArabic: widget.isArabic,
                        profileImageUrl:
                            widget.profileImage ?? user.profileImageUrl,
                        nameAr: user.nameAr ?? "UserAr",
                        nameEn: user.nameEn ?? "UserEN",
                        isActive: user.isActive ?? false,
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Grade Badge
                            BuildGradeBadgeWidget(
                              isArabic: widget.isArabic,
                              isDark: isDark,
                              cardColor: cardColor,
                              textColor: textColor,
                              gradeAr: user.gradeAr ?? 'gradeAr',
                              gradeEn: user.gradeEn ?? 'gradeEn',
                              gradeNum: user.gradeNum ?? 'gradeNum',
                              majorEn: user.majorEn ?? 'majorEn',
                              majorAr: user.majorAr ?? 'majorAr',
                            ),
                            const SizedBox(height: 24),

                            // Schedule Section
                            SectionLabelWidget(
                              text: widget.isArabic ? "جدولك" : "Your Schedule",
                              color: textColor,
                            ),
                            const SizedBox(height: 12),

                            ScheduleCardWidget(
                              isDark: isDark,
                              isArabic: widget.isArabic,
                              onNavigate: widget.onNavigate,
                            ),

                            const SizedBox(height: 24),

                            // Fees Section
                            SectionLabelWidget(
                              text: widget.isArabic ? "مصاريفك" : "Your Fees",
                              color: textColor,
                            ),
                            const SizedBox(height: 12),
                            FeesCardWidget(
                              isDark: isDark,
                              isArabic: widget.isArabic,
                              cardColor: cardColor,
                              textColor: textColor,
                              onTap: () => widget.onNavigate('fees'),
                            ),

                            const SizedBox(height: 24),

                            // Homework Section
                            SectionLabelWidget(
                              text: widget.isArabic ? "الواجبات" : "Homework",
                              color: textColor,
                            ),
                            const SizedBox(height: 12),
                            HomeworkCardWidget(
                              isDark: isDark,
                              isArabic: widget.isArabic,
                              cardColor: cardColor,
                              textColor: textColor,
                              onTap: () => widget.onNavigate(
                                'homework',
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Teacher Ratings Section
                            SectionLabelWidget(
                              text: widget.isArabic
                                  ? "⭐ تقييمات المدرسين"
                                  : "⭐ Teacher Ratings",
                              color: textColor,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.isArabic
                                  ? "تقييمات المدرسين لك"
                                  : "Teacher evaluations for you",
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor.withOpacity(0.45),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TeacherRatingsSectionWidget(
                              isArabic: widget.isArabic,
                              isDark: isDark,
                              cardColor: cardColor,
                              textColor: textColor,
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text("Error loading user data")),
        );
      },
    );
  }
}