import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/authentication/data/models/user_model.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';

class GetSingleUserUsecase {
  final AuthRepo repository;

  GetSingleUserUsecase({required this.repository});

  Future<UserEntity> call(String uid) {
    return repository.getSingleUser(uid);
  }
}
