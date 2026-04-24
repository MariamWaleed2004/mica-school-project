// lib/features/fees/domain/usecases/get_all_fees_items_usecase.dart
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';

class GetAllFeesItemsUsecase {
  final HomeRepo repo;

  GetAllFeesItemsUsecase(this.repo);

  Future<List<FeeItemEntity>> call(String userId) async {
    return await repo.getAllFeesItems(userId);
  }
}