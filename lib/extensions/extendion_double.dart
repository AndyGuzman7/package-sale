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
