import 'package:flutter/material.dart';

class BuildScheduleButton extends StatelessWidget {
    final Function(String) onNavigate;
    final bool isDark;
    final bool isArabic;

    
  const BuildScheduleButton({
    super.key, 
    required this.isDark, 
    required this.onNavigate, 
    required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);
    const accentColor = Color(0xFF4F46E5);
    return GestureDetector(
      onTap: () => onNavigate("schedule"),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1e1b4b).withOpacity(0.8),
                    const Color(0xFF1E293B),
                  ]
                : [const Color(0xFFEEF2FF), Colors.white],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                color: accentColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? "الجدول الدراسي" : "School Schedule",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    isArabic
                        ? "عرض الحصص والمواعيد اليومية"
                        : "View daily classes & timing",
                    style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: accentColor, size: 16),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class BuildHeaderWidget extends StatelessWidget {
//   final bool isDark;
//   final bool isArabic;
//   final String? profileImageUrl;
//   final bool isActive;
//   final String nameAr;
//   final String nameEn;
//   final XFile? profileImage;

//   const BuildHeaderWidget({
//     super.key,
//     required this.isDark,
//     required this.isArabic,
//     required this.profileImageUrl,
//     this.isActive = true,
//     required this.nameAr,
//     required this.nameEn,
//     this.profileImage,
//   });

//   Widget _defaultAvatar() {
//     return Container(
//       color: Colors.white.withOpacity(0.15),
//       child: const Center(child: Text("👤", style: TextStyle(fontSize: 28))),
//     );
//   }
//   Widget buildProfileImage() {
//   if (profileImageUrl == null || profileImageUrl!.isEmpty) {
//     return _defaultAvatar();
//   }

//   return Image.network(
//     profileImageUrl!,
//     fit: BoxFit.cover,
//     errorBuilder: (context, error, stackTrace) {
//       return _defaultAvatar();
//     },
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     final userId = FirebaseAuth.instance.currentUser!.uid;
//     return Container(
//       width: double.infinity,
//       height: 220,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF1A237E), Color(0xFF1D4ED8), Color(0xFF0284C7)],
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(32),
//           bottomRight: Radius.circular(32),
//         ),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: -30,
//             right: -30,
//             child: Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.06),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -20,
//             left: -20,
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.04),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
// // ----------------------------------------- User's Profile Image ----------------------------------------------
//                   //  Container(
//                   //       width: 56,
//                   //       height: 56,
//                   //       decoration: BoxDecoration(
//                   //         shape: BoxShape.circle,
//                   //         border: Border.all(
//                   //             color: Colors.white.withOpacity(0.5), width: 2),
//                   //         boxShadow: [
//                   //           BoxShadow(
//                   //               color: Colors.black.withOpacity(0.15),
//                   //               blurRadius: 12)
//                   //         ],
//                   //       ),
//                   //       child: ClipOval(
//                   //         child: profileImage != null
//                   //             ? (kIsWeb
//                   //                 ? Image.network(profileImage!.path,
//                   //                     fit: BoxFit.cover)
//                   //                 : Image.file(File(profileImage!.path),
//                   //                     fit: BoxFit.cover))
//                   //             : Container(
//                   //                 color: Colors.white.withOpacity(0.15),
//                   //                 child: const Center(
//                   //                     child: Text("👤",
//                   //                         style: TextStyle(fontSize: 28))),
//                   //               ),
//                   //       ),
//                   //     ),
                  
//                       // Container(
//                       //   width: 56,
//                       //   height: 56,
//                       //   decoration: BoxDecoration(
//                       //     shape: BoxShape.circle,
//                       //     border: Border.all(
//                       //       color: Colors.white.withOpacity(0.5),
//                       //       width: 2,
//                       //     ),
//                       //     boxShadow: [
//                       //       BoxShadow(
//                       //         color: Colors.black.withOpacity(0.15),
//                       //         blurRadius: 12,
//                       //       ),
//                       //     ],
//                       //   ),
//                       //   child: ClipOval(
//                       //     child: buildProfileImage(),
//                       //   ),
//                       // ),
// // ----------------------------------------- User's Active Status --------------------------------------------
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 8,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.15),
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.2),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 8,
//                               height: 8,
//                               decoration: const BoxDecoration(
//                                 color: Color(0xFF10B981),
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 7),
//                             Text(
//                               isArabic ? "نشط" : "Active",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
// // ----------------------------------------- User's Name ----------------------------------------------
//                   Text(
//                     isArabic ? "صباح الخير ✨" : "Good Morning ✨",
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.7),
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     isArabic ? "مرحباً، $nameAr" : "Welcome, $nameEn",
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 26,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: 0.3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
