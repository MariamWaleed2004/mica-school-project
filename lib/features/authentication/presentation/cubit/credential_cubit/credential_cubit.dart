import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/sign_in_user_usecase.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/credential_cubit/credential_state.dart';


class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUsecase signInUserUsecase;
  // final SignUpUserUsecase signUpUserUsecase;
  // final SignInWithGoogleUsecase signInWithGoogleUsecase;
  // final SignUpWithGoogleUsecase signUpWithGoogleUsecase;
  CredentialCubit({
    required this.signInUserUsecase,
    // required this.signUpUserUsecase,
    // required this.signInWithGoogleUsecase,
    // required this.signUpWithGoogleUsecase,
  }) : super(CredentialInitial());

Future<void> signInUser({
  required String id,
  required String password,
  required BuildContext context,
}) async {
  emit(CredentialLoading());

  try {
    final user = await signInUserUsecase.call(
      UserEntity(id: id, password: password),
      context,
    );

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print("✅ Logged in: ${currentUser.uid}");
    }

    emit(CredentialSuccess(user: user));

  } on SocketException {
    emit(CredentialFailure(errorMessage: "No internet connection"));
  } on TimeoutException catch (e) {
    emit(CredentialFailure(errorMessage: e.message ?? "Timeout"));
  } catch (e) {
    emit(CredentialFailure(errorMessage: e.toString()));
  }
}

  // Future<void> signUpUser(
  //     {required UserEntity user, required BuildContext context}) async {
  //   emit(CredentialLoading());
  //   try {
  //     await signUpUserUsecase.call(user, context).timeout(
  //       const Duration(seconds: 10),
  //       onTimeout: () {
  //         throw Exception("signUp process timed out");
  //       },
  //     );
  //     emit(CredentialSuccess());
  //   } on SocketException catch (_) {
  //     emit(CredentialFailure(errorMessage: "No internet connection"));
  //   } on TimeoutException catch (e) {
  //     emit(CredentialFailure(errorMessage: e.message ?? "Request timed out."));
  //   } catch (e) {
  //     emit(CredentialFailure(errorMessage: "Signup failed: ${e.toString()}"));
  //   }
  // }

  // Future<void> signUpWithGoogle(BuildContext context) async {
  //   emit(CredentialLoading());
  //   try {
  //     await signUpWithGoogleUsecase.call(context);

  //     emit(CredentialSuccess());
  //   } on SocketException catch (_) {
  //     emit(CredentialFailure(errorMessage: "No internet connection"));
  //   } catch (e) {
  //     emit(CredentialFailure(errorMessage: "Signup failed: ${e.toString()}"));
  //   }
  // }

  // Future<void> signInWithGoogle(BuildContext context) async {
  //   emit(CredentialLoading());
  //   try {
  //     await signInWithGoogleUsecase.call(context);

  //     emit(CredentialSuccess());
  //   } on SocketException catch (_) {
  //     emit(CredentialFailure(errorMessage: "No internet connection"));
  //   } catch (e) {
  //     emit(CredentialFailure(errorMessage: "Signup failed: ${e.toString()}"));
  //   }
  // }
}
