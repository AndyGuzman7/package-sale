import 'package:sale_zencillo/methods/prices/prices_method.dart';
import 'package:sale_zencillo/models/price_item_detail.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class PricesProcess {
  static SaleItem changeItem({
    required SaleItem saleItem,
  }) {
    return PriceMethods.changeItem(saleItem: saleItem);
  }

  static List<SaleItem> changeList({
    required List<SaleItem> articlesEntity,
  }) {
    final articles = articlesEntity.map((e) {
      return PriceMethods.changeItem(saleItem: e);
    }).toList();

    return articles;
  }

  static List<SaleItem> prepareList({
    required List<SaleItem> items,
    required List<PriceItemDetail> prices,
  }) {
    items = PriceMethods.prepare(
      items: items,
      features: prices,
    );

    return items;
  }

  static SaleItem prepareItem({
    required SaleItem item,
    required List<PriceItemDetail> prices,
  }) {
    item = PriceMethods.prepareSingle(
      item: item,
      prices: prices,
    );

    return item;
  }
}
