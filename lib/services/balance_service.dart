part of 'services.dart';

class BalanceService {
  Future<ApiReturnValue<BalanceModel>> balance({
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/balance');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      BalanceModel balance = BalanceModel.fromJson(data);
      return ApiReturnValue(value: balance);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }

  Future<ApiReturnValue<BalanceModel>> topUp({
    required String token,
    required num nominal,
  }) async {
    var url = Uri.parse('$baseUrl/topup');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var data = jsonEncode({'top_up_amount': nominal});

    var response = await http.post(
      url,
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      BalanceModel balance = BalanceModel.fromJson(data);
      return ApiReturnValue(value: balance);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }

  Future<ApiReturnValue<bool>> transaction({
    required String token,
    required LayananModel layanan,
  }) async {
    var url = Uri.parse('$baseUrl/transaction');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var data = jsonEncode({"service_code": layanan.serviceCode});

    var response = await http.post(
      url,
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ApiReturnValue(value: true, message: data['message']);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }
}
