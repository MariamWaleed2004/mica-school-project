import 'package:firebase_auth/firebase_auth.dart';
import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';

class GetCurrentUidUsecase {
  final AuthRepo repository;

  GetCurrentUidUsecase({required this.repository});

  Future<String> call() {
    final user = FirebaseAuth.instance.currentUser;
    return repository.getCurrentUid();
  }
}