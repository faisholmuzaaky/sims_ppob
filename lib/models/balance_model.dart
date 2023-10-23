part of 'models.dart';

class BalanceModel {
  num? balance;

  BalanceModel({this.balance});

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      BalanceModel(balance: json['balance']);

  toJson() {
    return {
      'balance': balance,
    };
  }
}
