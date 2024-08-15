import 'package:sale_zencillo/models/discount_item_detail.dart';
import 'package:sale_zencillo/models/price_item_detail.dart';
import 'package:sale_zencillo/models/promotion_item.dart';
import 'package:sale_zencillo/models/tax_item_detail.dart';

class SaleItem {
  const SaleItem({
    required this.quantityOriginal,
    required this.quantity,
    required this.taxAmountOriginal,
    required this.taxAmount,
    required this.taxPercentOriginal,
    required this.taxPercent,
    required this.discountAmountOriginal,
    required this.discountAmount,
    required this.discountPercentOriginal,
    required this.discountPercent,
    required this.discounts,
    required this.discountsUsed,
    required this.prices,
    required this.taxes,
    required this.price,
    required this.priceOriginal,
    required this.isIncluyeIva,
    required this.combinePromos,
    required this.isPriceModified,
    required this.idTaxRate,
    required this.idArticle,
    required this.idBrand,
    required this.idCategory,
    required this.idLine,
    required this.subTotal,
    required this.total,
    required this.promotions,
    required this.promotionsUsed,
  });

  const SaleItem.empty()
      : quantityOriginal = 0.0,
        quantity = 0.0,
        taxAmountOriginal = 0.0,
        taxAmount = 0.0,
        taxPercentOriginal = 0.0,
        taxPercent = 0.0,
        discountAmountOriginal = 0.0,
        discountAmount = 0.0,
        discountPercentOriginal = 0.0,
        discountPercent = 0.0,
        discounts = const [],
        prices = const [],
        taxes = const [],
        price = 0,
        priceOriginal = 0,
        isIncluyeIva = false,
        isPriceModified = false,
        combinePromos = false,
        idTaxRate = 0,
        idArticle = 0,
        idBrand = 0,
        idCategory = 0,
        idLine = 0,
        subTotal = 0,
        total = 0,
        promotions = const [],
        promotionsUsed = const [],
        discountsUsed = const [];

  const SaleItem.article({
    required int idArticle,
    required double quantity,
    required int idLine,
    required int idCategory,
    required int idBrand,
    required int idTaxRate,
    required bool isIncluyeIva,
    required bool combinePromos,
    required double price,
    required List<PromotionItem> promotions,
  })  : quantityOriginal = quantity,
        quantity = quantity,
        taxAmountOriginal = 0.0,
        taxAmount = 0.0,
        taxPercentOriginal = 0.0,
        taxPercent = 0.0,
        discountAmountOriginal = 0.0,
        discountAmount = 0.0,
        discountPercentOriginal = 0.0,
        discountPercent = 0.0,
        discounts = const [],
        prices = const [],
        taxes = const [],
        price = price,
        priceOriginal = price,
        isIncluyeIva = isIncluyeIva,
        combinePromos = combinePromos,
        idTaxRate = idTaxRate,
        idArticle = idArticle,
        idBrand = idBrand,
        idCategory = idCategory,
        idLine = idLine,
        subTotal = 0,
        total = 0,
        isPriceModified = false,
        promotions = promotions,
        promotionsUsed = const [],
        discountsUsed = const [];

  final double quantityOriginal;
  final double quantity;

  final double taxAmountOriginal;
  final double taxAmount;

  final double taxPercentOriginal;
  final double taxPercent;

  final double discountAmountOriginal;
  final double discountAmount;

  final double discountPercentOriginal;
  final double discountPercent;

  final List<DiscountItemDetail> discounts;
  final List<DiscountItemDetail> discountsUsed;

  final List<PriceItemDetail> prices;

  final List<PromotionItem> promotions;
  final List<PromotionItem> promotionsUsed;

  final double price;
  final double priceOriginal;

  final List<TaxItemDetail> taxes;

  final bool combinePromos;
  final bool isIncluyeIva;
  final bool isPriceModified;

  final int idTaxRate;
  final int idArticle;
  final int idCategory;
  final int idBrand;
  final int idLine;

  final double subTotal;
  final double total;

  bool get ishaveDiscounts => discounts.isNotEmpty;

  SaleItem copyWith({
    double? quantityOriginal,
    double? quantity,
    double? taxAmountOriginal,
    double? taxAmount,
    double? taxPercentOriginal,
    double? taxPercent,
    double? discountAmountOriginal,
    double? discountAmount,
    double? discountPercentOriginal,
    double? discountPercent,
    ModeDiscount? modeDiscount,
    List<DiscountItemDetail>? discounts,
    List<DiscountItemDetail>? discountsUsed,
    bool? ishaveDiscounts,
    List<PriceItemDetail>? prices,
    double? price,
    double? priceOriginal,
    List<TaxItemDetail>? taxes,
    bool? isIncluyeIva,
    bool? combinePromos,
    bool? isPriceModified,
    int? idTaxRate,
    int? idArticle,
    int? idCategory,
    int? idLine,
    int? idBrand,
    double? subTotal,
    double? total,
    List<PromotionItem>? promotions,
    List<PromotionItem>? promotionsUsed,
  }) {
    return SaleItem(
      quantityOriginal: quantityOriginal ?? this.quantityOriginal,
      quantity: quantity ?? this.quantity,
      taxAmountOriginal: taxAmountOriginal ?? this.taxAmountOriginal,
      taxAmount: taxAmount ?? this.taxAmount,
      taxPercentOriginal: taxPercentOriginal ?? this.taxPercentOriginal,
      taxPercent: taxPercent ?? this.taxPercent,
      discountAmountOriginal:
          discountAmountOriginal ?? this.discountAmountOriginal,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercentOriginal:
          discountPercentOriginal ?? this.discountPercentOriginal,
      discountPercent: discountPercent ?? this.discountPercent,
      discounts: discounts ?? this.discounts,
      discountsUsed: discountsUsed ?? this.discountsUsed,
      prices: prices ?? this.prices,
      price: price ?? this.price,
      priceOriginal: priceOriginal ?? this.priceOriginal,
      taxes: taxes ?? this.taxes,
      isIncluyeIva: isIncluyeIva ?? this.isIncluyeIva,
      combinePromos: combinePromos ?? this.combinePromos,
      idTaxRate: idTaxRate ?? this.idTaxRate,
      idArticle: idArticle ?? this.idArticle,
      idBrand: idBrand ?? this.idBrand,
      idCategory: idCategory ?? this.idCategory,
      idLine: idLine ?? this.idLine,
      isPriceModified: isPriceModified ?? this.isPriceModified,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      promotions: promotions ?? this.promotions,
      promotionsUsed: promotionsUsed ?? this.promotionsUsed,
    );
  }
}
