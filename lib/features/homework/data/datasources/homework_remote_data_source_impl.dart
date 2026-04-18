// lib/features/homework/data/datasources/homework_remote_data_source_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/homework/data/datasources/homework_remote_data_source.dart';
import 'package:mica_school_app/features/homework/data/models/homework_model.dart';
import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';

class HomeworkRemoteDataSourceImpl implements HomeworkRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  HomeworkRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<List<HomeworkEntity>> getHomeworks(String userId) async {
    final snapshot = await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('homeworks')
        //.orderBy('dueDate')
        .get();

    print("📚 HOMEWORK COUNT: ${snapshot.docs.length}");

    return snapshot.docs
        .map((doc) => HomeworkModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> toggleHomeworkStatus(String userId, String homeworkId, bool currentStatus) async {
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('homeworks')
        .doc(homeworkId)
        .update({
      'isDone': !currentStatus,
      'updatedAt': Timestamp.now(),
    });
  }
}