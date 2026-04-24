import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';
import 'package:mica_school_app/features/canteen/domain/repositories/canteen_repo.dart';

class GetMonthDataUsecase {
  final CanteenRepo repository;

  GetMonthDataUsecase(this.repository);

  Future<CanteenMonthEntity?> call(String userId, String monthKey, bool isArabic) async {
    return await repository.getMonthData(userId, monthKey, isArabic);
  }
}