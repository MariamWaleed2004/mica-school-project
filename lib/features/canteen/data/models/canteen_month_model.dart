// lib/features/canteen/data/models/canteen_month_model.dart

import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';

class CanteenMonthModel extends CanteenMonthEntity {
  const CanteenMonthModel({
    required super.monthKey,
    required super.balance,
    required super.savings,
    required super.startBalance,
    required super.ratios,
    required super.dailyPurchases,
  });

  // 🔥 دالة لتحويل أي نوع إلى double
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  // 🔥 دالة لتحويل أي نوع إلى List<double>
  static List<double> _toRatiosList(dynamic value) {
    if (value == null) return [0.4, 0.25, 0.2, 0.15];
    if (value is List) {
      return value.map((e) => _toDouble(e)).toList();
    }
    return [0.4, 0.25, 0.2, 0.15];
  }

  factory CanteenMonthModel.fromMap(Map<String, dynamic> map, String monthKey) {
    return CanteenMonthModel(
      monthKey: monthKey,
      balance: _toDouble(map['balance']),
      savings: _toDouble(map['savings']),
      startBalance: _toDouble(map['startBalance']),
      ratios: _toRatiosList(map['ratios']),
      dailyPurchases: {}, // هتتملأ بعدين
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'savings': savings,
      'startBalance': startBalance,
      'ratios': ratios,
    };
  }
}