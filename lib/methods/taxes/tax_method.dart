import 'dart:developer';

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
      );
      return article;
    }
    return article;
  }

  static double _priceIncluyeIva({
    required double taxPercent,
    required double price,
  }) {
    final percent = 1 + (taxPercent / 100);
    final tA = price - (price / percent);
    final newPrice = price - tA;

    return newPrice;
  }

  static double _taxAmountIncluyeIva({
    required double quantity,
    required double price,
    required double discountPercent,
    required double taxPercent,
  }) {
    final subTotal = quantity * price;
    var discountAmount = subTotal * (discountPercent / 100);
    final priceDiscount = subTotal - discountAmount;
    final percent = 1 + (taxPercent / 100);
    return priceDiscount - (priceDiscount / percent);
  }

  static SaleItem taxeCalculate({
    required SaleItem article,
  }) {
    final tax = article.taxes.where(
      (e) => e.idTaxRate == article.idTaxRate,
    );
    if (tax.isNotEmpty) {
      final taxPercent = tax.first.percent;

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
      );
    }

    return article;
  }

  static SaleItem changeItemPro({
    required SaleItem article,
  }) {
    final taxes = article.taxes;
    if (taxes.isEmpty) return article;

    final taxPercent = taxes.first.percent;

    final price = article.priceOriginalConst;
    final includesIva = article.isIncluyeIva;

    var discountAmount = article.discountAmount;
    var discountPercent = article.discountPercent;

    final quantity = article.quantity.emptyValue(1);

    if (includesIva) {
      final priceIncluyeIva = _priceIncluyeIva(
        price: price,
        taxPercent: taxPercent,
      );

      final taxAmountIncluyeIva = _taxAmountIncluyeIva(
        discountPercent: discountPercent,
        price: price,
        quantity: quantity,
        taxPercent: taxPercent,
      );
      article = article.copyWith(
        taxPercent: taxPercent,
        taxAmount: taxAmountIncluyeIva,
        price: priceIncluyeIva,
      );
      return article;
    } else {
      final subTotal = quantity * price;
      var discountAmount = subTotal * (discountPercent / 100);
      final priceDiscount = subTotal - discountAmount;
      final taxAmount = priceDiscount * (taxPercent / 100);

      article = article.copyWith(
        taxPercent: taxPercent,
        taxAmount: taxAmount,
      );
      return article;
    }
  }

  static SaleItem changeItemOtherPro({
    required SaleItem article,
  }) {
    final taxPercent = article.taxPercent;
    final taxOtherPercent = article.taxOtherPercent;
    final price = article.price;
    final priceOriginal = article.priceOriginal;

    final includesIva = article.isIncluyeIva;
    final includesOtherIva = article.taxOtherIsIncluye;

    var discountAmount = article.discountAmount;
    if (article.discountPercent != 0) {
      discountAmount = price * article.discountPercent / 100;
    }

    if (taxOtherPercent != 0) {
      var newPrice = price;
      final otherPercent = 1 + (taxOtherPercent / 100);
      var newTaxAmountOther = article.taxOtherAmount;
      if (includesOtherIva) {
        final priceT = priceOriginal - discountAmount;
        newTaxAmountOther = priceT - (priceT / otherPercent);

        final percentTotal =
            includesIva ? taxPercent + taxOtherPercent : taxOtherPercent;
        final percentNew = 1 + (percentTotal / 100);
        final tA = priceOriginal - (priceOriginal / percentNew);
        newPrice = priceOriginal - tA;
      } else {
        final priceT = price - discountAmount;
        newTaxAmountOther = priceT * (taxOtherPercent / 100);
      }
      return article.copyWith(
        taxOtherAmount: newTaxAmountOther,
        price: newPrice,
      );
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
