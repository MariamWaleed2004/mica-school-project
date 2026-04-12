import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:mica_school_app/core/const.dart';
import 'package:mica_school_app/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/authentication/data/models/user_model.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/home/data/datasources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/home/data/models/exam_model.dart';
import 'package:mica_school_app/features/home/data/models/subject_model.dart';
import 'package:mica_school_app/features/home/domain/entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/subject_entity.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


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


}





// Future<List<SubjectEntity>> getSubjects(String majorId) async {
//   final scheduleSnapshot = await FirebaseFirestore.instance
//       .collection('schedules')
//       .where('name', isEqualTo: majorId)
//       .get();

//   if (scheduleSnapshot.docs.isEmpty) return [];

//   final docId = scheduleSnapshot.docs.first.id;

//   final subjectsSnapshot = await FirebaseFirestore.instance
//       .collection('schedules')
//       .doc(docId)
//       .collection('subjects')
//       .get();

//   print("SUBJECTS: ${subjectsSnapshot.docs.length}");

//   return subjectsSnapshot.docs
//       .map((doc) => SubjectModel.fromMap(doc.data(), doc.id))
//       .toList();
// }

