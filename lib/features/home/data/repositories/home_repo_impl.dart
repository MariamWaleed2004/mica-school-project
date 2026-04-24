import 'dart:io';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/teacher_rating_entity.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:mica_school_app/features/home/data/datasources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/home/data/models/schedule_models/subject_model.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';



class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});


  
  @override
  Future<List<SubjectEntity>> getSubjects(String majorId) 
  => homeRemoteDataSource.getSubjects(majorId);


    @override
  Future<List<ExamEntity>> getExams(String majorId) 
  => homeRemoteDataSource.getExams(majorId);


   @override
  Future<FeesSummaryEntity> getFeesSummary(String userId) {
    return homeRemoteDataSource.getFeesSummary(userId);
  }

  @override
  Future<List<FeeItemEntity>> getAllFeesItems(String userId) {
    return homeRemoteDataSource.getAllFeesItems(userId);
  }


   @override
  Future<List<TeacherRatingEntity>> getTeacherRatings(String userId) async {
    return await homeRemoteDataSource.getTeacherRatings(userId);
  }


    
}