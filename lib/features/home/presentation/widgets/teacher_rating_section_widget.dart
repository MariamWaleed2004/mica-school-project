// lib/features/home/presentation/widgets/teacher_ratings_section_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/home/presentation/cubit/teacher_rating_cubit/teacher_rating_cubit.dart';
import 'package:mica_school_app/features/home/presentation/cubit/teacher_rating_cubit/teacher_rating_state.dart';

class TeacherRatingsSectionWidget extends StatelessWidget {
  final bool isArabic;
  final bool isDark;
  final Color cardColor;
  final Color textColor;

  const TeacherRatingsSectionWidget({
    super.key,
    required this.isArabic,
    required this.isDark,
    required this.cardColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherRatingCubit, TeacherRatingState>(
      builder: (context, state) {
        if (state is TeacherRatingLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is TeacherRatingError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    isArabic ? "خطأ في تحميل التقييمات" : "Error loading ratings",
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is TeacherRatingLoaded) {
          final ratings = state.ratings;

          if (ratings.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  isArabic ? "لا توجد تقييمات حالياً" : "No ratings available",
                  style: TextStyle(color: textColor.withOpacity(0.6)),
                ),
              ),
            );
          }

          return Column(
            children: List.generate(ratings.length, (index) {
              final teacher = ratings[index];
              final color = teacher.color;
              final rating = teacher.rating;
              final comment = isArabic ? teacher.commentAr : teacher.commentEn;
              final name = isArabic ? teacher.nameAr : teacher.nameEn;
              final subject = isArabic ? teacher.subjectAr : teacher.subjectEn;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.25), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              teacher.icon,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                subject,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < rating
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.format_quote_rounded, color: color, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              comment,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: textColor.withOpacity(0.75),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        }

        return const SizedBox();
      },
    );
  }
}