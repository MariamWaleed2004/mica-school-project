import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/home/data/models/schedule_models/subject_model.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/teacher_rating_entity.dart';

abstract class HomeRepo {

  Future<List<SubjectEntity>> getSubjects(String majorId);
  Future<List<ExamEntity>> getExams(String majorId);

  Future<FeesSummaryEntity> getFeesSummary(String userId);
  Future<List<FeeItemEntity>> getAllFeesItems(String userId);

    Future<List<TeacherRatingEntity>> getTeacherRatings(String userId);



}