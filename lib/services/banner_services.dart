part of 'services.dart';

class BannerService {
  Future<ApiReturnValue<List<BannerModel>>> banner({
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/banner');

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
      List<BannerModel> banner =
          data.map((item) => BannerModel.fromJson(item)).toList();
      return ApiReturnValue(value: banner);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }
}
