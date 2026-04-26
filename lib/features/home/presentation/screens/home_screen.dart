// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mica_school_app/core/const.dart';
// import 'package:mica_school_app/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
// import 'package:mica_school_app/features/home/presentation/widgets/build_grade_badge_widget.dart';
// import 'package:mica_school_app/features/home/presentation/widgets/build_header.dart';
// import 'package:mica_school_app/features/home/presentation/widgets/build_schedule_button.dart';

// class HomeScreen extends StatefulWidget {
//   final Function(String) onNavigate;
//   final bool isArabic;
//   final String? profileImage;

//   const HomeScreen({
//     super.key,
//     required this.onNavigate,
//     required this.isArabic,
//     this.profileImage,
//   });

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnim;

//   // Teacher evaluations of the student (read-only, set by teachers)
//   final List<Map<String, dynamic>> teacherRatings = [
//     {
//       'nameAr': 'أ. محمد السيد',
//       'nameEn': 'Mr. Mohamed',
//       'subjectAr': 'الرياضيات',
//       'subjectEn': 'Mathematics',
//       'rating': 4,
//       'commentAr': 'الطالبة متميزة ومجتهدة، تحتاج مزيد من التركيز في الهندسة.',
//       'commentEn': 'Excellent student, needs more focus on geometry.',
//       'icon': '📐',
//       'color': Color(0xFF4F46E5),
//     },
//     {
//       'nameAr': 'أ. سارة أحمد',
//       'nameEn': 'Ms. Sara',
//       'subjectAr': 'الفيزياء',
//       'subjectEn': 'Physics',
//       'rating': 3,
//       'commentAr': 'أداء جيد، لكن يجب الاهتمام بحل المسائل العملية.',
//       'commentEn': 'Good performance, but needs to practice problem solving.',
//       'icon': '⚛️',
//       'color': Color(0xFF0284C7),
//     },
//     {
//       'nameAr': 'أ. خالد عمر',
//       'nameEn': 'Mr. Khaled',
//       'subjectAr': 'البرمجة',
//       'subjectEn': 'Programming',
//       'rating': 5,
//       'commentAr': 'ممتازة جداً، إبداع واضح في المشاريع البرمجية.',
//       'commentEn': 'Outstanding! Shows great creativity in coding projects.',
//       'icon': '💻',
//       'color': Color(0xFF10B981),
//     },
//     {
//       'nameAr': 'أ. منى حسن',
//       'nameEn': 'Ms. Mona',
//       'subjectAr': 'اللغة العربية',
//       'subjectEn': 'Arabic',
//       'rating': 4,
//       'commentAr': 'تعبير راقٍ وأسلوب متميز، استمري على نفس المستوى.',
//       'commentEn': 'Elegant writing style, keep up the great work.',
//       'icon': '📖',
//       'color': Color(0xFFEC4899),
//     },
//     {
//       'nameAr': 'أ. طارق علي',
//       'nameEn': 'Mr. Tarek',
//       'subjectAr': 'الكيمياء',
//       'subjectEn': 'Chemistry',
//       'rating': 3,
//       'commentAr': 'تحتاج مراجعة المعادلات الكيميائية بشكل أعمق.',
//       'commentEn': 'Needs deeper review of chemical equations.',
//       'icon': '🧪',
//       'color': Color(0xFFF59E0B),
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     context.read<GetSingleUserCubit>().getSingleUser(
//       uid: FirebaseAuth.instance.currentUser!.uid,
//   );

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//     _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // ---------------------------------------------------- Build Context ------------------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
//     final textColor = isDark ? Colors.white : const Color(0xFF0D1333);
//     final bg = isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF);

//     return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
//       builder: (context, state) {
//         if (state is GetSingleUserLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is GetSingleUserLoaded) {
//           final user = state.user;
//           return Scaffold(
//             backgroundColor: bg,
//             body: FadeTransition(
//               opacity: _fadeAnim,
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [

//    // --------------------------- Build Header Widget -------------------------------------------
//                     BuildHeaderWidget(
//                       isDark: false,
//                       isArabic: widget.isArabic,
//                       profileImageUrl: widget.profileImage ?? user.profileImageUrl,
//                       nameAr: user.nameAr ?? "UserAr",
//                       nameEn: user.nameEn ?? "UserEN",
//                       isActive: user.isActive ?? false,
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [

//   // -------------------------------- Build Grade Badge Widget -----------------------------------
//                           BuildGradeBadgeWidget(
//                             isArabic: widget.isArabic,
//                             isDark: isDark,
//                             cardColor: cardColor,
//                             textColor: textColor,
//                             gradeAr: user.gradeAr ?? 'gradeAr',
//                             gradeEn: user.gradeEn ?? 'gradeEn',
//                             gradeNum: user.gradeNum ?? 'gradeNum',
//                             majorEn: user.majorEn ?? 'majorEn',
//                             majorAr: user.majorAr ?? 'majorAr',
//                           ),
//                           const SizedBox(height: 24),

//                           _buildSectionLabel(
//                             widget.isArabic ? "جدولك" : "Your Schedule",
//                             textColor,
//                           ),
//                           const SizedBox(height: 12),

// // ----------------------------------- Build Schedule Button Widget ----------------------------------
//                           BuildScheduleButton(
//                             isDark: isDark,
//                             isArabic: widget.isArabic,
//                             onNavigate: widget.onNavigate,
//                           ),

//                           const SizedBox(height: 24),
//                           _buildSectionLabel(
//                             widget.isArabic ? "مصاريفك" : "Your Fees",
//                             textColor,
//                           ),
//                           const SizedBox(height: 12),
//                           _buildFeesCard(isDark, cardColor, textColor),

//                           const SizedBox(height: 24),
//                           _buildSectionLabel(
//                             widget.isArabic ? "الواجبات" : "Homework",
//                             textColor,
//                           ),
//                           const SizedBox(height: 12),
//                           _buildHomeworkCard(isDark, cardColor, textColor),

//                           const SizedBox(height: 24),
//                           // ── Teacher Ratings Section ──
//                           _buildSectionLabel(
//                             widget.isArabic
//                                 ? "⭐ تقييمات المدرسين"
//                                 : "⭐ Teacher Ratings",
//                             textColor,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             widget.isArabic
//                                 ? "اضغط على أي مدرس لتقييمه"
//                                 : "Tap a teacher to rate them",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: textColor.withOpacity(0.45),
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           _buildTeacherRatings(isDark, cardColor, textColor),

//                           const SizedBox(height: 40),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//         return const Text("Error loading user data");
//       },
//     );
//   }

//   Widget _buildTeacherRatings(bool isDark, Color cardColor, Color textColor) {
//     return Column(
//       children: List.generate(teacherRatings.length, (index) {
//         final teacher = teacherRatings[index];
//         final color = teacher['color'] as Color;
//         final rating = teacher['rating'] as int;
//         final comment = widget.isArabic
//             ? teacher['commentAr'] as String
//             : teacher['commentEn'] as String;

//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: color.withOpacity(0.25), width: 1.5),
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.06),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   // Subject icon
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: color.withOpacity(0.10),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Center(
//                       child: Text(
//                         teacher['icon'] as String,
//                         style: const TextStyle(fontSize: 24),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   // Name + subject
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.isArabic
//                               ? teacher['nameAr'] as String
//                               : teacher['nameEn'] as String,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w800,
//                             fontSize: 14,
//                             color: textColor,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           widget.isArabic
//                               ? teacher['subjectAr'] as String
//                               : teacher['subjectEn'] as String,
//                           style: TextStyle(
//                             color: color,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Stars (read-only)
//                   Row(
//                     children: List.generate(
//                       5,
//                       (i) => Icon(
//                         i < rating
//                             ? Icons.star_rounded
//                             : Icons.star_outline_rounded,
//                         color: Colors.amber,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               // Teacher comment
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.07),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.format_quote_rounded, color: color, size: 16),
//                     const SizedBox(width: 6),
//                     Expanded(
//                       child: Text(
//                         comment,
//                         style: TextStyle(
//                           fontSize: 12.5,
//                           color: textColor.withOpacity(0.75),
//                           height: 1.5,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildSectionLabel(String text, Color textColor) => Text(
//     text,
//     style: TextStyle(
//       fontSize: 17,
//       fontWeight: FontWeight.w800,
//       color: textColor,
//       letterSpacing: 0.2,
//     ),
//   );

//   Widget _buildFeesCard(bool isDark, Color cardColor, Color textColor) {
//     return GestureDetector(
//       onTap: () => widget.onNavigate('fees'),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: isDark
//                 ? [
//                     const Color(0xFF052e16).withOpacity(0.8),
//                     const Color(0xFF1E293B),
//                   ]
//                 : [const Color(0xFFf0fdf4), Colors.white],
//           ),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: const Color(0xFF10B981).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF10B981).withOpacity(0.08),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF10B981).withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: const Icon(
//                 Icons.account_balance_wallet_rounded,
//                 color: Color(0xFF10B981),
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.isArabic ? "تفاصيل المصروفات" : "Fees Details",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       color: textColor,
//                       fontSize: 15,
//                     ),
//                   ),
//                   Text(
//                     widget.isArabic
//                         ? "اضغط لعرض التفاصيل"
//                         : "Tap to view details",
//                     style: TextStyle(
//                       color: textColor.withOpacity(0.5),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: const Color(0xFF10B981),
//               size: 16,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHomeworkCard(bool isDark, Color cardColor, Color textColor) {
//     return GestureDetector(
//       onTap: () => widget.onNavigate('homework'),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: isDark
//                 ? [
//                     const Color(0xFF1e1b4b).withOpacity(0.8),
//                     const Color(0xFF1E293B),
//                   ]
//                 : [const Color(0xFFf5f3ff), Colors.white],
//           ),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: const Color(0xFF6366F1).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF6366F1).withOpacity(0.08),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF6366F1).withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: const Text("📚", style: TextStyle(fontSize: 22)),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.isArabic ? "الواجبات المدرسية" : "School Homework",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       color: textColor,
//                       fontSize: 15,
//                     ),
//                   ),
//                   Text(
//                     widget.isArabic
//                         ? "تابع واجبات الميكانيكا والبرمجة"
//                         : "Check your homework",
//                     style: TextStyle(
//                       color: textColor.withOpacity(0.5),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: const Color(0xFF6366F1),
//               size: 16,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//==================================================================================================
//==================================================================================================
//==================================================================================================
//==================================================================================================
//==================================================================================================
//==================================================================================================

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:mica_school_app/features/home/presentation/cubit/teacher_rating_cubit/teacher_rating_cubit.dart';
import 'package:mica_school_app/features/homework/presentation/screens/homework_screen.dart';
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

  @override
  void initState() {
    super.initState();

    context.read<GetSingleUserCubit>().getSingleUser(
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    context.read<TeacherRatingCubit>().getTeacherRatings(
      FirebaseAuth.instance.currentUser!.uid,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
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
            body: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                            ), // هذا سينادي الـ handleNavigation
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
          );
        }

        return const Scaffold(
          body: Center(child: Text("Error loading user data")),
        );
      },
    );
  }
}
