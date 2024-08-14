import 'package:sale_zencillo/methods/promotions/promotion_method.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class PromotionProcess {
  static SaleItem changeItem({required SaleItem saleItem}) =>
      PromotionMethod.changeItem(saleItem: saleItem);

  static List<SaleItem> changeList({
    required List<SaleItem> articlesEntity,
  }) {
    final articles = articlesEntity.map((e) {
      return PromotionMethod.changeItem(saleItem: e);
    }).toList();

    return articles;
  }
}
