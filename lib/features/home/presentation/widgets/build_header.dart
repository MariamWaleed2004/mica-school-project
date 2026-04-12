import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BuildHeaderWidget extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  final String? profileImageUrl;
  final bool isActive;
  final String nameAr;
  final String nameEn;
  final XFile? profileImage;

  const BuildHeaderWidget({
    super.key,
    required this.isDark,
    required this.isArabic,
    required this.profileImageUrl,
    this.isActive = true,
    required this.nameAr,
    required this.nameEn,
    this.profileImage,
  });

  Widget _defaultAvatar() {
    return Container(
      color: Colors.white.withOpacity(0.15),
      child: const Center(child: Text("👤", style: TextStyle(fontSize: 28))),
    );
  }
  Widget buildProfileImage() {
  if (profileImageUrl == null || profileImageUrl!.isEmpty) {
    return _defaultAvatar();
  }

  return Image.network(
    profileImageUrl!,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return _defaultAvatar();
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Container(
      width: double.infinity,
      height: 220,
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
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
// ----------------------------------------- User's Profile Image ----------------------------------------------
                  //  Container(
                  //       width: 56,
                  //       height: 56,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //             color: Colors.white.withOpacity(0.5), width: 2),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.black.withOpacity(0.15),
                  //               blurRadius: 12)
                  //         ],
                  //       ),
                  //       child: ClipOval(
                  //         child: profileImage != null
                  //             ? (kIsWeb
                  //                 ? Image.network(profileImage!.path,
                  //                     fit: BoxFit.cover)
                  //                 : Image.file(File(profileImage!.path),
                  //                     fit: BoxFit.cover))
                  //             : Container(
                  //                 color: Colors.white.withOpacity(0.15),
                  //                 child: const Center(
                  //                     child: Text("👤",
                  //                         style: TextStyle(fontSize: 28))),
                  //               ),
                  //       ),
                  //     ),
                  
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: buildProfileImage(),
                        ),
                      ),
// ----------------------------------------- User's Active Status --------------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              isArabic ? "نشط" : "Active",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
// ----------------------------------------- User's Name ----------------------------------------------
                  Text(
                    isArabic ? "صباح الخير ✨" : "Good Morning ✨",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isArabic ? "مرحباً، $nameAr" : "Welcome, $nameEn",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
