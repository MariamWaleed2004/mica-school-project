import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  final String? nameAr;
  final String? nameEn;
  final String? majorAr;
  final String? majorEn;
  final String? profileImageUrl;

  const ProfileHeaderWidget({
    super.key,
    required this.isDark,
    required this.isArabic,
    this.nameAr,
    this.nameEn,
    this.majorAr,
    this.majorEn,
    this.profileImageUrl,
  });

  String get _fullName {
    if (isArabic) {
      return nameAr ?? "مستخدم";
    } else {
      return nameEn ?? "User";
    }
  }

  String get _major {
    if (isArabic) {
      return majorAr ?? "قسم غير محدد";
    } else {
      return majorEn ?? "Department not specified";
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // Avatar
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: _buildProfileImage(),
                      ),
                    ),
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
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                _fullName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Text(
                  _major,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return Image.network(
        profileImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _defaultAvatar();
        },
      );
    } else {
      return _defaultAvatar();
    }
  }

  Widget _defaultAvatar() {
    return Container(
      color: Colors.white.withOpacity(0.15),
      child: const Center(
        child: Text("👤", style: TextStyle(fontSize: 38)),
      ),
    );
  }
}