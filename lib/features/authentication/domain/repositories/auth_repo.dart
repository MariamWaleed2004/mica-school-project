import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepo {

  Future<UserEntity> signInUser(UserEntity user, BuildContext context);

  // Future<void> signUpUser(UserEntity user, BuildContext context);
  
  Future<bool> isSignIn();

  Future<void> signOut(); 





  //Future<void> createUser(UserEntity user);

  // Future<void> updateUser(UserEntity user);

  Future<String> getCurrentUid();

  // Future<String> uploadImageToStorage(File? file, bool isPost, String childName);

  Stream<List<UserEntity>> getUsers(UserEntity user);

  Future<UserEntity> getSingleUser(String uid);


  // Future<UserCredential?> signUpWithGoogle(BuildContext context);

  // Future<UserCredential?> signInWithGoogle(BuildContext context);
}