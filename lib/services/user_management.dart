import 'package:api_test/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserManagementService {
  String get _baseUrl => baseUrl;

  //login
  Future<int> login(String email, String password) async {
    try {
      Uri url = Uri.parse("$_baseUrl/login");
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      return response.statusCode;
    } catch (e) {
      debugPrint("User Managment || login failed $e");
      return 500;
    }
  }

  //register
  Future<int> registerUser(Map data, String email, String password) async {
    try {
      Uri regUrl = Uri.parse("$_baseUrl/signup");
      Uri regUserUrl = Uri.parse("$_baseUrl/create-user");
      return await http.post(regUrl, body: {
        "email": email,
        "password": password,
      }).then((value) async {
        if (value.statusCode != 500) {
          return await http
              .post(
            regUserUrl,
            body: data,
          )
              .then((value) {
            if (value.statusCode != 500) {
              return 200;
            } else {
              return 500;
            }
          });
        } else {
          return value.statusCode;
        }
      });
    } catch (e) {
      debugPrint("regisster user failed $e");
      return 500;
    }
  }

  //block-unblock user
  Future<int> blockUnblockUser(String uid) async {
    try {
      //Uri url = Uri.parse("$_baseUrl/")
      return 10;
    } catch (e) {
      debugPrint("Block user failed $e");
      return 500;
    }
  }

  //get user by uname
  Future<String> getUserDataByUserName(String username) async {
    try {
      Uri url = Uri.parse("$_baseUrl/get-user/$username");
      return await http.get(url).then((value) => value.body);
    } catch (e) {
      return "$e";
    }
  }
}
