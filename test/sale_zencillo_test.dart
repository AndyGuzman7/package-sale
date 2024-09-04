import 'package:flutter_test/flutter_test.dart';

import 'package:sale_zencillo/sale_zencillo.dart';

int sumar(int a, int b) {
  return a + b;
}

void main() {
  test('Prueba de la función sumar', () {
    // Arrange
    int a = 2;
    int b = 3;

    // Act
    int resultado = sumar(a, b);

    // Assert
    expect(resultado, 5);
  });
}
