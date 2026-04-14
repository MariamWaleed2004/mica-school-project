import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:mica_school_app/core/const.dart';
import 'package:mica_school_app/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/authentication/data/models/user_model.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  AuthRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });


  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

@override
Future<UserEntity> signInUser(UserEntity user, BuildContext context) async {
  try {
    final email = "${user.id}@mica.com";

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: user.password!,
    );


    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .get();

    if (!doc.exists) {
      throw Exception("User data not found");
    }

    return UserModel.fromSnapshot(doc);

  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      _showInvalidEmailOrPasswordDialog(context);
    } else {
      toast(e.message ?? 'Something went wrong');
    }

    throw Exception("Login failed");
  }
}

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

@override
Future<UserEntity> getSingleUser(String hardwareUid) async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(hardwareUid)
      .get();
      
  print("DOC ID: $hardwareUid");
  print("EXISTS: ${doc.exists}");
  print("DATA: ${doc.data()}");

  if (!doc.exists) {
    throw Exception("User not found");
  }

  final model = UserModel.fromSnapshot(doc);

  return model; // because UserModel extends UserEntity
}


  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  

  void _showIfAccountExistsDialog(BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                  "Account already exist, Please log in instead.",
                  style: TextStyle(color: Colors.white),
                ))
              ],
            ),
          ),
        ));
  }

  void _showInvalidEmailOrPasswordDialog(BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                  "Invalid email or password",
                  style: TextStyle(color: Colors.white),
                ))
              ],
            ),
          ),
        ));
  }}
  
