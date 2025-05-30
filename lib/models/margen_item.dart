import 'package:equatable/equatable.dart';

class MargenItem extends Equatable {
  final int idArticle;
  final double amount;
  final bool isPercentage;
  final bool isAplicable;

  const MargenItem({
    required this.idArticle,
    required this.amount,
    required this.isPercentage,
    required this.isAplicable,
  });

  @override
  List<Object?> get props => [
        idArticle,
        amount,
        isAplicable,
        isPercentage,
      ];

  //add ti copyWith
  MargenItem copyWith({
    int? idArticle,
    double? amount,
    bool? isPercentage,
    bool? isAplicable,
  }) {
    return MargenItem(
      idArticle: idArticle ?? this.idArticle,
      amount: amount ?? this.amount,
      isPercentage: isPercentage ?? this.isPercentage,
      isAplicable: isAplicable ?? this.isAplicable,
    );
  }
}
