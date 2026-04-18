import 'package:mica_school_app/features/homework/data/datasources/homework_remote_data_source.dart';
import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';
import 'package:mica_school_app/features/homework/domain/repositories/home_work_repo.dart';

class HomeworkRepoImpl implements HomeworkRepo {
  final HomeworkRemoteDataSource homeworkremoteDataSource;

  HomeworkRepoImpl({required this.homeworkremoteDataSource});

  @override
  Future<List<HomeworkEntity>> getHomeworks(String userId) {
    return homeworkremoteDataSource.getHomeworks(userId);
  }

  @override
  Future<void> toggleHomeworkStatus(String userId, String homeworkId, bool currentStatus) {
    return homeworkremoteDataSource.toggleHomeworkStatus(userId, homeworkId, currentStatus);
  }
}