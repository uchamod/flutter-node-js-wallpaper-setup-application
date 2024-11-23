import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteServices {
  final baseUrl = "http://192.168.137.153:5000/api/fav/";

  //add to favourite
  Future<void> addToFav(
      String id, String url, String discription, String cretor) async {
    try {
      //get the token from shared preferences
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      String? token = _pref.getString("token");
      //post the data and get the response
      final response = await http.post(Uri.parse("$baseUrl/add"),
          headers: {
            'Content-Type': 'application/json',
            'auth-token': token!,
          },
          body: jsonEncode({
            'id': id,
            'url': url,
            'description': discription,
            'photographer': cretor,
          }));
      if (response.statusCode != 200) {
        throw Exception('Failed to add to favorites ${response.statusCode}');
      }
    } catch (err) {
      print('Error adding to favorites: $err');
      throw Exception('Failed to add to favorites');
    }
  }
  //remove from favourite

  Future<void> removeFromFav(String id) async {
    try {
//get the token from shared preferences
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      String? token = _pref.getString("token");

      final response = await http.post(Uri.parse("$baseUrl/remove"), headers: {
        'Content-Type': 'application/json',
        'auth-token': token!,
      }, body: {
        'id': id,
      });
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to remove from favorites ${response.statusCode}');
      }
    } catch (err) {
      print('Error removing favorites: $err');
      throw Exception('Failed to remove from favorites');
    }
  }

  //get from favourite
  Future<List<dynamic>> getFromFav() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? token = _pref.getString("token");
    //get favourtie wallapper
    final response = await http.get(
      Uri.parse("$baseUrl/getfav"),
      headers: {
        'Content-Type': 'application/json',
        'auth-token': token!,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error getting favorites: ${response.statusCode}');
      throw Exception('Failed to get from favorites');
    }
  }
}
