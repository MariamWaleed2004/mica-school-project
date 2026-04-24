import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/home/domain/usecases/get_teacher_rating_usecase.dart';
import 'package:mica_school_app/features/home/presentation/cubit/teacher_rating_cubit/teacher_rating_state.dart';

class TeacherRatingCubit extends Cubit<TeacherRatingState> {
  final GetTeacherRatingsUsecase getTeacherRatingsUsecase;

  TeacherRatingCubit({required this.getTeacherRatingsUsecase})
      : super(TeacherRatingInitial());


Future<void> getTeacherRatings(String userId) async {
  
  emit(TeacherRatingLoading());
  try {
    final ratings = await getTeacherRatingsUsecase(userId);
    
    emit(TeacherRatingLoaded(ratings: ratings));
  } catch (e, stackTrace) {
    emit(TeacherRatingError(message: e.toString()));
  }
}}