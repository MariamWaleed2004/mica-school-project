import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? id;
  final String? password;
  final String? confirmPassword;

  UserEntity({
    this.uid,
    this.name,
    this.id,
    this.password,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        id,
        password,
        confirmPassword,
      ];
}
