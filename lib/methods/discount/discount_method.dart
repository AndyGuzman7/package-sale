import 'package:flutter/foundation.dart';

import 'package:sale_zencillo/extensions/extension_double.dart';
import 'package:sale_zencillo/methods/discount/discount_calculate.dart';
import 'package:sale_zencillo/models/client_item_detail.dart';
import 'package:sale_zencillo/models/discount.dart';
import 'package:sale_zencillo/models/discount_item.dart';
import 'package:sale_zencillo/models/discount_item_detail.dart';
import 'package:sale_zencillo/models/sale_item.dart';

class DiscountMethods {
  static List<DiscountItem> convertDiscounts({
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

  /*static SaleItem changeItem({required SaleItem saleItem}) {
    final listDiscount = saleItem.discounts;
    final firstDiscount = listDiscount.firstOrNull;
    if (firstDiscount == null) return saleItem;

    var discountAmount = saleItem.discountAmount;
    var discountPercent = saleItem.discountPercent;

    switch (firstDiscount.modeDiscount) {
      case ModeDiscount.percent:
        discountPercent = firstDiscount.value;
      case ModeDiscount.amount:
        discountAmount = firstDiscount.value;
      case ModeDiscount.none:
        discountAmount = saleItem.discountAmount;
        discountPercent = saleItem.discountPercent;
    }

    saleItem = saleItem.copyWith(
      discountAmount: discountAmount,
      discountAmountOriginal: discountAmount,
      discountPercent: discountPercent,
      discountPercentOriginal: discountPercent,
      discountsUsed: [firstDiscount],
      modeDiscount: firstDiscount.modeDiscount,
    );

    return calculateValueDiscount(saleItem: saleItem);
  }*/

  static List<SaleItem> changeItemList({
    required List<SaleItem> articlesEntity,
  }) {
    final articles = articlesEntity.map((e) {
      return changeItem(saleItem: e);
    }).toList();

    return articles;
  }

  static List<SaleItem> prepare({
    required List<SaleItem> items,
    required List<DiscountSale> features,
    required ClientItemDetail client,
    required List<int> payWays,
  }) {
    final identification = client.identification;
    final idBusinessGroup = client.idBusinessGroup;
    final idClasification = client.idClasification;
    final idType = client.idType;

    final discounts = convertDiscounts(discounts: features);

    final articles = items.map((article) {
      final listDiscountsAplicate = filterApplicate(
        discounts,
        article,
        idBusinessGroup,
        identification,
        idType,
        payWays,
        idClasification,
      );

      return article.copyWith(
        discounts: listDiscountsAplicate,
        ishaveDiscounts: listDiscountsAplicate.isNotEmpty,
      );
    }).toList();

    return articles;
  }

  static SaleItem prepareSingle({
    required SaleItem item,
    required List<DiscountSale> features,
    required ClientItemDetail client,
    required List<int> payWays,
  }) {
    final identification = client.identification;
    final idBusinessGroup = client.idBusinessGroup;
    final idClasification = client.idClasification;
    final idType = client.idType;

    final discounts = convertDiscounts(discounts: features);

    final listDiscountsAplicate = filterApplicate(
      discounts,
      item,
      idBusinessGroup,
      identification,
      idType,
      payWays,
      idClasification,
    );

    return item.copyWith(
      discounts: listDiscountsAplicate,
      ishaveDiscounts: listDiscountsAplicate.isNotEmpty,
    );
  }

  static List<SaleItem> processMain({
    required List<SaleItem> items,
    required List<DiscountSale> features,
    required ClientItemDetail client,
    required List<int> payWays,
    bool isPrepare = false,
  }) {
    if (isPrepare) {
      items = prepare(
        items: items,
        features: features,
        client: client,
        payWays: payWays,
      );
    }

    return changeItemList(articlesEntity: items);
  }

  /*static List<SaleItem> calculateMain({
    required List<SaleItem> items,
  }) {}*/

  static List<DiscountItemDetail> filterApplicate(
    List<DiscountItem> discounts,
    SaleItem articleUsed,
    int idBusinessGroup,
    String identification,
    int idType,
    List<int> payWays,
    int? idClasification,
  ) {
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
      final isArticleDiscount = idArticulo == articleUsed.idArticle;
      if (isArticleDiscount) list.add(v2);

      //03
      const v3 = '03';
      final idCategoria = d.idCategory;
      if (idCategoria != -1) listB.add(v3);
      final isCategoryDiscount = idCategoria == articleUsed.idCategory;
      if (isCategoryDiscount) list.add(v3);

      //04
      const v4 = '04';
      final idLine = d.idLine;
      if (idLine != -1) listB.add(v4);
      final isLineDiscount = idLine == articleUsed.idLine;
      if (isLineDiscount) list.add('04');

      //05
      const v5 = '05';
      final idBrand = d.idBrand;
      if (idBrand != -1) listB.add(v5);
      final isBrand = idBrand == articleUsed.idBrand;
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

  static SaleItem changeItem({
    required SaleItem saleItem,
  }) {
    final discount = saleItem.discounts.firstOrNull;
    if (discount == null) {
      return saleItem.copyWith(
          discountAmount: 0,
          discountAmountOriginal: 0,
          discountPercent: 0,
          discountPercentOriginal: 0,
          discounts: [],
          discountsUsed: []);
    }

    final quantity = saleItem.quantity.emptyValue(1);
    final value = discount.value;
    final price = saleItem.price;

    final modeDiscount = discount.modeDiscount;

    final isModeAmount = discount.modeDiscount == ModeDiscount.amount;
    final isModePercent = discount.modeDiscount == ModeDiscount.percent;

    saleItem = saleItem.copyWith(
      discountAmountOriginal: isModeAmount ? discount.value : 0,
      discountPercentOriginal: isModePercent ? discount.value : 0,
      discountsUsed: [discount],
    );

    switch (discount.typeDiscount) {
      case TypeDiscount.isXunidad:
        final response = DiscountCalculate.xUnidad(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        return saleItem.copyWith(
          discountAmount: response.$1,
          discountPercent: response.$2,
        );
      case TypeDiscount.valorExacto:
        final response = DiscountCalculate.exactValue(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        return saleItem.copyWith(
          discountAmount: response.$1,
          discountPercent: response.$2,
        );
      case TypeDiscount.none:
        final response = DiscountCalculate.normal(
          modeDiscount: modeDiscount,
          value: value,
          quantity: quantity,
          price: price,
        );
        return saleItem.copyWith(
          discountAmount: response.$1,
          discountPercent: response.$2,
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
