// lib/features/fees/presentation/cubit/fees_state.dart

import 'package:equatable/equatable.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_item_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/fees_entities/fees_summary_entity.dart';

sealed class FeesState extends Equatable {
  const FeesState();

  @override
  List<Object?> get props => [];
}

final class FeesInitial extends FeesState {
  const FeesInitial();
}

final class FeesLoading extends FeesState {
  const FeesLoading();
}

final class FeesLoaded extends FeesState {
  final FeesSummaryEntity summary;
  final List<FeeItemEntity> items;

  const FeesLoaded({
    required this.summary,
    required this.items,
  });

  List<FeeItemEntity> get academicItems =>
      items.where((item) => item.category == 'academic').toList();

  List<FeeItemEntity> get servicesItems =>
      items.where((item) => item.category == 'services').toList();

  @override
  List<Object?> get props => [summary, items];
}

final class FeesFailure extends FeesState {
  final String message;

  const FeesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}