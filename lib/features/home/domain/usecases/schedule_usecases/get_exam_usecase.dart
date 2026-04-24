
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';

class GetExamUsecase {
  final HomeRepo repository;

  GetExamUsecase({required this.repository});

  Future<List<ExamEntity>> call(String majorId) {
    return repository.getExams(majorId);
  }
}