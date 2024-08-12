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
