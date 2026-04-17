import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';



class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<bool> isSignIn() async 
  => authRemoteDataSource.isSignIn();

  @override
  Future<UserEntity> signInUser(UserEntity user, BuildContext context) async
  => authRemoteDataSource.signInUser(user, context);

  @override
  Future<void> signOut() async
  => authRemoteDataSource.signOut();


  @override
  Future<String> getCurrentUid() async
  => authRemoteDataSource.getCurrentUid();

  @override
  Future<UserEntity> getSingleUser(String uid) 
  => authRemoteDataSource.getSingleUser(uid);
  
  
  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) 
  => authRemoteDataSource.getUsers(user);



  

}