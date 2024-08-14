import 'package:collection/collection.dart';
import 'package:sale_zencillo/models/promotion_item.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class PromotionMethod {
  static List<PromotionItem> _getPromotions(
    SaleItem saleItem,
  ) {
    final today = DateTime.now();
    var promotions = saleItem.promotions
        .where((e) => today.isAfter(e.start) && today.isBefore(e.finish))
        .toList();

    if (saleItem.combinePromos) {
      return saleItem.promotions
          .where((e) => saleItem.subTotal >= e.value)
          .toList();
    } else {
      promotions.sort((a, b) => b.value.compareTo(a.value));
      final promotion = promotions.firstWhereOrNull(
        (element) => saleItem.subTotal >= element.value,
      );
      return promotion != null ? [promotion] : [];
    }
  }

  static SaleItem changeItem({
    required SaleItem saleItem,
  }) {
    final isPromotions = saleItem.promotions.isNotEmpty;

    if (!isPromotions) return saleItem;

    final promotions = _getPromotions(saleItem);

    return saleItem.copyWith(promotionsUsed: promotions);
  }
}
