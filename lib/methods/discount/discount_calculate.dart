import 'package:sale_zencillo/models/discount_item_detail.dart';

class DiscountCalculate {
  static (double, double) xUnidad({
    required ModeDiscount modeDiscount,
    required double value,
    required double quantity,
    required double price,
  }) {
    final subTotal = quantity * price;
    switch (modeDiscount) {
      case ModeDiscount.amount:
        final disAmount = value * quantity;
        final disPercentage = 100 * disAmount / subTotal;
        return (
          disAmount,
          disPercentage,
        );
      case ModeDiscount.percent:
        final discountAmount = subTotal * (value / 100);
        return (discountAmount, value);
      case ModeDiscount.none:
        return (0, 0);
    }
  }

  static (double, double) exactValue({
    required ModeDiscount modeDiscount,
    required double value,
    required double quantity,
    required double price,
  }) {
    final subTotal = quantity * price;
    switch (modeDiscount) {
      case ModeDiscount.amount:
        final quantityInteger = quantity.toInt();
        final amountInteger = quantityInteger * value;

        final disAmount = amountInteger;
        final disPercentage = 100 * amountInteger / subTotal;

        return (disAmount, disPercentage);
      case ModeDiscount.percent:
        final quantityInteger = quantity.toInt();
        final amountInteger = quantityInteger * price;

        final disAmount = amountInteger * (value / 100);
        final disPercentage = value;
        return (
          disAmount,
          disPercentage,
        );
      case ModeDiscount.none:
        return (
          0,
          0,
        );
    }
  }

  static (double, double) normal({
    required ModeDiscount modeDiscount,
    required double value,
    required double quantity,
    required double price,
  }) {
    final subTotal = quantity * price;
    switch (modeDiscount) {
      case ModeDiscount.amount:
        final disPercentage = 100 * value / subTotal;

        return (value, disPercentage);
      case ModeDiscount.percent:
        final disAmount = subTotal * (value / 100);
        final disPercentage = value;
        return (
          disAmount,
          disPercentage,
        );
      case ModeDiscount.none:
        return (0, 0);
    }
  }
}
