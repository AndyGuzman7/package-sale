import 'package:collection/collection.dart';
import 'package:sale_zencillo/extensions/extension_double.dart';
import 'package:sale_zencillo/models/price_item_detail.dart';
import 'package:sale_zencillo/models/sale_item.dart';

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

  static SaleItem changeItem({
    required SaleItem saleItem,
  }) {
    var quantity = saleItem.quantity.emptyValue(1);

    final sortedPrices = List<PriceItemDetail>.from(saleItem.prices)
      ..sort((a, b) => b.quantity.compareTo(a.quantity));

    final price = sortedPrices
        .firstWhereOrNull((price) => price.quantity <= quantity)
        ?.amount;

    return price != null
        ? saleItem.copyWith(
            price: price,
            priceOriginal: price,
          )
        : saleItem;
  }

  static List<SaleItem> prepare({
    required List<SaleItem> items,
    required List<PriceItemDetail> features,
  }) {
    final articles = items.map(
      (e) {
        final pricesArticle = _getPricesArticle(e.idArticle, features);
        return e.copyWith(prices: pricesArticle);
      },
    ).toList();

    return articles;
  }

  static SaleItem prepareSingle({
    required SaleItem item,
    required List<PriceItemDetail> prices,
  }) {
    final pricesArticle = _getPricesArticle(item.idArticle, prices);
    return item.copyWith(prices: pricesArticle);
  }
}
