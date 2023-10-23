import 'package:flutter/material.dart';
import 'package:sims_ppob/models/models.dart';
import 'package:sims_ppob/services/services.dart';

class TransaksiProvider with ChangeNotifier {
  List<TransaksiModel>? _transaksi;
  List<TransaksiModel> get listTransaksi => _transaksi ?? <TransaksiModel>[];

  Future<dynamic> history({
    required String token,
    int? offet,
    int? limit,
  }) async {
    ApiReturnValue<List<TransaksiModel>> result =
        await TransaksiService().transaksi(
      token: token,
      offet: offet,
      limit: limit,
    );
    if (result.value != null) {
      _transaksi = result.value;
      return result.value!;
    } else {
      return result.message;
    }
  }
}
