import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(isDark),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                child: Column(children: [
                  _buildInfoCard(isDark, textColor),
                  const SizedBox(height: 20),
                  _buildAcademicCard(isDark, textColor),
                  const SizedBox(height: 24),
                  _buildContactCard(isDark, textColor),
                  const SizedBox(height: 30),
                  Opacity(
                    opacity: 0.4,
                    child: Text("MICA PORTAL • 2026",
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3.0,
                            fontSize: 10)),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF1D4ED8), Color(0xFF0284C7)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(children: [
            // Avatar
            Stack(
              children: [
                // Container(
                //   width: 90,
                //   height: 90,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(
                //         color: Colors.white.withOpacity(0.6), width: 2.5),
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.black.withOpacity(0.2),
                //           blurRadius: 16,
                //           offset: const Offset(0, 6)),
                //     ],
                //   ),
                //   child: ClipOval(
                //     child: profileImage != null
                //         ? (kIsWeb
                //             ? Image.network(profileImage!.path,
                //                 fit: BoxFit.cover)
                //             : Image.file(File(profileImage!.path),
                //                 fit: BoxFit.cover))
                //         : Container(
                //             color: Colors.white.withOpacity(0.15),
                //             child: const Center(
                //                 child:
                //                     Text("👤", style: TextStyle(fontSize: 38))),
                //           ),
                //   ),
                // ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text("سلمى أحمد محمد",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: const Text("الأنظمة المدمجة والذكاء الاصطناعي",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildInfoCard(bool isDark, Color textColor) {
    final fields = [
      {
        "label": isArabic ? "الاسم الكامل" : "FULL NAME",
        "value": "Salma Hazem",
        "icon": Icons.person_outline_rounded
      },
      {
        "label": isArabic ? "رقم الطالب" : "STUDENT ID",
        "value": "ID-2024-AI-08",
        "icon": Icons.badge_outlined
      },
    ];
    return _sectionCard(
      isDark,
      textColor,
      isArabic ? "البيانات الشخصية" : "Personal Info",
      Icons.person_rounded,
      const Color(0xFF6366F1),
      fields,
    );
  }

  Widget _buildAcademicCard(bool isDark, Color textColor) {
    final fields = [
      {
        "label": isArabic ? "الفصل" : "CLASS",
        "value": "Year 3 - Lab 8",
        "icon": Icons.school_outlined
      },
      {
        "label": isArabic ? "القسم الأكاديمي" : "DEPT",
        "value": "Artificial Intelligence",
        "icon": Icons.psychology_outlined
      },
    ];
    return _sectionCard(
      isDark,
      textColor,
      isArabic ? "البيانات الأكاديمية" : "Academic Info",
      Icons.school_rounded,
      const Color(0xFF0EA5E9),
      fields,
    );
  }

  Widget _buildContactCard(bool isDark, Color textColor) {
    final fields = [
      {
        "label": isArabic ? "البريد الإلكتروني" : "EMAIL",
        "value": "salma.hazem@university.edu",
        "icon": Icons.email_outlined
      },
    ];
    return _sectionCard(
      isDark,
      textColor,
      isArabic ? "بيانات التواصل" : "Contact",
      Icons.contact_mail_rounded,
      const Color(0xFF10B981),
      fields,
    );
  }

  Widget _sectionCard(bool isDark, Color textColor, String title,
      IconData titleIcon, Color color, List<Map> fields) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(children: [
        // Card header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.06),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border(bottom: BorderSide(color: color.withOpacity(0.1))),
          ),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(titleIcon, color: color, size: 16),
            ),
            const SizedBox(width: 10),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: color, fontSize: 14)),
          ]),
        ),
        // Fields
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: fields
                .map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(children: [
                        Icon(f['icon'] as IconData, color: color, size: 18),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(f['label'] as String,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: textColor.withOpacity(0.45),
                                      letterSpacing: 0.5)),
                              const SizedBox(height: 2),
                              Text(f['value'] as String,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
                                      fontWeight: FontWeight.w600)),
                            ])),
                      ]),
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }
}

// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
