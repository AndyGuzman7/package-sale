import 'package:sale_zencillo/models/tax_item_detail.dart';
import 'package:sale_zencillo/models/tax_result.dart';

class TaxMethods {
  static List<TaxItemDetail> _getTaxesArticle(
    int idTaxRate,
    List<TaxItemDetail> taxes,
  ) {
    final taxesByArticle =
        taxes.where((e) => e.idTaxRate == idTaxRate).toList();

    return taxesByArticle;
  }

  static List<TaxItemDetail> prepare({
    required List<TaxItemDetail> taxes,
    required int idTaxRate,
  }) {
    final taxesArticle = _getTaxesArticle(idTaxRate, taxes);
    return taxesArticle;
  }

  static TaxResult changeItem({
    required List<TaxItemDetail> taxes,
    required double price,
    required double taxAmount,
    required double taxPercent,
    required bool includesIva,
    required double discountAmount,
    required double discountPercent,
  }) {
    if (taxes.isNotEmpty) {
      final taxPercent = taxes.first.percent;

      //final price = article.price;
      //final taxAmount = article.taxAmount;

      //final includesIva = article.isIncluyeIva;

      final percent = 1 + (taxPercent / 100);

      //var discountAmount = article.discountAmount;
      if (discountPercent != 0) {
        discountAmount = price * discountPercent / 100;
      }

      var newTaxAmount = taxAmount;
      var newPrice = price;
      if (includesIva) {
        final priceT = price - discountAmount;
        newTaxAmount = priceT - (priceT / percent);

        final tA = price - (price / percent);
        newPrice = price - tA;
      } else {
        final priceT = price - discountAmount;

        newTaxAmount = priceT * (taxPercent / 100);
      }

      return TaxResult(
        taxAmount: newTaxAmount,
        taxPercent: taxPercent,
        price: newPrice,
      );
    }
    return TaxResult(
      taxAmount: taxAmount,
      taxPercent: taxPercent,
      price: price,
    );
  }
}
