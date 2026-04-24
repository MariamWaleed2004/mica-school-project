import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
class FeeItemModel extends FeeItemEntity {
  const FeeItemModel({
    required super.id,
    required super.titleAr,
    required super.titleEn,
    required super.amount,
    required super.statusAr,
    required super.statusEn,
    required super.colorHex,
    required super.iconName,
    required super.category,
  });

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  factory FeeItemModel.fromMap(Map<String, dynamic> map, String docId) {
    return FeeItemModel(
      id: docId,
      titleAr: map['titleAr'] ?? '',
      titleEn: map['titleEn'] ?? '',
      amount: _toDouble(map['amount']),
      statusAr: map['statusAr'] ?? 'متبقي',      
      statusEn: map['statusEn'] ?? 'Pending',   
      colorHex: map['color'] ?? '#3B82F6',
      iconName: map['icon'] ?? 'receipt',
      category: map['category'] ?? 'other',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titleAr': titleAr,
      'titleEn': titleEn,
      'amount': amount,
      'statusAr': statusAr,
      'statusEn': statusEn,
      'color': colorHex,
      'icon': iconName,
      'category': category,
    };
  }
}