import 'package:equatable/equatable.dart';

class ClientItemDetail extends Equatable {
  const ClientItemDetail({
    required this.idClient,
    required this.idType,
    required this.idSubType,
    required this.idClientGroup,
    required this.idBusinessGroup,
    required this.idClasification,
    required this.idSegmentation,
    required this.idTaxPayerType,
    required this.idIdentificationType,
    required this.identificationTypeName,
    required this.identification,
    required this.idPayWay,
  });

  const ClientItemDetail.empty()
      : this(
          idClient: 0,
          idType: 0,
          idSubType: 0,
          idClientGroup: 0,
          idBusinessGroup: 0,
          idClasification: 0,
          idSegmentation: 0,
          idTaxPayerType: 0,
          idIdentificationType: 0,
          identificationTypeName: '',
          identification: '',
          idPayWay: 2,
        );

  final int idClient;
  final int idType;
  final int idSubType;
  final int idClientGroup;
  final int idBusinessGroup;
  final int idClasification;
  final int idSegmentation;
  final int idTaxPayerType;
  final int idIdentificationType;
  final String identificationTypeName;
  final String identification;

  final int idPayWay;

  ClientItemDetail copyWith({
    int? idClient,
    int? idType,
    int? idSubType,
    int? idClientGroup,
    int? idBusinessGroup,
    int? idClasification,
    int? idSegmentation,
    int? idTaxPayerType,
    int? idIdentificationType,
    String? identificationTypeName,
    String? identification,
    int? idPayWay,
  }) {
    return ClientItemDetail(
      idClient: idClient ?? this.idClient,
      idType: idType ?? this.idType,
      idSubType: idSubType ?? this.idSubType,
      idClientGroup: idClientGroup ?? this.idClientGroup,
      idBusinessGroup: idBusinessGroup ?? this.idBusinessGroup,
      idClasification: idClasification ?? this.idClasification,
      idSegmentation: idSegmentation ?? this.idSegmentation,
      idTaxPayerType: idTaxPayerType ?? this.idTaxPayerType,
      idIdentificationType: idIdentificationType ?? this.idIdentificationType,
      identificationTypeName:
          identificationTypeName ?? this.identificationTypeName,
      identification: identification ?? this.identification,
      idPayWay: idPayWay ?? this.idPayWay,
    );
  }

  @override
  List<Object?> get props => [
        idClient,
        idType,
        idSubType,
        idClientGroup,
        idBusinessGroup,
        idClasification,
        idSegmentation,
        idTaxPayerType,
        idIdentificationType,
        identificationTypeName,
        identification,
        idPayWay,
      ];
}
