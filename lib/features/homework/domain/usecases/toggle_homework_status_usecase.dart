import 'package:mica_school_app/features/homework/domain/repositories/home_work_repo.dart';

class ToggleHomeworkStatusUsecase {
  final HomeworkRepo repo;

  ToggleHomeworkStatusUsecase(this.repo);

  Future<void> call(String userId, String homeworkId, bool currentStatus) async {
    return await repo.toggleHomeworkStatus(userId, homeworkId, currentStatus);
  }
}