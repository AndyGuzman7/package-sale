import 'package:flutter_test/flutter_test.dart';
import 'package:sale_zencillo/methods/discount/discount_method.dart';
import 'package:sale_zencillo/models/client_item_detail.dart';
import 'package:sale_zencillo/models/discount.dart';
import 'package:sale_zencillo/models/discount_item_detail.dart';
import 'package:sale_zencillo/models/sale_item.dart';

main() {
  test('Test Prepare data to process discount', () {
    final saleItem = const SaleItem.empty().copyWith(
      idArticle: 303,
      price: 10,
      quantity: 1,
    );
    final clientItem = const ClientItemDetail.empty().copyWith(
      idClient: 12345,
      identification: 'ABC123456',
    );

    final detailSale = DetailDiscount(
      idDetail: 101,
      idClient: 12345,
      identification: 'ABC123456',
      idArticle: 303,
      idClientType: null,
      idClasification: null,
      idGroup: null,
      idLine: null,
      idBrand: null,
      idCategory: null,
      idPayWay: null,
    );

    final discountSale = DiscountSale(
      idDiscount: 1,
      percent: 0,
      startDate: DateTime(2024, 9, 1),
      finishDate: DateTime(2024, 9, 30),
      startHour: '08:00',
      finishHour: '20:00',
      days: const ['Monday', 'Wednesday', 'Friday'],
      allDay: false,
      value: 10,
      allPayWay: true,
      detail: [detailSale],
      aplicaxunidad: true,
      valorexacto: 1,
    );

    final result = DiscountMethods.prepareSingle(
      features: [discountSale],
      item: saleItem,
      client: clientItem,
      payWays: [],
    );

    // Assert
    expect(result.discounts.length, 1);
    expect(result.discounts.first.modeDiscount, ModeDiscount.amount);
    expect(result.discounts.first.typeDiscount, TypeDiscount.valorExacto);
    expect(result.discounts.first.value, 10);
  });
}
