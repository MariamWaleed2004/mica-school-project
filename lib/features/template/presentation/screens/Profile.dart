import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:mica_school_app/features/template/presentation/widgets/profile_header_widget.dart';

class ProfileScreen extends StatelessWidget {
  final bool isArabic;
  final Map texts;
  final XFile? profileImage;

  const ProfileScreen({
    super.key,
    required this.isArabic,
    required this.texts,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, state) {
        if (state is GetSingleUserLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetSingleUserLoaded) {
          final user = state.user;

          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              backgroundColor: isDark
                  ? const Color(0xFF0F172A)
                  : const Color(0xFFF0F4FF),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ProfileHeaderWidget(
                      isDark: isDark,
                      isArabic: isArabic,
                      nameAr: user.nameAr,
                      nameEn: user.nameEn,
                      majorAr: user.majorAr,
                      majorEn: user.majorEn,
                      profileImageUrl: user.profileImageUrl,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                      child: Column(
                        children: [
                          _buildInfoCard(isDark, textColor, isArabic, user),
                          const SizedBox(height: 20),
                          _buildAcademicCard(isDark, textColor, isArabic, user),
                          const SizedBox(height: 24),
                          _buildContactCard(isDark, textColor, isArabic, user),
                          const SizedBox(height: 30),
                          Opacity(
                            opacity: 0.4,
                            child: Text(
                              "MICA PORTAL • 2026",
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 3.0,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is GetSingleUserFailure) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    isArabic ? "خطأ في تحميل البيانات" : "Error loading data",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(state.errorMessage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GetSingleUserCubit>().getSingleUser(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                      );
                    },
                    child: Text(isArabic ? "إعادة المحاولة" : "Retry"),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(body: Center(child: Text("No data")));
      },
    );
  }
// ----------------------------------------------------- Info Cards ------------------------------------------------------------
  Widget _buildInfoCard(bool isDark, Color textColor, bool isArabic, user) {
    final fields = [
      {
        "label": isArabic ? "الاسم الكامل" : "FULL NAME",
        "value": isArabic
            ? (user.nameAr ?? "غير متوفر")
            : (user.nameEn ?? "Not available"),
        "icon": Icons.person_outline_rounded,
      },
      {
        "label": isArabic ? "رقم الطالب" : "STUDENT ID",
        "value": user.id ?? (isArabic ? "غير متوفر" : "Not available"),
        "icon": Icons.badge_outlined,
      },
    ];
    return _sectionCard(
      isDark,
      textColor,
      isArabic ? "البيانات الشخصية" : "Personal Info",
      Icons.person_rounded,
      const Color(0xFF6366F1),
      fields,
      isArabic,
    );
  }

  Widget _buildAcademicCard(bool isDark, Color textColor, bool isArabic, user) {
    final fields = [
      {
        "label": isArabic ? "الفصل" : "CLASS",
        "value": isArabic
            ? 'Year ${user.gradeNum ?? "Not available"} - Lab ${user.lab ?? "Not available"}'
            : 'not found',
        "icon": Icons.school_outlined,
      },
      {
        "label": isArabic ? "القسم الأكاديمي" : "DEPARTMENT",
        "value": user.department,
        "icon": Icons.psychology_outlined,
      },
    ];
    return _sectionCard(
      isDark,
      textColor,
      isArabic ? "البيانات الأكاديمية" : "Academic Info",
      Icons.school_rounded,
      const Color(0xFF0EA5E9),
      fields,
      isArabic,
    );
  }

  Widget _buildContactCard(bool isDark, Color textColor, bool isArabic, user) {
    final fields = [
      {
        "label": isArabic ? "البريد الإلكتروني" : "EMAIL",
        "value":
            FirebaseAuth.instance.currentUser?.email ??
            (isArabic ? "غير متوفر" : "Not available"),
        "icon": Icons.email_outlined,
      },
    ];
    return _sectionCard(
      isDark,
      textColor,
      isArabic ? "بيانات التواصل" : "Contact",
      Icons.contact_mail_rounded,
      const Color(0xFF10B981),
      fields,
      isArabic,
    );
  }

  Widget _sectionCard(
    bool isDark,
    Color textColor,
    String title,
    IconData titleIcon,
    Color color,
    List<Map> fields,
    bool isArabic,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(bottom: BorderSide(color: color.withOpacity(0.1))),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(titleIcon, color: color, size: 16),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Fields
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: fields
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(f['icon'] as IconData, color: color, size: 18),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  f['label'] as String,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: textColor.withOpacity(0.45),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  f['value'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
