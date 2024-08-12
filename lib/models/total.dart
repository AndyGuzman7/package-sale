import 'package:equatable/equatable.dart';

class TotalSale extends Equatable {
  final double subTotal;
  final double taxTotal;
  final double discountTotal;
  final double total;

  const TotalSale({
    required this.subTotal,
    required this.taxTotal,
    required this.discountTotal,
    required this.total,
  });

  // Método copyWith
  TotalSale copyWith({
    double? subTotal,
    double? taxTotal,
    double? discountTotal,
    double? total,
  }) {
    return TotalSale(
      subTotal: subTotal ?? this.subTotal,
      taxTotal: taxTotal ?? this.taxTotal,
      discountTotal: discountTotal ?? this.discountTotal,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [subTotal, taxTotal, discountTotal, total];
}
