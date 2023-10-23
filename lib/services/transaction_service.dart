part of 'services.dart';

class TransaksiService {
  Future<ApiReturnValue<List<TransaksiModel>>> transaksi({
    required String token,
    int? offet,
    int? limit,
  }) async {
    var url = (offet == null && limit == null)
        ? Uri.parse('$baseUrl/transaction/history')
        : Uri.parse('$baseUrl/transaction/history?offset=$offet&limit=$limit');

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
      List data = jsonDecode(response.body)['data']['records'];
      List<TransaksiModel> transaksi =
          data.map((item) => TransaksiModel.fromJson(item)).toList();
      return ApiReturnValue(value: transaksi);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }
}
