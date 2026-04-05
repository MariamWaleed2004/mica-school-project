import 'package:flutter/material.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';

class SignInUserUsecase {
  final AuthRepo repository;

  SignInUserUsecase({required this.repository});

  Future<void> call(UserEntity user, BuildContext context) {
    return repository.signInUser(user, context);
  }
}