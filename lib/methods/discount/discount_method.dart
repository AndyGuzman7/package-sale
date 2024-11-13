import 'package:flutter/foundation.dart';
import 'package:sale_zencillo/sale_zencillo.dart';

class DiscountMethods {
  static List<DiscountItem> _convertDiscounts({
    required List<DiscountSale> discounts,
  }) {
    final dis2 = <DiscountItem>[];
    for (final discount in discounts) {
      if (discount.detail != null) {
        dis2.addAll(
          discount.detail!.map(
            (detail) => DiscountItem(
              idDiscount: discount.idDiscount,
              idDetail: detail.idDetail,
              aplicaxunidad: discount.aplicaxunidad,
              valorexacto: discount.valorexacto == 1,
              allPayWay: discount.allPayWay,
              idPayWay: detail.idPayWay ?? -1,
              idArticulo: detail.idArticle ?? -1,
              identification: detail.identification ?? 'NaN',
              idClasification: detail.idClasification ?? -1,
              idClientType: detail.idClientType ?? -1,
              idGroup: detail.idGroup ?? -1,
              percent: discount.percent ?? 0.0,
              idBrand: detail.idBrand ?? -1,
              idCategory: detail.idCategory ?? -1,
              idLine: detail.idLine ?? -1,
              amount: discount.value ?? 0.0,
            ),
          ),
        );
      }
    }
    return dis2;
  }

  static List<DiscountItemDetail> prepareSingle({
    required int idArticleUsed,
    required int idCategoryUsed,
    required int idLineUsed,
    required int idBrandUsed,
    required List<DiscountSale> discounts,
    required ClientItemDetail client,
    required List<int> payWays,
  }) {
    final identification = client.identification;
    final idBusinessGroup = client.idBusinessGroup;
    final idClasification = client.idClasification;
    final idType = client.idType;

    final convertDiscounts = _convertDiscounts(discounts: discounts);

    final filterDiscounts = _filterDiscounst(
      discounts: convertDiscounts,
      idBusinessGroup: idBusinessGroup,
      identification: identification,
      idType: idType,
      payWays: payWays,
      idClasification: idClasification,
      idArticleUsed: idArticleUsed,
      idBrandUsed: idBrandUsed,
      idLineUsed: idLineUsed,
      idCategoryUsed: idCategoryUsed,
    );

    return filterDiscounts;
  }

  static List<DiscountItemDetail> _filterDiscounst({
    required List<DiscountItem> discounts,
    required int idBusinessGroup,
    required String identification,
    required int idType,
    required List<int> payWays,
    required int? idClasification,
    required int idArticleUsed,
    required int idCategoryUsed,
    required int idLineUsed,
    required int idBrandUsed,
  }) {
    final listDiscountsAplicate = <DiscountItemDetail>[];
    for (final d in discounts) {
      final list = <String>[];
      final listB = <String>[];
      final isValorExacto = d.valorexacto;
      final isAplicaxunidad = d.aplicaxunidad;
      final idDiscount = d.idDiscount;
      final idDetail = d.idDetail;
      final percent = d.percent;
      final amout = d.amount;

      //01
      const v1 = '01';
      final idGroup = d.idGroup;
      if (idGroup != -1) listB.add(v1);
      final isGroupDiscount = idGroup == idBusinessGroup;
      if (isGroupDiscount) list.add(v1);

      //02
      const v2 = '02';
      final idArticulo = d.idArticulo;
      if (idArticulo != -1) listB.add(v2);
      final isArticleDiscount = idArticulo == idArticleUsed;
      if (isArticleDiscount) list.add(v2);

      //03
      const v3 = '03';
      final idCategoria = d.idCategory;
      if (idCategoria != -1) listB.add(v3);
      final isCategoryDiscount = idCategoria == idCategoryUsed;
      if (isCategoryDiscount) list.add(v3);

      //04
      const v4 = '04';
      final idLine = d.idLine;
      if (idLine != -1) listB.add(v4);
      final isLineDiscount = idLine == idLineUsed;
      if (isLineDiscount) list.add('04');

      //05
      const v5 = '05';
      final idBrand = d.idBrand;
      if (idBrand != -1) listB.add(v5);
      final isBrand = idBrand == idBrandUsed;
      if (isBrand) list.add(v5);

      //06
      const v6 = '06';
      final identificationClient = d.identification;
      if (identificationClient != 'NaN') listB.add(v6);
      final isIdentificationDiscount = identification == identificationClient;
      if (isIdentificationDiscount) list.add(v6);

      //07
      const v7 = '07';
      final idClientType = d.idClientType;
      if (idClientType != -1) listB.add(v7);
      final isClientType = idClientType == idType;
      if (isClientType) list.add('07');

      //08
      const v8 = '08';
      final idClasificationClient = d.idClasification;
      if (idClasificationClient != -1) listB.add(v8);
      final isClasification = idClasification == idClasificationClient;
      if (isClasification) list.add(v8);

      //09
      const v9 = '09';
      final idPayWay = d.idPayWay;
      if (idPayWay != -1) listB.add(v9);
      final isPayWay = payWays.any((element) => element == idPayWay);
      if (isPayWay) list.add(v9);

      final isDiscount = listEquals(list, listB);

      if (isDiscount) {
        var mode = ModeDiscount.none;
        if (amout != 0) mode = ModeDiscount.amount;
        if (percent != 0) mode = ModeDiscount.percent;

        var value = 0.0;
        if (amout != 0) value = amout;
        if (percent != 0) value = percent;

        var type = TypeDiscount.none;
        if (isAplicaxunidad) type = TypeDiscount.isXunidad;
        //if (isAplicaxunidad) type = TypeDiscount.isXunidad;

        if (isValorExacto && isAplicaxunidad) type = TypeDiscount.valorExacto;

        listDiscountsAplicate.add(
          DiscountItemDetail(
            idDiscount: idDiscount,
            idDiscountDetail: idDetail,
            value: value,
            modeDiscount: mode,
            typeDiscount: type,
          ),
        );
      }
    }
    return listDiscountsAplicate;
  }

