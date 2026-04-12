import 'dart:io';
import 'package:mica_school_app/features/home/domain/entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:mica_school_app/features/home/data/datasources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/home/data/models/subject_model.dart';
import 'package:mica_school_app/features/home/domain/entities/subject_entity.dart';



class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});


  
  @override
  Future<List<SubjectEntity>> getSubjects(String majorId) 
  => homeRemoteDataSource.getSubjects(majorId);


    @override
  Future<List<ExamEntity>> getExams(String majorId) 
  => homeRemoteDataSource.getExams(majorId);



    
}