import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUsecase getSingleUserUsecase;

  GetSingleUserCubit({
    required this.getSingleUserUsecase,
  }) : super(GetSingleUserInitial());



  

  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());

    try {
      final user = await getSingleUserUsecase(uid);

      emit(GetSingleUserLoaded(user: user));
    } on SocketException {
      emit(GetSingleUserFailure(
        errorMessage: e.toString()
      ));
    } catch (_) {
      emit(GetSingleUserFailure(errorMessage: e.toString()));
    }
  }
}