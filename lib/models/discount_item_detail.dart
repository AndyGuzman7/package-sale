enum ModeDiscount { percent, amount, none }

enum TypeDiscount { isXunidad, valorExacto, none }

class DiscountItemDetail {
  DiscountItemDetail({
    required this.idDiscount,
    required this.idDiscountDetail,
    required this.value,
    required this.modeDiscount,
    required this.typeDiscount,
  });

  final int idDiscount;
  final int idDiscountDetail;
  final double value;
  final ModeDiscount modeDiscount;
  final TypeDiscount typeDiscount;
}
