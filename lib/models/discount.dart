import 'package:equatable/equatable.dart';

class DiscountSale extends Equatable {
  const DiscountSale({
    required this.idDiscount,
    required this.percent,
    required this.startDate,
    required this.finishDate,
    required this.startHour,
    required this.finishHour,
    required this.days,
    required this.allDay,
    required this.value,
    required this.allPayWay,
    required this.detail,
    required this.aplicaxunidad,
    required this.valorexacto,
  });

  final int idDiscount;

  /// Percent value of discount
  final double? percent;
  final DateTime startDate;
  final DateTime finishDate;
  final String startHour;
  final String finishHour;
  final List<String> days;
  final bool allDay;

  /// Amount value of discount
  final double? value;

  final bool allPayWay;
  final List<DetailSale>? detail;
  final bool aplicaxunidad;
  final double? valorexacto;

  DiscountSale setDetail(
    Iterable<DetailSale> detail,
  ) {
    return DiscountSale(
        idDiscount: idDiscount,
        percent: percent,
        startDate: startDate,
        finishDate: finishDate,
        startHour: startHour,
        finishHour: finishHour,
        days: days,
        allDay: allDay,
        value: value,
        allPayWay: allPayWay,
        detail: detail.toList(),
        aplicaxunidad: aplicaxunidad,
        valorexacto: valorexacto);
  }

  @override
  List<Object?> get props => [
        idDiscount,
        percent,
        startDate,
        finishDate,
        startHour,
        finishHour,
        days,
        allDay,
        value,
        allPayWay,
        detail,
        valorexacto,
      ];
}

class DetailSale {
  DetailSale({
    required this.idDetail,
    required this.idClient,
    required this.identification,
    required this.idArticle,
    required this.idClientType,
    required this.idClasification,
    required this.idGroup,
    required this.idLine,
    required this.idBrand,
    required this.idCategory,
    required this.idPayWay,
  });

  final int idDetail;
  final int? idClient;
  final String? identification;
  final int? idArticle;
  final int? idClientType;
  final int? idClasification;
  final int? idGroup;
  final int? idLine;
  final int? idBrand;
  final int? idCategory;
  final int? idPayWay;
}
