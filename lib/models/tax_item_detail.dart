import 'package:equatable/equatable.dart';

class TaxItemDetail extends Equatable {
  const TaxItemDetail({
    required this.idTaxRate,
    required this.percent,
    required this.code,
  });

  const TaxItemDetail.empty()
      : this(
          idTaxRate: 0,
          percent: 0,
          code: 0,
        );

  final int idTaxRate;
  final double percent;

  final int? code;

  @override
  List<Object?> get props => [
        idTaxRate,
        percent,
        code,
      ];
}
