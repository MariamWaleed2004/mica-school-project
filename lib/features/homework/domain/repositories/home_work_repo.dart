import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';

abstract class HomeworkRepo {
  Future<List<HomeworkEntity>> getHomeworks(String userId);
  Future<void> toggleHomeworkStatus(String userId, String homeworkId, bool currentStatus);
}