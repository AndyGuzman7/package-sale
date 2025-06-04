import 'package:sale_zencillo/models/margen_item.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class MargenProcess {
  static SaleItem prepareItem({
    required SaleItem item,
    required List<MargenItem> margen,
  }) {
    item = prepareSingle(
      item: item,
      margenList: margen,
    );

    return item;
  }

  static SaleItem prepareSingle({
    required SaleItem item,
    required List<MargenItem> margenList,
  }) {
    final margenes = _getMargenArticle(item.idArticle, margenList);
    final margen = margenes.firstOrNull;
    if (margen == null) {
      return item;
    }
    var amount = 0.0;
    var percentage = 0.0;

    if (margen.isPercentage) {
      percentage = margen.amount;
    } else {
      amount = margen.amount;
    }
    return item.copyWith(
      margenAmount: amount,
      margenPercent: percentage,
    );
  }

  static List<MargenItem> _getMargenArticle(
    int idArticle,
    List<MargenItem> margenes,
  ) {
    final margenByArticle = margenes.where(
      (e) => e.idArticle == idArticle,
    );
    final items = margenByArticle.toList();
    return items;
  }

  static SaleItem changeItem({
    required SaleItem saleItem,
  }) {
    return _changeItem(saleItem: saleItem);
  }

  static SaleItem _changeItem({
    required SaleItem saleItem,
  }) {
    final price = saleItem.priceOriginalConst;
    var newPrice = price;
    if (saleItem.margenPercent > 0) {
      newPrice = price + (price * saleItem.margenPercent / 100);
    } else if (saleItem.margenAmount > 0) {
      newPrice = price + saleItem.margenAmount;
    }

    saleItem = saleItem.copyWith(
      price: newPrice,
      priceOriginal: newPrice,
    );
    return saleItem;
  }

  static SaleItem changeItemPro({
    required SaleItem saleItem,
  }) {
    return _changeItemPro(saleItem: saleItem);
  }

  static SaleItem _changeItemPro({
    required SaleItem saleItem,
  }) {
    final price = saleItem.priceOriginal;
    final flete = saleItem.fleteAmount;

    var newPrice = price;
    if (saleItem.margenPercent > 0) {
      newPrice = price + (price * saleItem.margenPercent / 100);
    } else if (saleItem.margenAmount > 0) {
      newPrice = price + saleItem.margenAmount;
    }

    saleItem = saleItem.copyWith(
      price: newPrice + flete,
      //priceOriginal: newPrice + flete,
    );
    return saleItem;
  }
}
