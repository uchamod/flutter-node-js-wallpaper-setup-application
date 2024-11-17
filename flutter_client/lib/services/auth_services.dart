import "dart:convert";

import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

class AuthServices {
  final baseUrl = "http://192.168.251.148:5000/api/auth";

//register user
  Future<Map<String, dynamic>> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {"name": name, "email": email, "password": password},
        ),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register-from client side');
      }
    } catch (err) {
      throw Exception('Failed to register-from client side ${err}');
    }
  }

  //login user
  Future<Map<String, dynamic>> loginUser(
      {required String email, required String password}) async {
    try {
      //login request
      final response = await http.post(Uri.parse("$baseUrl/login"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"email": email, "password": password}));
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body);
        //store token in shared perferences
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", user["genToken"]);
        print(user["genToken"]);
        return user;
      } else {
        print("fail to fetch data");
        throw Exception('Failed to login-from client side');
      }
    } catch (err) {
      print("something went wrong");
      throw Exception('Failed to login-from client side ${err}');
    }
  }

  //get token
  Future<String?> getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  //log out user
  Future<void> logOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
    print("log out");
  }
}
