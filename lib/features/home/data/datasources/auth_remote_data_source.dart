import 'package:mica_school_app/features/home/domain/entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/subject_entity.dart';


abstract class HomeRemoteDataSource {

  Future<List<SubjectEntity>> getSubjects(String majorId);
  Future<List<ExamEntity>> getExams(String majorId);



}