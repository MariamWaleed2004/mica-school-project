import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/home/data/datasources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/home/data/models/fees_models/fees_item_model.dart';
import 'package:mica_school_app/features/home/data/models/fees_models/fees_summary_model.dart';
import 'package:mica_school_app/features/home/data/models/schedule_models/exam_model.dart';
import 'package:mica_school_app/features/home/data/models/schedule_models/subject_model.dart';
import 'package:mica_school_app/features/home/data/models/teacher_rating_model.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/teacher_rating_entity.dart';


class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  HomeRemoteDataSourceImpl({
    required this.firebaseFirestore,

  });


@override
Future<List<SubjectEntity>> getSubjects(majorId) async {
  final snapshot = await firebaseFirestore
      .collection('schedules')
      .doc(majorId)
      .collection('subjects')
      .get();
        print("DOC COUNT: ${snapshot.docs.length}");

  return snapshot.docs
      .map((doc) => SubjectModel.fromMap(doc.data(), doc.id))
      .toList();
}

@override
Future<List<ExamEntity>> getExams(String majorId) async {
  final snapshot = await firebaseFirestore
      .collection('schedules')
      .doc(majorId)
      .collection('exams')
      .get();
        print("DOC COUNT: ${snapshot.docs.length}");

  return snapshot.docs
      .map((doc) => ExamModel.fromMap(doc.data(), doc.id))
      .toList();
}

  @override
Future<FeesSummaryEntity> getFeesSummary(String userId) async {
  final doc = await firebaseFirestore
      .collection('users')
      .doc(userId)
      .collection('fees')
      .doc('summary')
      .get();

  if (!doc.exists) {
    return const FeesSummaryModel(
      totalAmount: 39300,  
      paidAmount: 29300,    
      remainingAmount: 10000,
    );
  }

  return FeesSummaryModel.fromMap(doc.data()!);
}
  @override
  Future<List<FeeItemEntity>> getAllFeesItems(String userId) async {
    final snapshot = await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('fees')
        .get();

    final items = <FeeItemEntity>[];
    
    for (var doc in snapshot.docs) {
      if (doc.id == 'summary') continue; 
      
      items.add(FeeItemModel.fromMap(doc.data(), doc.id));
    }
    
    return items;
  }


@override
Future<List<TeacherRatingEntity>> getTeacherRatings(String userId) async {
  final snapshot = await firebaseFirestore
      .collection('users')
      .doc(userId)
      .collection('teacher_rating')
      .get();
  
  return snapshot.docs
      .map((doc) => TeacherRatingModel.fromMap(doc.data(), doc.id))
      .toList();
}
}






