import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/teacher_rating_entity.dart';


abstract class HomeRemoteDataSource {

  Future<List<SubjectEntity>> getSubjects(String majorId);
  Future<List<ExamEntity>> getExams(String majorId);


  Future<FeesSummaryEntity> getFeesSummary(String userId);
  Future<List<FeeItemEntity>> getAllFeesItems(String userId);

  Future<List<TeacherRatingEntity>> getTeacherRatings(String userId);




}