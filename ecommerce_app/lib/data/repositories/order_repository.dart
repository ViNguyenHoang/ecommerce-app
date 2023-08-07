import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api.dart';
import 'package:ecommerce_app/data/models/order_model.dart';

class OrderRepository {
  final Api _api = Api();

  Future<List<OrderModel>> getOrderForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/order/user/$userId");

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequest
          .post("/order", data: jsonEncode(orderModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return OrderModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
