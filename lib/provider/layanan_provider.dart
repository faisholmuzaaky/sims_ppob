import 'package:flutter/material.dart';
import 'package:sims_ppob/models/models.dart';
import 'package:sims_ppob/services/services.dart';

class LayananProvider with ChangeNotifier {
  List<LayananModel>? _layanan;
  List<LayananModel> get listLayanan => _layanan ?? <LayananModel>[];

  Future<dynamic> getLayanan({
    required String token,
  }) async {
    ApiReturnValue<List<LayananModel>> result = await LayananService().layanan(
      token: token,
    );
    if (result.value != null) {
      _layanan = result.value;
      return result.value!;
    } else {
      return result.message;
    }
  }
}
