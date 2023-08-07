import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/models/user_model.dart';

import '../../core/api.dart';

class UserRepository {
  final Api _api = Api();

  Future<UserModel> signup(
      {required String email,
      required String password,
      required String phone}) async {
    try {
      Response response = await _api.sendRequest.post("/user/signUp",
          data: jsonEncode(
              {"email": email, "password": password, "phoneNumber": phone}));

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> signin(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/signIn",
          data: jsonEncode({"email": email, "password": password}));

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
