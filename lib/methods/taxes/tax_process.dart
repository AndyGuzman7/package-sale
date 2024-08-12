import 'package:sale_zencillo/methods/taxes/tax_method.dart';
import 'package:sale_zencillo/models/sale_item.dart';
import 'package:sale_zencillo/models/tax_item_detail.dart';

class TaxProcess {
  static SaleItem changeItem({required SaleItem saleItem}) =>
      TaxMethods.changeItem(article: saleItem);

  static List<SaleItem> changeList({
    required List<SaleItem> articlesEntity,
  }) {
    final articles = articlesEntity.map((e) {
      return TaxMethods.changeItem(article: e);
    }).toList();

    return articles;
  }

  static SaleItem prepareItem({
    required SaleItem item,
    required List<TaxItemDetail> taxes,
  }) {
    return TaxMethods.prepareSingle(item: item, taxes: taxes);
  }

  static List<SaleItem> prepareList({
    required List<SaleItem> items,
    required List<TaxItemDetail> taxes,
  }) {
    return TaxMethods.prepareTaxes(articlesEntity: items, taxes: taxes);
  }
}
