import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';
import 'package:mica_school_app/features/homework/domain/repositories/home_work_repo.dart';

class GetHomeworkUsecase {
  final HomeworkRepo repository;

  GetHomeworkUsecase({required this.repository});

  Future<List<HomeworkEntity>> call(String userId) {
    return repository.getHomeworks(userId);
  }
}

