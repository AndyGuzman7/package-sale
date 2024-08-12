import 'package:sale_zencillo/extensions/extension_double.dart';
import 'package:sale_zencillo/models/sale_item.dart';
import 'package:sale_zencillo/models/tax_item_detail.dart';

class TaxMethods {
  static List<TaxItemDetail> _getTaxesArticle(
    int idTaxRate,
    List<TaxItemDetail> taxes,
  ) {
    final taxesByArticle =
        taxes.where((e) => e.idTaxRate == idTaxRate).toList();

    return taxesByArticle;
  }

  static List<SaleItem> prepareTaxes({
    required List<TaxItemDetail> taxes,
    required List<SaleItem> articlesEntity,
  }) {
    final articles = articlesEntity.map(
      (e) {
        final taxesArticle = _getTaxesArticle(e.idTaxRate, taxes);
        return e.copyWith(taxes: taxesArticle);
      },
    ).toList();
    return articles;
  }

  static SaleItem prepareSingle({
    required List<TaxItemDetail> taxes,
    required SaleItem item,
  }) {
    final taxesArticle = _getTaxesArticle(item.idTaxRate, taxes);
    return item.copyWith(taxes: taxesArticle);
  }

  static double _calculatePriceIva(double price, double taxPercent) {
    final percent = 1 + (taxPercent / 100);
    return price - (price / percent);
  }

  static SaleItem changeItemPrice({
    required SaleItem saleItem,
  }) {
    final taxes = saleItem.taxes;
    if (taxes.isNotEmpty) {
      final tax = taxes.first;
      final taxPercent = tax.percent;

      final quantity = saleItem.quantity.emptyValue(1);
      final price = saleItem.price.orValue(
        ok: saleItem.isIncluyeIva,
        value: _calculatePriceIva(saleItem.price, taxPercent),
      );
      final discountAmount = saleItem.discountAmount;

      final subTotal = quantity * price;

      //aplicando descuento para sacar el valor del impuesto
      final subTotalWithDiscount = subTotal - discountAmount;

      final taxAmount = subTotalWithDiscount * (taxPercent / 100);

      saleItem = saleItem.copyWith(
        taxPercent: taxPercent,
        taxAmount: taxAmount,
        price: price,
      );
    }
    return saleItem;
  }

  static SaleItem changeItem({
    required SaleItem article,
  }) {
    final taxes = article.taxes;
    if (taxes.isNotEmpty) {
      final taxPercent = taxes.first.percent;

      final price = article.price;
      final taxAmount = article.taxAmount;

      final includesIva = article.isIncluyeIva;

      final percent = 1 + (taxPercent / 100);

      var discountAmount = article.discountAmount;
      if (article.discountPercent != 0) {
        discountAmount = price * article.discountPercent / 100;
      }

      var newTaxAmount = taxAmount;
      var newPrice = price;
      if (includesIva) {
        final priceT = price - discountAmount;
        newTaxAmount = priceT - (priceT / percent);

        final tA = price - (price / percent);
        newPrice = price - tA;
      } else {
        final priceT = price - discountAmount;

        newTaxAmount = priceT * (taxPercent / 100);
      }

      article = article.copyWith(
        taxPercent: taxPercent,
        taxAmount: newTaxAmount,
        price: newPrice,
        priceOriginal: newPrice,
      );
      return article;
    }
    return article;
  }

  static List<SaleItem> changeItemListPrice({
    required List<SaleItem> articlesEntity,
  }) {
    final articles = articlesEntity.map((e) {
      return changeItemPrice(saleItem: e);
    }).toList();

    return articles;
  }

  static List<SaleItem> processMain({
    required List<TaxItemDetail> taxes,
    required List<SaleItem> articlesEntity,
    bool isPrepare = false,
  }) {
    if (isPrepare) {
      articlesEntity = prepareTaxes(
        articlesEntity: articlesEntity,
        taxes: taxes,
      );
    }
    return changeItemListPrice(articlesEntity: articlesEntity);
  }
}
