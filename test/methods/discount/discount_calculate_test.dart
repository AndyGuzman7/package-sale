import 'package:flutter_test/flutter_test.dart';
import 'package:sale_zencillo/methods/discount/discount_calculate.dart';
import 'package:sale_zencillo/models/discount_item_detail.dart';

void main() {
  test('Prueba de la función sumar', () {
    final result = DiscountCalculate.xUnidad(
      modeDiscount: ModeDiscount.amount,
      value: 1.2,
      quantity: 3.70,
      price: 43.16,
    );

    // Assert
    expect(result.$1, 4.44);
  });

  test('Prueba de la función sumar', () {
    final result = DiscountCalculate.xUnidad(
      modeDiscount: ModeDiscount.percent,
      value: 10,
      quantity: 3.70,
      price: 43.16,
    );

    // Assert
    expect(result.$1, 15.9692);
  });

  test('Prueba de la función sumar', () {
    final result = DiscountCalculate.exactValue(
      modeDiscount: ModeDiscount.amount,
      value: 1.2,
      quantity: 3.70,
      price: 43.16,
    );

    // Assert
    expect(result.$1, 3.5999999999999996);
  });

  test('Prueba de la función sumar', () {
    final result = DiscountCalculate.exactValue(
      modeDiscount: ModeDiscount.percent,
      value: 10,
      quantity: 3.70,
      price: 43.16,
    );

    // Assert
    expect(result.$1, 12.948);
  });

  test('Prueba de la función sumar', () {
    final result = DiscountCalculate.normal(
      modeDiscount: ModeDiscount.amount,
      value: 1.2,
      quantity: 3.70,
      price: 43.16,
    );

    // Assert
    expect(result.$1, 1.20);
  });

  test('Prueba de la función sumar', () {
    final result = DiscountCalculate.normal(
      modeDiscount: ModeDiscount.percent,
      value: 10,
      quantity: 3.70,
      price: 43.16,
    );

    // Assert
    expect(result.$1, 15.9692);
  });
}
