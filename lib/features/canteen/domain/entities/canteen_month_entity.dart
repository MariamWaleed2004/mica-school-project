// lib/features/canteen/domain/entities/canteen_month_entity.dart

import 'package:equatable/equatable.dart';

class PurchaseEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String time;

  const PurchaseEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.time,
  });

  @override
  List<Object?> get props => [id, name, price, time];
}

class CanteenMonthEntity extends Equatable {
  final String monthKey;
  final double balance;
  final double savings;
  final double startBalance;
  final List<double> ratios;
  final Map<String, List<PurchaseEntity>> dailyPurchases;

  const CanteenMonthEntity({
    required this.monthKey,
    required this.balance,
    required this.savings,
    required this.startBalance,
    required this.ratios,
    required this.dailyPurchases,
  });

  // 🔥 دالة مساعدة لتحديث البيانات
  CanteenMonthEntity copyWith({
    String? monthKey,
    double? balance,
    double? savings,
    double? startBalance,
    List<double>? ratios,
    Map<String, List<PurchaseEntity>>? dailyPurchases,
  }) {
    return CanteenMonthEntity(
      monthKey: monthKey ?? this.monthKey,
      balance: balance ?? this.balance,
      savings: savings ?? this.savings,
      startBalance: startBalance ?? this.startBalance,
      ratios: ratios ?? this.ratios,
      dailyPurchases: dailyPurchases ?? this.dailyPurchases,
    );
  }

  @override
  List<Object?> get props => [
    monthKey, balance, savings, startBalance, ratios, dailyPurchases
  ];
}