import 'package:flutter/material.dart';
import 'package:sims_ppob/models/models.dart';
import 'package:sims_ppob/services/services.dart';

class BannerProvider with ChangeNotifier {
  List<BannerModel>? _banner;
  List<BannerModel> get listBanner => _banner ?? <BannerModel>[];

  Future<dynamic> getBanner({
    required String token,
  }) async {
    ApiReturnValue<List<BannerModel>> result = await BannerService().banner(
      token: token,
    );
    if (result.value != null) {
      _banner = result.value;
      return result.value!;
    } else {
      return result.message;
    }
  }
}
