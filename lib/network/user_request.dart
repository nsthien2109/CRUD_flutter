import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_flutter/model/user_model.dart';

class UserRequest {
  static const String url = "http://192.168.1.37:8080/user";

  static List<UserModel> parseResponse(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<UserModel> result =
    list.map((model) => UserModel.fromJson(model)).toList();
    return result;
  }

  static Future<List<UserModel>> fetchUsers({int page = 1}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute(parseResponse, response.body);
    } else if (response.statusCode == 200) {
      throw Exception("Not Found");
    } else {
      throw Exception("Some thing went wrong");
    }
  }

  static Future<UserModel> addUser(String userName,
      String userPhone) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userName,
        'userPhone': userPhone
      }),
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }

  static Future<UserModel> deleteUser(int id) async {
    final http.Response response = await http.delete(
      Uri.parse(url+'/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete user.');
    }
  }

  static Future<UserModel> updateUser(int id,String userName, String userPhone) async {
    final response = await http.put(
      Uri.parse(url+'/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userName,
        'userPhone' : userPhone
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user.');
    }
  }

}