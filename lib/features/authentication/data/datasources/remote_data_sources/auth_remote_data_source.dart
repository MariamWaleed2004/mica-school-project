import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';


abstract class AuthRemoteDataSource {

  Future<UserEntity> signInUser(UserEntity user, BuildContext context);
  
  Future<bool> isSignIn();

  Future<void> signOut(); 

  Future<String> getCurrentUid();

  Stream<List<UserEntity>> getUsers(UserEntity user);

  Future<UserEntity> getSingleUser(String uid);






}