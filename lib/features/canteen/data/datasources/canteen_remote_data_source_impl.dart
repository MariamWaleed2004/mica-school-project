// lib/features/canteen/data/datasources/canteen_remote_data_source_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/canteen/data/datasources/canteen_remote_data_source.dart';
import 'package:mica_school_app/features/canteen/data/models/canteen_month_model.dart';
import 'package:mica_school_app/features/canteen/data/models/purchase_model.dart';
import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';

class CanteenRemoteDataSourceImpl implements CanteenRemoteDataSource {
  final FirebaseFirestore firestore;

  CanteenRemoteDataSourceImpl({required this.firestore});

  @override
  Future<CanteenMonthEntity?> getMonthData(String userId, String monthKey, bool isArabic) async {
    print("🔍 Getting canteen data for userId: $userId, month: $monthKey");
    
    final monthDoc = await firestore
        .collection('users')
        .doc(userId)
        .collection('canteen')
        .doc(monthKey)
        .get();

    if (!monthDoc.exists) {
      print("❌ Month document not found: $monthKey");
      return null;
    }

    print("✅ Month document found");
    final monthData = CanteenMonthModel.fromMap(monthDoc.data()!, monthKey);
    
    // جلب المشتريات اليومية
    final dailyPurchases = <String, List<PurchaseEntity>>{};
    
    final daysSnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('canteen')
        .doc(monthKey)
        .collection('dailyPurchases')
        .get();

    print("📚 Days found in 'dailyPurchases': ${daysSnapshot.docs.length}");

    for (var dayDoc in daysSnapshot.docs) {
      final dayData = dayDoc.data();
      print("📌 Document ID: ${dayDoc.id}");
      print("   Data: $dayData");
      
      // 🔥 استخدم nameAr و nameEn (مش dayAr/dayEn)
      final dayName = isArabic ? dayData['nameAr'] : dayData['nameEn'];
      print("   Day name ($isArabic): $dayName");
      
      if (dayName == null || dayName.toString().isEmpty) {
        print("   ⚠️ Day name is null or empty!");
        continue;
      }
      
      final itemsSnapshot = await dayDoc.reference.collection('items').get();
      print("   Items found: ${itemsSnapshot.docs.length}");
      
      final purchases = itemsSnapshot.docs
          .map((itemDoc) {
            print("      Item: ${itemDoc.data()}");
            return PurchaseModel.fromMap(itemDoc.data(), itemDoc.id);
          })
          .toList();
      
      if (purchases.isNotEmpty) {
        dailyPurchases[dayName] = purchases;
        print("   ✅ Added '$dayName' with ${purchases.length} items");
      }
    }

    print("📊 Total dailyPurchases entries: ${dailyPurchases.length}");
    print("📊 Keys: ${dailyPurchases.keys}");

    return CanteenMonthModel(
      monthKey: monthKey,
      balance: monthData.balance,
      savings: monthData.savings,
      startBalance: monthData.startBalance,
      ratios: monthData.ratios,
      dailyPurchases: dailyPurchases,
    );
  }

  @override
  Future<List<String>> getAvailableMonths(String userId) async {
    print("🔍 Getting available months for userId: $userId");
    
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('canteen')
        .get();
    
    final months = snapshot.docs.map((doc) => doc.id).toList();
    print("📚 Available months: $months");
    
    return months;
  }
}