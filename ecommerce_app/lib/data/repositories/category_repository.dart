import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/models/category_model.dart';
import 'package:ecommerce_app/data/models/user_model.dart';

import '../../core/api.dart';

class CategoryRepository {
  final Api _api = Api();

  Future<UserModel> createCategory(
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

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> getCategoryById(
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
