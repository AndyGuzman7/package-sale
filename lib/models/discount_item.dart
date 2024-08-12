import 'package:equatable/equatable.dart';

class DiscountItem extends Equatable {
  const DiscountItem({
    required this.idDiscount,
    required this.idDetail,
    required this.aplicaxunidad,
    required this.valorexacto,
    required this.allPayWay,
    required this.idPayWay,
    required this.idArticulo,
    required this.identification,
    required this.idClasification,
    required this.idClientType,
    required this.idGroup,
    required this.percent,
    required this.idBrand,
    required this.idCategory,
    required this.idLine,
    required this.amount,
  });
  final int idDiscount;
  final int idDetail;
  final bool aplicaxunidad;
  final bool valorexacto;
  final bool allPayWay;
  final int idPayWay;
  final int idArticulo;
  final String identification;
  final int idClasification;
  final int idClientType;
  final int idGroup;
  final double percent;
  final int idBrand;
  final int idCategory;
  final int idLine;
  final double amount;

  @override
  List<Object?> get props => [
        idDiscount,
        idDetail,
        aplicaxunidad,
        valorexacto,
        allPayWay,
        idPayWay,
        idArticulo,
        identification,
        idClasification,
        idClientType,
        idGroup,
        percent,
        idBrand,
        idCategory,
        idLine,
        amount,
      ];

  DiscountItem copyWith({
    int? idDiscount,
    int? idDetail,
    bool? aplicaxunidad,
    bool? valorexacto,
    bool? allPayWay,
    int? idPayWay,
    int? idArticulo,
    String? identification,
    int? idClasification,
    int? idClientType,
    int? idGroup,
    double? percent,
    int? idBrand,
    int? idCategory,
    int? idLine,
    double? amount,
  }) {
    return DiscountItem(
      idDiscount: idDiscount ?? this.idDiscount,
      idDetail: idDetail ?? this.idDetail,
      aplicaxunidad: aplicaxunidad ?? this.aplicaxunidad,
      valorexacto: valorexacto ?? this.valorexacto,
      allPayWay: allPayWay ?? this.allPayWay,
      idPayWay: idPayWay ?? this.idPayWay,
      idArticulo: idArticulo ?? this.idArticulo,
      identification: identification ?? this.identification,
      idClasification: idClasification ?? this.idClasification,
      idClientType: idClientType ?? this.idClientType,
      idGroup: idGroup ?? this.idGroup,
      percent: percent ?? this.percent,
      idBrand: idBrand ?? this.idBrand,
      idCategory: idCategory ?? this.idCategory,
      idLine: idLine ?? this.idLine,
      amount: amount ?? this.amount,
    );
  }
}
