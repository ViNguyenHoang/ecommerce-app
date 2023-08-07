import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api.dart';
import 'package:ecommerce_app/data/models/cart_item_model.dart';

class CartRepository {
  final Api _api = Api();

  Future<List<CartItemModel>> getCartForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/cart/$userId");

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CartItemModel>> addToCart(
      CartItemModel cartItem, String userId) async {
    try {
      Map<String, dynamic> data = cartItem.toJson();
      data["user"] = userId;

      Response response =
          await _api.sendRequest.post("/cart", data: jsonEncode(data));

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CartItemModel>> removeFromCart(
      String productId, String userId) async {
    try {
      Map<String, dynamic> data = {"product": productId, "user": userId};

      Response response =
          await _api.sendRequest.delete("/cart", data: jsonEncode(data));

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data["items"] as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
