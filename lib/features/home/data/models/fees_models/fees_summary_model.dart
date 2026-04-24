import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';

class FeesSummaryModel extends FeesSummaryEntity {
  const FeesSummaryModel({
    required super.totalAmount,
    required super.paidAmount,
    required super.remainingAmount,
  });

  factory FeesSummaryModel.fromMap(Map<String, dynamic> map) {
    return FeesSummaryModel(
      totalAmount: _toDouble(map['totalAmount'] ?? 0),
      paidAmount: _toDouble(map['paidAmount'] ?? 0),
      remainingAmount: _toDouble(map['remainingAmount'] ?? 0),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toMap() {
    return {
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'remainingAmount': remainingAmount,
    };
  }
}