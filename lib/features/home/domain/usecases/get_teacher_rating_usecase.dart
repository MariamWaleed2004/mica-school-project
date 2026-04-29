import 'package:mica_school_app/features/home/domain/entities/teacher_rating_entity.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';

class GetTeacherRatingsUsecase {
  final HomeRepo repository;

  GetTeacherRatingsUsecase(this.repository);

  Future<List<TeacherRatingEntity>> call(String userId) async {
    return await repository.getTeacherRatings(userId);
  }
}