  static DiscountResult changeItem({
    // required SaleItem saleIstem,
    required double quantity,
    required double price,
    required List<DiscountItemDetail> discounts,
  }) {
    final discount = discounts.firstOrNull;
    if (discount == null) {
      return DiscountResult(
        discountAmount: 0,
        discountPercent: 0,
        discountsUsed: [],
      );
    }

    quantity = quantity.emptyValue(1);
    final value = discount.value;
    //final price = saleItem.price;

    final modeDiscount = discount.modeDiscount;

    final isModeAmount = discount.modeDiscount == ModeDiscount.amount;
    final isModePercent = discount.modeDiscount == ModeDiscount.percent;

    /*saleItem = saleItem.copyWith(
      discountAmountOriginal: isModeAmount ? discount.value : 0,
      discountPercentOriginal: isModePercent ? discount.value : 0,
      discountsUsed: [discount],
    );*/

    switch (discount.typeDiscount) {
      case TypeDiscount.isXunidad:
        final response = DiscountCalculate.xUnidad(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        return DiscountResult(
          discountAmount: response.$1,
          discountPercent: response.$2,
          discountsUsed: [discount],
        );
      case TypeDiscount.valorExacto:
        final response = DiscountCalculate.exactValue(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        return DiscountResult(
          discountAmount: response.$1,
          discountPercent: response.$2,
          discountsUsed: [discount],
        );
      case TypeDiscount.none:
        final response = DiscountCalculate.normal(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        return DiscountResult(
          discountAmount: response.$1,
          discountPercent: response.$2,
          discountsUsed: [discount],
        );
    }
  }

  static (double, double) processSingle({
    required SaleItem saleItem,
  }) {
    final discount = saleItem.discounts.firstOrNull;
    if (discount == null) {
      return (saleItem.discountAmount, saleItem.discountPercent);
    }

    final quantity = saleItem.quantity.emptyValue(1);
    final value = discount.value;
    final price = saleItem.price;

    final modeDiscount = discount.modeDiscount;

    switch (discount.typeDiscount) {
      case TypeDiscount.isXunidad:
        final response = DiscountCalculate.xUnidad(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        final sale = saleItem.copyWith(
          discountAmount: response.$1,
          discountPercent: response.$2,
        );
        return (sale.discountAmount, sale.discountPercent);
      case TypeDiscount.valorExacto:
        final response = DiscountCalculate.exactValue(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        final sale = saleItem.copyWith(
          discountAmount: response.$1,
          discountPercent: response.$2,
        );
        return (sale.discountAmount, sale.discountPercent);
      case TypeDiscount.none:
        final response = DiscountCalculate.normal(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        final sale = saleItem.copyWith(
          discountAmount: response.$1,
          discountPercent: response.$2,
        );
        return (sale.discountAmount, sale.discountPercent);
    }
  }
}
