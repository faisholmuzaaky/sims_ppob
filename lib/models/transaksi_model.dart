part of 'models.dart';

class TransaksiModel {
  String? invoiceNumber;
  String? transactionType;
  String? description;
  num? totalAmount;
  String? createdOn;

  TransaksiModel({
    this.invoiceNumber,
    this.transactionType,
    this.description,
    this.totalAmount,
    this.createdOn,
  });

  factory TransaksiModel.fromJson(Map<String, dynamic> json) => TransaksiModel(
        invoiceNumber: json['invoice_number'],
        transactionType: json['transaction_type'],
        description: json['description'],
        totalAmount: json['total_amount'],
        createdOn: json['created_on'],
      );
}
