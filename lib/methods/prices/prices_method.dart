import 'package:collection/collection.dart';
import 'package:sale_zencillo/extensions/extension_double.dart';
import 'package:sale_zencillo/models/price_item_detail.dart';

class PriceMethods {
  static List<PriceItemDetail> _getPricesArticle(
    int idArticle,
    List<PriceItemDetail> prices,
  ) {
    final pricesByArticle = prices.where(
      (e) => e.idArticle == idArticle,
    );
    final quantities = pricesByArticle.toList();
    return quantities;
  }

  static double changeItem({
    required List<PriceItemDetail> prices,
    required double quantity,
    required double priceOriginal,
  }) {
    quantity = quantity.emptyValue(1);
    final sortedPrices = List<PriceItemDetail>.from(prices)
      ..sort((a, b) => b.quantity.compareTo(a.quantity));

    final price = sortedPrices
        .firstWhereOrNull((price) => price.quantity <= quantity)
        ?.amount;

    return price ?? priceOriginal;
  }

  static List<PriceItemDetail> prepare({
    required int idArticle,
    required List<PriceItemDetail> prices,
  }) {
    final pricesArticle = _getPricesArticle(idArticle, prices);
    return pricesArticle;
  }
}
