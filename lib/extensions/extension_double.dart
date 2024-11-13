import 'dart:math' as math;

import 'package:intl/intl.dart';

extension ValidationDouble on double {
  double emptyValue(double value) {
    if (this == 0) {
      return value;
    }
    return this;
  }

  bool isEmpty() {
    if (this == 0) {
      return true;
    }
    return false;
  }

  double orValue({
    required bool ok,
    required double value,
  }) {
    if (ok) {
      return value;
    }
    return this;
  }
}

extension IterableDoubleExtension on Iterable<double> {
  double? get minOrNull {
    var iterator = this.iterator;
    if (iterator.moveNext()) {
      var value = iterator.current;
      if (value.isNaN) {
        return value;
      }
      while (iterator.moveNext()) {
        var newValue = iterator.current;
        if (newValue.isNaN) {
          return newValue;
        }
        if (newValue < value) {
          value = newValue;
        }
      }
      return value;
    }
    return null;
  }

  double get min => minOrNull ?? (throw StateError('No element'));

  double? get maxOrNull {
    var iterator = this.iterator;
    if (iterator.moveNext()) {
      var value = iterator.current;
      if (value.isNaN) {
        return value;
      }
      while (iterator.moveNext()) {
        var newValue = iterator.current;
        if (newValue.isNaN) {
          return newValue;
        }
        if (newValue > value) {
          value = newValue;
        }
      }
      return value;
    }
    return null;
  }

  double get max => maxOrNull ?? (throw StateError('No element'));

  double get sum {
    var result = 0.0;
    for (var value in this) {
      result += value;
    }
    return result;
  }
}

extension FormatDouble on double {
  String format(String currency, int round) {
    final formatter = NumberFormat.decimalPatternDigits(decimalDigits: round);
    final amount = formatter.format(abs());
    final isNegative = this < 0;
    final negativeSymbol = isNegative ? '- ' : '';
    return '$negativeSymbol$currency$amount';
  }

  String decimals(int round) {
    final formatter = NumberFormat.decimalPatternDigits(decimalDigits: round);
    final number = formatter.format(this);
    return number;
  }

  double decimalsNumeric(int round) {
    final factor = math.pow(10, round);
    return (this * factor).round() / factor;
  }

  /*double decimalsRound(int c) {
    final factor = math.pow(10, c);
    return (this * factor).round() / factor;
  }*/

  double decimalsRound(int c) {
    final numeroConDosDecimales = (this * 100).round() / 100;
    return numeroConDosDecimales;
  }

  double roundByArea(int round) {
    final formatter = NumberFormat.decimalPatternDigits(decimalDigits: round);
    final number = formatter.format(this);
    final cleaned = number.replaceAll(',', '');
    return double.parse(cleaned);
  }

  double roundTo(int round) {
    final formatter = NumberFormat.decimalPatternDigits(decimalDigits: round);
    final number = formatter.format(this);
    final cleaned = number.replaceAll(',', '');
    return double.parse(cleaned);
  }
}
