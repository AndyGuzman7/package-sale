import 'package:equatable/equatable.dart';

class PromotionItem extends Equatable {
  const PromotionItem({
    required this.id,
    required this.idArticle,
    required this.quantity,
    required this.promoQuantity,
    required this.start,
    required this.finish,
    required this.value,
    required this.promoValue,
  });

  final String id;

  final int idArticle;
  final int quantity;
  final int promoQuantity;
  final DateTime start;
  final DateTime finish;
  final double value;
  final double promoValue;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromotionItem &&
        other.idArticle == idArticle &&
        other.quantity == quantity &&
        other.promoQuantity == promoQuantity &&
        other.start == start &&
        other.finish == finish &&
        other.value == value &&
        other.promoValue == promoValue;
  }

  @override
  List<Object?> get props => [
        idArticle,
        quantity,
        promoQuantity,
        start,
        finish,
        value,
        promoValue,
      ];

  @override
  int get hashCode {
    return idArticle.hashCode ^
        quantity.hashCode ^
        promoQuantity.hashCode ^
        start.hashCode ^
        finish.hashCode ^
        value.hashCode ^
        promoValue.hashCode;
  }
}
