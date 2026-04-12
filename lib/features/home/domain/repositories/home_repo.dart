import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/home/data/models/subject_model.dart';
import 'package:mica_school_app/features/home/domain/entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/subject_entity.dart';

abstract class HomeRepo {

  Future<List<SubjectEntity>> getSubjects(String majorId);
  Future<List<ExamEntity>> getExams(String majorId);


}