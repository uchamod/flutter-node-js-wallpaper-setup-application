import "dart:convert";

import "package:flutter_client/models/wallpaper_model.dart";
import "package:http/http.dart" as http;

class WallpaperService {
  final baseUrl = "http://10.10.2.79:5000/api/wall/search";

  Future<List<WallpaperModel>> searchWallpaper(String keyWord) async {
    try {
      final responses = await http.get(Uri.parse('$baseUrl?query=$keyWord'));

      List<dynamic> wallpapers = json.decode(responses.body)["wallpapers"];

      return wallpapers
          .map((wallpaper) => WallpaperModel.fromJson(wallpaper))
          .toList();
    } catch (err) {
      throw Exception('Failed to load wallpapers : $err');
    }
  }
}
