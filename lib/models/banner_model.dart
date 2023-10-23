part of 'models.dart';

class BannerModel {
  String? bannerName;
  String? bannerImage;
  String? description;

  BannerModel({
    this.bannerName,
    this.bannerImage,
    this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerName: json['banner_name'],
        bannerImage: json['banner_image'],
        description: json['description'],
      );
}
