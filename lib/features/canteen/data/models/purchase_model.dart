// lib/features/canteen/data/models/purchase_model.dart

import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';

class PurchaseModel extends PurchaseEntity {
  const PurchaseModel({
    required super.id,
    required super.name,
    required super.price,
    required super.time,
  });

  // 🔥 دالة لتحويل أي نوع إلى double
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map, String id) {
    return PurchaseModel(
      id: id,
      name: map['name'] ?? '',
      price: _toDouble(map['price']),
      time: map['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'time': time,
    };
  }
}