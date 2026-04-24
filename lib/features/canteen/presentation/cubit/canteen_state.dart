import 'package:equatable/equatable.dart';
import 'package:mica_school_app/features/canteen/domain/entities/canteen_month_entity.dart';

sealed class CanteenState extends Equatable {
  const CanteenState();

  @override
  List<Object?> get props => [];
}

final class CanteenInitial extends CanteenState {
  const CanteenInitial();
}

final class CanteenLoading extends CanteenState {
  const CanteenLoading();
}

final class CanteenLoaded extends CanteenState {
  final CanteenMonthEntity data;
  final List<String> availableMonths;
  final String selectedMonth;

  const CanteenLoaded({
    required this.data,
    required this.availableMonths,
    required this.selectedMonth,
  });

  @override
  List<Object?> get props => [data, availableMonths, selectedMonth];
}

final class CanteenError extends CanteenState {
  final String message;

  const CanteenError(this.message);

  @override
  List<Object?> get props => [message];
}