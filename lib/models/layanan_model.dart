part of 'models.dart';

class LayananModel {
  String? serviceCode;
  String? serviceName;
  String? serviceIcon;
  num? serviceTarif;

  LayananModel({
    this.serviceCode,
    this.serviceName,
    this.serviceIcon,
    this.serviceTarif,
  });

  factory LayananModel.fromJson(Map<String, dynamic> json) => LayananModel(
        serviceCode: json['service_code'],
        serviceName: json['service_name'],
        serviceIcon: json['service_icon'],
        serviceTarif: json['service_tariff'],
      );
}
