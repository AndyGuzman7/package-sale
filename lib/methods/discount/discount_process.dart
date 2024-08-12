import 'package:sale_zencillo/methods/discount/discount_method.dart';
import 'package:sale_zencillo/models/client_item_detail.dart';
import 'package:sale_zencillo/models/discount.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class DiscountProcess {
  static SaleItem changeItem({required SaleItem saleItem}) =>
      DiscountMethods.changeItem(saleItem: saleItem);

  static List<SaleItem> changeList({
    required List<SaleItem> saleItems,
  }) {
    final articles = saleItems.map((e) {
      return DiscountMethods.changeItem(saleItem: e);
    }).toList();

    return articles;
  }

  static List<SaleItem> prepareList({
    required List<SaleItem> items,
    required List<DiscountSale> features,
    required ClientItemDetail client,
    required List<int> payWays,
  }) {
    items = DiscountMethods.prepare(
      items: items,
      client: client,
      payWays: payWays,
      features: features,
    );
    return items;
  }

  static SaleItem prepareItem({
    required SaleItem items,
    required List<DiscountSale> features,
    required ClientItemDetail client,
    required List<int> payWays,
  }) {
    items = DiscountMethods.prepareSingle(
      item: items,
      client: client,
      payWays: payWays,
      features: features,
    );
    return items;
  }
}
