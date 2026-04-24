import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';
import 'package:mica_school_app/features/home/domain/usecases/fees_usecases/get_fees_item_usecase.dart';
import 'package:mica_school_app/features/home/domain/usecases/fees_usecases/get_fees_summary_usecase.dart';
import 'package:mica_school_app/features/home/presentation/cubit/fees_cubit/fees_state.dart';

class FeesCubit extends Cubit<FeesState> {
  final GetFeesSummaryUsecase getFeesSummaryUsecase;
  final GetAllFeesItemsUsecase getAllFeesItemsUsecase;

  FeesCubit({
    required this.getFeesSummaryUsecase,
    required this.getAllFeesItemsUsecase,
  }) : super(const FeesInitial());

  Future<void> getFees(String userId) async {
    emit(const FeesLoading());
    try {
      final results = await Future.wait([
        getFeesSummaryUsecase(userId),
        getAllFeesItemsUsecase(userId),
      ]);

      emit(FeesLoaded(
        summary: results[0] as FeesSummaryEntity,
        items: results[1] as List<FeeItemEntity>,
      ));
    } catch (e) {
      emit(FeesFailure(message: e.toString()));
    }
  }
}