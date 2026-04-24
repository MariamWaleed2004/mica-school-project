class FeesSummaryEntity {
  final double totalAmount;
  final double paidAmount;
  final double remainingAmount;

  const FeesSummaryEntity({
    required this.totalAmount,
    required this.paidAmount,
    required this.remainingAmount,
  });

  double get paidPercentage => totalAmount > 0 ? paidAmount / totalAmount : 0;
  
  String getFormattedTotal(bool isArabic) {
    return "${totalAmount.toStringAsFixed(0)} EGP";
  }
  
  String getFormattedPaid(bool isArabic) {
    return "${paidAmount.toStringAsFixed(0)} EGP";
  }
  
  String getFormattedRemaining(bool isArabic) {
    return "${remainingAmount.toStringAsFixed(0)} EGP";
  }
}