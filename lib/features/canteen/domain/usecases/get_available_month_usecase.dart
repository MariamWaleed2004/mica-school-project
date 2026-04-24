// lib/features/canteen/domain/usecases/get_available_months_usecase.dart

import 'package:mica_school_app/features/canteen/domain/repositories/canteen_repo.dart';

class GetAvailableMonthsUsecase {
  final CanteenRepo repository;

  GetAvailableMonthsUsecase(this.repository);

  Future<List<String>> call(String userId) async {
    return await repository.getAvailableMonths(userId);
  }
}