import "dart:convert";

import "package:async_wallpaper/async_wallpaper.dart";
import "package:flutter_client/models/wallpaper_model.dart";
import "package:http/http.dart" as http;

class WallpaperService {
  final baseUrl = "http://192.168.56.1:5000/api/wall/";

  //search wallpapers
  Future<List<WallpaperModel>> searchWallpaper(String keyWord) async {
    try {
      final responses =
          await http.get(Uri.parse('${baseUrl}search?query=$keyWord'));

      List<dynamic> wallpapers = json.decode(responses.body)["wallpapers"];

      return wallpapers
          .map((wallpaper) => WallpaperModel.fromJson(wallpaper))
          .toList();
    } catch (err) {
      throw Exception('Failed to load wallpapers : $err');
    }
  }

  //get random wallpapers
  Future<List<WallpaperModel>> randomWallpaper() async {
    try {
      final responses =
          await http.get(Uri.parse('http://192.168.56.1:5000/api/wall/random'));

      List<dynamic> wallpapers = json.decode(responses.body)["wallpapers"];

      return wallpapers
          .map((wallpaper) => WallpaperModel.fromJson(wallpaper))
          .toList();
    } catch (err) {
      throw Exception('Failed to load wallpapers : $err');
    }
  }

  //set wallapaper as device wallapper
  Future<bool> setWallpaper(
    String imageUrl,
  ) async {
    try {
      return await AsyncWallpaper.setWallpaper(
        url: imageUrl,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
        goToHome: true,
      );
    } catch (err) {
      print("Failed to set wallpaper: $err");
      throw Exception('Failed to load wallpapers : $err');
    }
  }
}
