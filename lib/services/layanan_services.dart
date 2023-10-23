part of 'services.dart';

class LayananService {
  Future<ApiReturnValue<List<LayananModel>>> layanan({
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/services');

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
      List data = jsonDecode(response.body)['data'];
      List<LayananModel> layanan =
          data.map((item) => LayananModel.fromJson(item)).toList();
      return ApiReturnValue(value: layanan);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }
}
