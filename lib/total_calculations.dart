import 'package:sale_zencillo/extensions/extension_double.dart';
import 'package:sale_zencillo/models/sale_item.dart';
import 'package:sale_zencillo/models/total.dart';

class TotalCalculations {
  static SaleItem totalItem(
    SaleItem article,
    int area,
  ) {
    final discountAmount = article.discountAmount.roundByArea(area);
    final discountPercent = article.discountPercent;

    final subTotal = (article.quantity * article.price).roundByArea(area);
    final taxAmount = ((subTotal - discountAmount) * (article.taxPercent / 100))
        .roundByArea(area);

    final total = (subTotal - discountAmount + taxAmount).roundByArea(area);

    return article.copyWith(
      subTotal: subTotal,
      taxAmount: taxAmount,
      discountAmount: discountAmount,
      discountPercent: discountPercent,
      total: total,
      quantity: article.quantity.decimalsRound(4),
    );
  }

  static TotalSale totalList(
    List<SaleItem> saleEntity,
    int area,
    double tip,
  ) {
    final subTotal = saleEntity.map((e) => e.subTotal).sum;
    final taxAmount = saleEntity.map((e) => e.taxAmount).sum;
    final discount = saleEntity.map((e) => e.discountAmount).sum;
    final total = subTotal + taxAmount - discount + tip;

    return TotalSale(
      subTotal: subTotal.roundByArea(area),
      taxTotal: taxAmount.roundByArea(area),
      discountTotal: discount.roundByArea(area),
      total: total.roundByArea(area),
    );
  }
}
