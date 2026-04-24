// lib/features/canteen/data/repositories/canteen_repo_impl.dart

import 'package:mica_school_app/features/canteen/data/datasources/canteen_remote_data_source.dart';
import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';
import 'package:mica_school_app/features/canteen/domain/repositories/canteen_repo.dart';

class CanteenRepoImpl implements CanteenRepo {
  final CanteenRemoteDataSource canteenRemoteDataSource;

  CanteenRepoImpl({required this.canteenRemoteDataSource});

  @override
  Future<CanteenMonthEntity?> getMonthData(String userId, String monthKey, bool isArabic) {
    return canteenRemoteDataSource.getMonthData(userId, monthKey, isArabic);
  }

  @override
  Future<List<String>> getAvailableMonths(String userId) {
    return canteenRemoteDataSource.getAvailableMonths(userId);
  }
}