import 'package:collection/collection.dart';
import 'package:sale_zencillo/models/promotion_item.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class PromotionMethod {
  // Obtiene las promociones aplicables para el artículo de venta dado
  static List<PromotionItem> _getPromotions(SaleItem saleItem) {
    final today = DateTime.now();

    // Filtra las promociones activas según la fecha actual
    var activePromotions = saleItem.promotions
        .where((e) => today.isAfter(e.start) && today.isBefore(e.finish))
        .toList();

    // Si las promociones deben combinarse, solo se devuelve la lista filtrada por valor
    if (saleItem.combinePromos) {
      return saleItem.promotions
          .where((e) => saleItem.subTotal >= e.value)
          .toList();
    } else {
      // Ordena las promociones por valor descendente
      activePromotions.sort((a, b) => b.value.compareTo(a.value));

      // Encuentra la primera promoción que cumple con el subtotal
      final promotion = activePromotions.firstWhereOrNull(
        (element) => saleItem.subTotal >= element.value,
      );

      // Devuelve la promoción encontrada o una lista vacía si no se encuentra ninguna
      return promotion != null ? [promotion] : [];
    }
  }

  // Cambia el artículo de venta basado en las promociones aplicables
  static SaleItem changeItem({
    required SaleItem saleItem,
  }) {
    final hasPromotions = saleItem.promotions.isNotEmpty;

    // Si no hay promociones, devuelve el artículo de venta sin cambios
    if (!hasPromotions) return saleItem;

    // Obtiene las promociones aplicables
    final promotions = _getPromotions(saleItem);

    // Devuelve una nueva instancia del artículo de venta con las promociones aplicadas
    return saleItem.copyWith(promotionsUsed: promotions);
  }
}
