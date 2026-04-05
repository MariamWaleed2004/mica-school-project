import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';

class IsSignInUsecase {
  final AuthRepo repository;

  IsSignInUsecase({required this.repository});

  Future<bool> call() {
    return repository.isSignIn();
  }
}