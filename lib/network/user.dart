// import 'dart:convert';
//
// import 'package:crud_flutter/model/user_model.dart';
// import 'package:dio/dio.dart';
// class UserRequestX{
//   static const String url = "http://192.168.1.37:3000/user";
//   static List<UserModel> parseResponse(String responseBody) {
//     var list = json.decode(responseBody) as List<dynamic>;
//     List<UserModel> result =
//     list.map((model) => UserModel.fromJson(model)).toList();
//     return result;
//   }
// }
//
//
//
// void getHttp() async {
//   try {
//     var response = await Dio().get('http://192.168.1.37:3000/user');
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }