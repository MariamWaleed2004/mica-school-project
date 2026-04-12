import 'package:flutter/material.dart';
import 'package:mica_school_app/features/home/domain/entities/subject_entity.dart';

class BuildSubjectCardWidget extends StatelessWidget {
  final SubjectEntity subject;
  final Color cardColor;
  final bool isDark;
  final bool isArabic;

  const BuildSubjectCardWidget({
    super.key,
    required this.subject,
    required this.cardColor,
    required this.isDark,
    required this.isArabic,
  });

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '').replaceAll('0x', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final textColor = isDark
        ? const Color(0xFFF1F5F9)
        : const Color(0xFF0F172A);

    final color = subject.color;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Color bar
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(width: 14),

            //-------------------------------------- Emoji circle -----------------------------------
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  subject.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Subject info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            //-------------------------------------- Subject Name -----------------------------------

                  Text(
                    isArabic ? subject.nameAr : subject.nameEn,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: textColor.withOpacity(0.45),
                      ),
                      const SizedBox(width: 4),
            //-------------------------------------- Subject time -----------------------------------

                      Text(
                        subject.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor.withOpacity(0.55),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Icon(
                        Icons.location_on_rounded,
                        size: 13,
                        color: textColor.withOpacity(0.45),
                      ),
                      const SizedBox(width: 4),
            //-------------------------------------- Subject Room -----------------------------------

                      Expanded(
                        child: Text(
                          isArabic
                              ? 'قاعة ${subject.roomNum}'
                              : 'Hall ${subject.roomNum}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor.withOpacity(0.55),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            //-------------------------------------- Subject Lab -----------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                isArabic ? 'معمل ${subject.labNum}' : 'Lab ${subject.labNum}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
