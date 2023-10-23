import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sims_ppob/models/models.dart';
import 'package:sims_ppob/services/services.dart';
import 'package:sims_ppob/utilities/utilities.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  String? _token;

  UserModel get user => _user!;

  String get token => _token!;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  set token(String token) {
    _token = token;
    notifyListeners();
  }

  Future<dynamic> register({
    required UserModel user,
    required String password,
  }) async {
    ApiReturnValue<String> result = await AuthService().register(
      user: user,
      password: password,
    );

    if (result.value != null) {
      return true;
    } else {
      return result.message;
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    ApiReturnValue<String> result = await AuthService().login(
      email: email,
      password: password,
    );

    if (result.value != null) {
      _token = result.value;
      Functions().saveToken(token: result.value!);
      ApiReturnValue<UserModel> user =
          await AuthService().profile(token: token);
      if (user.value != null) {
        _user = user.value!;
        return _user!;
      } else {
        return user.message;
      }
    } else {
      return result.message;
    }
  }

  Future<bool> cekLogin() async {
    String? token = Functions().getToken();
    if (token != null) {
      _token = token;
      ApiReturnValue<UserModel> user =
          await AuthService().profile(token: token);
      if (user.value != null) {
        _user = user.value!;
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<dynamic> update({
    required UserModel user,
  }) async {
    ApiReturnValue<UserModel> result = await AuthService().update(
      user: user,
      token: token,
    );
    if (result.value != null) {
      _user = result.value!;
      return true;
    } else {
      return result.message;
    }
  }

  Future<dynamic> image({
    required File image,
  }) async {
    ApiReturnValue<UserModel> result = await AuthService().image(
      image: image,
      token: token,
    );
    if (result.value != null) {
      _user = result.value!;
      return true;
    } else {
      return result.message;
    }
  }
}
