import 'package:sale_zencillo/models/discount_item_detail.dart';

class DiscountResult {
  final List<DiscountItemDetail> discountsUsed;
  final double discountAmount;
  final double discountPercent;

  DiscountResult({
    required this.discountsUsed,
    required this.discountAmount,
    required this.discountPercent,
  });
}
