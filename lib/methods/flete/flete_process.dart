import 'package:sale_zencillo/extensions/extension_double.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class FleteProcess {
  static SaleItem prepareItem({
    required SaleItem item,
    required double flete,
  }) {
    item = _prepareItem(
      item: item,
      flete: flete,
    );

    return item;
  }

  static SaleItem _prepareItem({
    required SaleItem item,
    required double flete,
  }) {
    return item.copyWith(
      fleteAmount: flete,
    );
  }

  static SaleItem changeItem({
    required SaleItem saleItem,
  }) {
    return _changeItem(saleItem: saleItem);
  }

  static SaleItem _changeItem({
    required SaleItem saleItem,
  }) {
    final price = saleItem.price;
    final newPrice = price + saleItem.fleteAmount;
    saleItem = saleItem.copyWith(
      price: newPrice,
    );
    return saleItem;
  }
}
