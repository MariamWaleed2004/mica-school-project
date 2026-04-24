import 'package:mica_school_app/features/home/domain/entities/teacher_rating_entity.dart';

// States
sealed class TeacherRatingState {}
class TeacherRatingInitial extends TeacherRatingState {}
class TeacherRatingLoading extends TeacherRatingState {}
class TeacherRatingLoaded extends TeacherRatingState {
  final List<TeacherRatingEntity> ratings;
  TeacherRatingLoaded({required this.ratings});
}
class TeacherRatingError extends TeacherRatingState {
  final String message;
  TeacherRatingError({required this.message});
}