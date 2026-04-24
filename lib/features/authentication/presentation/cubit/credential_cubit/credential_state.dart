import 'package:equatable/equatable.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object?> get props => [];
}

class CredentialInitial extends CredentialState {}




//==================================================================================



class CredentialLoading extends CredentialState {}


//==================================================================================



class CredentialSuccess extends CredentialState {
  final UserEntity user; // ✅ ADD THIS

  const CredentialSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}


//==================================================================================

class CredentialFailure extends CredentialState {
  final String errorMessage;

  const CredentialFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}