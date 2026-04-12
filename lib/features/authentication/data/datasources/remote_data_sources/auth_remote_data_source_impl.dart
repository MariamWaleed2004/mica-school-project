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

    // 🔥 AFTER LOGIN SUCCESS → FETCH USER FROM FIRESTORE
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
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
Future<UserEntity> getSingleUser(String uid) async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();

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

  // @override
  // Future<void> updateUser(UserEntity user) async {
  //   if (user.uid == null || user.uid!.isEmpty) {
  //     throw Exception("User UID is required to update user data");
  //   }

  //   final userCollection = firebaseFirestore.collection(FirebaseConst.users);
  //   Map<String, dynamic> userInformation = {};

  //   if (user.name != '' && user.name != null)
  //     userInformation['name'] = user.name;

  //   try {
  //     await userCollection.doc(user.uid).update(userInformation);
  //     debugPrint("User data updated successfully");
  //   } catch (e) {
  //     debugPrint("Failed to update user: $e");
  //     throw Exception("Failed to update user data");
  //   }
  // }

  // final _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // @override
  // Future<UserCredential?> signUpWithGoogle(BuildContext context) async {
  //   try {
  //     await _googleSignIn.signOut();
  //     await _auth.signOut();

  //     try {
  //       await _googleSignIn.disconnect();
  //     } catch (e) {
  //       print("GoogleSignIn disconnect failed: $e");
  //     }

  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     // User canceled the login
  //     if (googleUser == null) {
  //       return null;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       accessToken: googleAuth.accessToken,
  //     );

  //     bool accountExists = await _checkIfUserExists(googleUser.email);
  //     if (accountExists) {
  //       _showIfAccountExistsDialog(context);
  //       return null;
  //     }

  //     // Sign in the user with Firebase
  //     final UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     final User? user = userCredential.user;

  //     if (user != null) {
  //       await _saveUserToFirestore(user);
  //     }
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (ctx) => MainScreen(uid: user!.uid)));

  //     return userCredential;
  //   } catch (e) {
  //     print("Error signing in with Google: $e");
  //     return null;
  //   }
  // }

  // Future<bool> _checkIfUserExists(String uid) async {

  //   try {
  //   DocumentSnapshot doc =
  //       await _firestore.collection('users').doc(uid).get();

  //   return doc.exists;
  // } catch (e) {
  //   print("Error checking user existence: $e");
  //   return false;
  // }
  // }

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
  }

  // Future<void> _saveUserToFirestore(User user) async {
  //   final userDoc =
  //       firebaseFirestore.collection(FirebaseConst.users).doc(user.uid);

  //   final docSnapshot = await userDoc.get();

  //   // Only add user if they don't already exist
  //   if (!docSnapshot.exists) {
  //     await userDoc.set({
  //       'uid': user.uid,
  //       'name': user.displayName ?? "No Name",
  //       'email': user.email,
  //       'createdAt': FieldValue.serverTimestamp(),
  //     });
  //   }

  //   if (!(user.emailVerified)) {
  //     await user.sendEmailVerification();
  //     print("Verification email sent to ${user.email}");
  //   } else {
  //     print("Account is verified");
  //   }
  // }

//   @override
//   Future<UserCredential?> signInWithGoogle(BuildContext context) async {
//     try {
//       await _googleSignIn.signOut();
//       await _auth.signOut();

//       try {
//         await _googleSignIn.disconnect();
//       } catch (e) {
//         print("GoogleSignIn disconnect failed: $e");
//       }

//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       // User canceled the login
//       if (googleUser == null) {
//         return null;
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );


//       final UserCredential userCredential = await _auth.signInWithCredential(credential);
//       final User? user = userCredential.user;
//     if (user == null) {
//       print("User is null after sign-in");
//       return null;
//     }
//       bool accountExists = await _checkIfUserExists(googleUser.id);
//       if (!accountExists) {

//         _showInvalidEmailOrPasswordDialog(context);
//         return null;
//       }

//       await _saveUserToFirestore(user);

//       return userCredential;
//     } catch (e) {
//       print("Error signing in with Google: $e");
//       return null;
//     }
//   }
// }
}