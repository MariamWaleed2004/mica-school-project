import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/canteen/domain/usecases/get_available_month_usecase.dart';
import 'package:mica_school_app/features/canteen/domain/usecases/get_month_data_usecase.dart';
import 'package:mica_school_app/features/canteen/presentation/cubit/canteen_state.dart';

class CanteenCubit extends Cubit<CanteenState> {
  final GetAvailableMonthsUsecase getAvailableMonthsUsecase;
  final GetMonthDataUsecase getMonthDataUsecase;

  CanteenCubit({
    required this.getAvailableMonthsUsecase,
    required this.getMonthDataUsecase,
  }) : super(const CanteenInitial());

  Future<void> loadMonths(String userId) async {
    emit(const CanteenLoading());
    try {
      final months = await getAvailableMonthsUsecase(userId);
      print("📚 Cubit - Available months: $months");
      
      if (months.isNotEmpty) {
        await loadMonthData(userId, months.first, true);
      } else {
        emit(const CanteenError("No data available"));
      }
    } catch (e) {
      print("❌ Cubit - Load months error: $e");
      emit(CanteenError(e.toString()));
    }
  }

  Future<void> loadMonthData(String userId, String monthKey, bool isArabic) async {
    emit(const CanteenLoading());
    try {
      print("🎯 Cubit - Loading month: $monthKey, isArabic: $isArabic");
      
      final data = await getMonthDataUsecase(userId, monthKey, isArabic);
      final months = await getAvailableMonthsUsecase(userId);
      
      print("✅ Cubit - Data loaded: ${data != null}");
      
      if (data != null) {
        emit(CanteenLoaded(
          data: data,
          availableMonths: months,
          selectedMonth: monthKey,
        ));
      } else {
        emit(CanteenError("No data for $monthKey"));
      }
    } catch (e) {
      print("❌ Cubit - Load month error: $e");
      emit(CanteenError(e.toString()));
    }
  }
}