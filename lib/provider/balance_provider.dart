import 'package:flutter/material.dart';
import 'package:sims_ppob/models/models.dart';
import 'package:sims_ppob/services/services.dart';

class BalanceProvider with ChangeNotifier {
  BalanceModel? _balance;

  BalanceModel get balance => _balance!;

  bool isBalance = false;

  bool get visibility => isBalance;

  set showBalance(bool show) {
    isBalance = show;
    notifyListeners();
  }

  Future<dynamic> getBalance({
    required String token,
  }) async {
    ApiReturnValue<BalanceModel> result = await BalanceService().balance(
      token: token,
    );

    if (result.value != null) {
      _balance = result.value;
      return result.value;
    } else {
      return result.message;
    }
  }

  Future<dynamic> topUp({
    required String token,
    required num nominal,
  }) async {
    ApiReturnValue<BalanceModel> result = await BalanceService().topUp(
      token: token,
      nominal: nominal,
    );

    if (result.value != null) {
      _balance = result.value;
      return true;
    } else {
      return result.message;
    }
  }

  Future<dynamic> bayar({
    required String token,
    required LayananModel layanan,
  }) async {
    ApiReturnValue<bool> result = await BalanceService().transaction(
      token: token,
      layanan: layanan,
    );

    if (result.value != null) {
      _balance!.balance = _balance!.balance! - layanan.serviceTarif!;
      return true;
    } else {
      return result.message;
    }
  }
}
