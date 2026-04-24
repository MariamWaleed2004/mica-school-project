// lib/features/canteen/data/datasources/canteen_remote_data_source.dart

import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';

abstract class CanteenRemoteDataSource {
  Future<CanteenMonthEntity?> getMonthData(String userId, String monthKey, bool isArabic);
  Future<List<String>> getAvailableMonths(String userId);
}