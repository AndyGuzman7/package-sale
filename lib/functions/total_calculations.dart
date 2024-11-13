import 'package:sale_zencillo/extensions/extension_double.dart';
import 'package:sale_zencillo/models/round_amount.dart';
import 'package:sale_zencillo/models/sale_item.dart';
import 'package:sale_zencillo/models/total.dart';

class TotalCalculations {
  static TotalResult total({
    required List<SaleItem> saleEntitys,
    required List<double> retentions,
    required RoundAmount subTotalRound,
    required RoundAmount taxAmountRound,
    required RoundAmount discountRound,
    required RoundAmount totalToPayRound,
    required RoundAmount totalRound,
    required RoundAmount retention1Round,
    required RoundAmount retention2Round,
    required RoundAmount retention3Round,
    required RoundAmount retention4Round,
    double tip = 0,
  }) {
    final subTotal = saleEntitys.map((e) => e.subTotal).sum;
    final taxAmount = saleEntitys.map((e) => e.taxAmount).sum;
    final discount = saleEntitys.map((e) => e.discountAmount).sum;

    final subsidySavings = saleEntitys.map((e) => e.subSidy * e.quantity).sum;
    final subsidyTotal = saleEntitys.map((e) => e.subSidyPrice).sum;
    final tipValue = subTotal * (tip / 100);

    final total = subTotal + taxAmount - discount + tip;

    final retention1 = total * (retentions[0] / 100);
    final retention2 = total * (retentions[1] / 100);
    final retention3 = total * (retentions[2] / 100);
    final retention4 = total * (retentions[3] / 100);

    final totalToPay = total -
        subsidySavings -
        (retention1 + retention2 + retention3 + retention4);

    return TotalResult(
      subtotal: subTotalRound.isActive
          ? subTotal.roundTo(subTotalRound.round)
          : subTotal,
      taxAmount: taxAmountRound.isActive
          ? taxAmount.roundTo(taxAmountRound.round)
          : taxAmount,
      discount: discountRound.isActive
          ? discount.roundTo(discountRound.round)
          : discount,
      total: totalRound.isActive ? total.roundTo(totalRound.round) : total,
      tip: tipValue,
      retentions: [
        retention1Round.isActive
            ? retention1.roundTo(retention1Round.round)
            : retention1,
        retention2Round.isActive
            ? retention2.roundTo(retention2Round.round)
            : retention2,
        retention3Round.isActive
            ? retention3.roundTo(retention3Round.round)
            : retention3,
        retention4Round.isActive
            ? retention4.roundTo(retention4Round.round)
            : retention4,
      ],
      subsidySavings: subsidySavings,
      subsidyTotal: subsidyTotal,
      totalTopay: totalToPayRound.isActive
          ? totalToPay.roundTo(totalToPayRound.round)
          : totalToPay,
    );
  }
}
