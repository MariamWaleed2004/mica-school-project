import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';

abstract class CanteenRepo {
  Future<CanteenMonthEntity?> getMonthData(String userId, String monthKey, bool isArabic);
  Future<List<String>> getAvailableMonths(String userId);
}