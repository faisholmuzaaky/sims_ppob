part of 'services.dart';

class AuthService {
  Future<ApiReturnValue<String>> register({
    required UserModel user,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/registration');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode({
      "email": user.email!.toLowerCase(),
      "first_name": user.firstName,
      "last_name": user.lastName,
      "password": password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['message'];
      return ApiReturnValue(value: data);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }

  Future<ApiReturnValue<UserModel>> profile({
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/profile');

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
      final user = UserModel.fromJson(data);
      return ApiReturnValue(value: user);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }

  Future<ApiReturnValue<String>> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/login');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode({
      "email": email,
      "password": password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var token = jsonDecode(response.body)['data']['token'];
      return ApiReturnValue(value: token);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }

  Future<ApiReturnValue<UserModel>> update({
    required UserModel user,
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/profile/update');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var body = jsonEncode({
      "first_name": user.firstName,
      "last_name": user.lastName,
    });

    var response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      final user = UserModel.fromJson(data);
      return ApiReturnValue(value: user);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }

  Future<ApiReturnValue<UserModel>> image({
    required File image,
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/profile/image');

    var headers = {
      'accept': 'multipart/form-data',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
      'PUT',
      url,
    );
    request.headers.addAll(headers);

    request.files.add(
      http.MultipartFile(
        'file[]',
        image.readAsBytes().asStream(),
        image.lengthSync(),
      ),
    );

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      final user = UserModel.fromJson(data);
      return ApiReturnValue(value: user);
    } else {
      var message = jsonDecode(response.body)['message'];
      return ApiReturnValue(message: message);
    }
  }
}
