import 'package:flutter_test/flutter_test.dart';

import 'package:sale_zencillo/sale_zencillo.dart';

void main() {
  group('taxes', () {
    test('tax1', () {
      final result = TaxMethods.changeItem(
          article: const SaleItem(
        quantityOriginal: 1,
        quantity: 1,
        taxAmountOriginal: 0,
        taxAmount: 0,
        taxPercentOriginal: 0,
        taxPercent: 0,
        discountAmountOriginal: 15126,
        discountAmount: 15126,
        discountPercentOriginal: 10,
        discountPercent: 10,
        discounts: [],
        discountsUsed: [],
        prices: [],
        taxes: [
          TaxItemDetail(idTaxRate: 1, percent: 19, code: 1),
        ],
        price: 180000,
        priceOriginal: 180000,
        isIncluyeIva: true,
        combinePromos: true,
        isPriceModified: true,
        idTaxRate: 1,
        idArticle: 1,
        idBrand: 1,
        idCategory: 1,
        idLine: 1,
        subTotal: 1,
        total: 1,
        promotions: [],
        promotionsUsed: [],
      ));

      // Assert
      expect(result.taxAmount, 25865.546218487376);
      expect(result.price, 151260.50420168068);
    });
    test('tax2', () {
      final result = TaxMethods.changeItemPro(
          article: const SaleItem(
        quantityOriginal: 1,
        quantity: 1,
        taxAmountOriginal: 0,
        taxAmount: 0,
        taxPercentOriginal: 0,
        taxPercent: 0,
        discountAmountOriginal: 15126,
        discountAmount: 15126,
        discountPercentOriginal: 0,
        discountPercent: 0,
        discounts: [],
        discountsUsed: [],
        prices: [],
        taxes: [
          TaxItemDetail(idTaxRate: 1, percent: 19, code: 1),
        ],
        price: 180000,
        priceOriginal: 180000,
        isIncluyeIva: true,
        combinePromos: true,
        isPriceModified: true,
        idTaxRate: 1,
        idArticle: 1,
        idBrand: 1,
        idCategory: 1,
        idLine: 1,
        subTotal: 1,
        total: 1,
        promotions: [],
        promotionsUsed: [],
      ));

      // Assert
      expect(result.price, 28739.495798319316);
      expect(result.taxAmount, 28739.495798319316);
    });
    test('tax3', () {
      final result = TaxMethods.changeItemPro(
          article: const SaleItem(
        quantityOriginal: 1,
        quantity: 1,
        taxAmountOriginal: 0,
        taxAmount: 0,
        taxPercentOriginal: 0,
        taxPercent: 0,
        discountAmountOriginal: 15126,
        discountAmount: 15126,
        discountPercentOriginal: 10,
        discountPercent: 10,
        discounts: [],
        discountsUsed: [],
        prices: [],
        taxes: [
          TaxItemDetail(idTaxRate: 1, percent: 19, code: 1),
        ],
        price: 180000,
        priceOriginal: 180000,
        isIncluyeIva: true,
        combinePromos: true,
        isPriceModified: true,
        idTaxRate: 1,
        idArticle: 1,
        idBrand: 1,
        idCategory: 1,
        idLine: 1,
        subTotal: 1,
        total: 1,
        promotions: [],
        promotionsUsed: [],
      ));

      // Assert
      expect(result.price, 25865.546218487376);
      expect(result.taxAmount, 25865.546218487376);
    });
    test('tax quantity 2', () {
      final result = TaxMethods.changeItemPro(
          article: const SaleItem(
        quantityOriginal: 1,
        quantity: 2,
        taxAmountOriginal: 0,
        taxAmount: 0,
        taxPercentOriginal: 0,
        taxPercent: 0,
        discountAmountOriginal: 15126,
        discountAmount: 15126,
        discountPercentOriginal: 10,
        discountPercent: 10,
        discounts: [],
        discountsUsed: [],
        prices: [],
        taxes: [
          TaxItemDetail(idTaxRate: 1, percent: 19, code: 1),
        ],
        price: 180000,
        priceOriginal: 180000,
        isIncluyeIva: true,
        combinePromos: true,
        isPriceModified: true,
        idTaxRate: 1,
        idArticle: 1,
        idBrand: 1,
        idCategory: 1,
        idLine: 1,
        subTotal: 1,
        total: 1,
        promotions: [],
        promotionsUsed: [],
      ));

      // Assert
      expect(result.price, 25865.546218487376);
      expect(result.taxAmount, 51731.09243697475);
    });
    test('tax quantity price 9300', () {
      final result = TaxMethods.changeItemPro(
          article: const SaleItem(
        quantityOriginal: 1,
        quantity: 1,
        taxAmountOriginal: 0,
        taxAmount: 0,
        taxPercentOriginal: 0,
        taxPercent: 19,
        discountAmountOriginal: 15126,
        discountAmount: 15126,
        discountPercentOriginal: 0,
        discountPercent: 0,
        discounts: [],
        discountsUsed: [],
        prices: [],
        taxes: [
          TaxItemDetail(idTaxRate: 1, percent: 19, code: 1),
        ],
        price: 32000,
        priceOriginal: 32000,
        isIncluyeIva: false,
        combinePromos: true,
        isPriceModified: true,
        idTaxRate: 1,
        idArticle: 1,
        idBrand: 1,
        idCategory: 1,
        idLine: 1,
        subTotal: 1,
        total: 1,
        promotions: [],
        promotionsUsed: [],
      ));

      // Assert
      expect(result.price, 32000);
      expect(result.taxAmount, 6080);
    });
    test('tax bolsa de hielo', () {
      final result = TaxMethods.changeItemPro(
          article: const SaleItem(
        quantityOriginal: 1,
        quantity: 1,
        taxAmountOriginal: 0,
        taxAmount: 0,
        taxPercentOriginal: 0,
        taxPercent: 19,
        discountAmountOriginal: 15126,
        discountAmount: 15126,
        discountPercentOriginal: 0,
        discountPercent: 0,
        discounts: [],
        discountsUsed: [],
        prices: [],
        taxes: [
          TaxItemDetail(idTaxRate: 1, percent: 19, code: 1),
        ],
        price: 15000,
        priceOriginal: 15000,
        isIncluyeIva: false,
        combinePromos: true,
        isPriceModified: true,
        idTaxRate: 1,
        idArticle: 1,
        idBrand: 1,
        idCategory: 1,
        idLine: 1,
        subTotal: 1,
        total: 1,
        promotions: [],
        promotionsUsed: [],
      ));

      // Assert
      expect(result.price, 15000);
      expect(result.taxAmount, 2565);
    });
  });
}
