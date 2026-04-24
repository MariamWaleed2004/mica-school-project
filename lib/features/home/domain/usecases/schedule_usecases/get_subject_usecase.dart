
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';

class GetSubjectUsecase {
  final HomeRepo repository;

  GetSubjectUsecase({required this.repository});

  Future<List<SubjectEntity>> call(String majorId) {
    return repository.getSubjects(majorId);
  }
}