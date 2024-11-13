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

class TotalResult {
  const TotalResult({
    required this.subtotal,
    required this.taxAmount,
    required this.discount,
    required this.total,
    required this.tip,
    required this.retentions,
    required this.totalTopay,
    required this.subsidyTotal,
    required this.subsidySavings,
  });
  const TotalResult.empty()
      : subtotal = 0.0,
        taxAmount = 0.0,
        discount = 0.0,
        total = 0.0,
        tip = 0.0,
        retentions = const [0.0, 0.0, 0.0, 0.0],
        subsidyTotal = 0.0,
        subsidySavings = 0.0,
        totalTopay = 0.0;
  TotalResult copyWith({
    double? subtotal,
    double? taxAmount,
    double? discount,
    double? total,
    double? tip,
    List<double>? retentions,
    double? subsidyTotal,
    double? subsidySavings,
    double? totalTopay,
  }) {
    return TotalResult(
      subtotal: subtotal ?? this.subtotal,
      taxAmount: taxAmount ?? this.taxAmount,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      tip: tip ?? this.tip,
      retentions: retentions ?? this.retentions,
      totalTopay: totalTopay ?? this.totalTopay,
      subsidyTotal: subsidyTotal ?? this.subsidyTotal,
      subsidySavings: subsidySavings ?? this.subsidySavings,
    );
  }

  final double subtotal;
  final double taxAmount;
  final double discount;
  final double tip;
  final double total;
  final List<double> retentions;
  final double totalTopay;
  final double subsidyTotal;
  final double subsidySavings;
}
