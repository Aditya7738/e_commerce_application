import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce_application/src/model/ProductsModel.dart';

import 'api_response.dart';
import 'package:http/http.dart' as http;

class ApiHelper{


  static final ApiHelper _instance = ApiHelper
      ._internal(); // if we add _ before var then it become private
  factory ApiHelper() => _instance;

  ApiHelper._internal();

  final Dio _dio = Dio(BaseOptions(
    contentType: 'application/json',
    baseUrl: 'https://fakestoreapi.com/products/',
    connectTimeout: Duration(minutes: 2),
    receiveTimeout: Duration(minutes: 2),
  ));

  // Future<List<dynamic>?> getRequest() async{
  //   final url = "https://fakestoreapi.com/products/";
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   if(response.statusCode == 200){
  //     final json = jsonDecode(response.body) as Map;
  //     final result = json['products'] as List;
  //     return result;
  //   }else{
  //
  //   }
  //   print(response.body);
  //   print(response.statusCode);
  // }

  Future<ProductsModel> makeGetRequest(String route) async {
    try {

      Response response = await _dio.get(route);

      return ProductsModel.fromJson(response.data);
    }
    catch (e) {
      return ProductsModel(error: "API error");
    }
  }
}