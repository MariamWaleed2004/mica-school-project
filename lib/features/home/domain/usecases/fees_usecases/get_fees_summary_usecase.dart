
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';

class GetFeesSummaryUsecase {
  final HomeRepo repo;

  GetFeesSummaryUsecase(this.repo);

  Future<FeesSummaryEntity> call(String userId) async {
    return await repo.getFeesSummary(userId);
  }
}