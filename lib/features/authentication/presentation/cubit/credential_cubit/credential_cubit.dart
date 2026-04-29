import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/sign_in_user_usecase.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/credential_cubit/credential_state.dart';


class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUsecase signInUserUsecase;
  CredentialCubit({
    required this.signInUserUsecase,
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

    print("✅ Logged in user UID: ${user.uid}");
    
    emit(CredentialSuccess(user: user));
  } on SocketException {
    emit(CredentialFailure(errorMessage: "No internet connection"));
  } on TimeoutException catch (e) {
    emit(CredentialFailure(errorMessage: e.message ?? "Timeout"));
  } catch (e) {
    emit(CredentialFailure(errorMessage: e.toString()));
  }
}


}
