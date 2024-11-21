import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/models/wallpaper_model.dart';
import 'package:flutter_client/services/wallpaper_service.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:flutter_client/widget/reusable_button.dart';

class SingleWallpaper extends StatefulWidget {
  final WallpaperModel wallapaper;
  const SingleWallpaper({super.key, required this.wallapaper});

  @override
  State<SingleWallpaper> createState() => _SingleWallpaperState();
}

class _SingleWallpaperState extends State<SingleWallpaper> {
  bool _isLoading = false;
  final WallpaperService _wallpaperService = WallpaperService();
  //set as wallapper in selected wallapper
  Future<void> _setWallpaper(String url) async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool result = await _wallpaperService.setWallpaper(url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            result ? 'Wallpaper set successfully!' : 'Failed to set wallpaper.',
            style: const TextStyle(color: secondoryColor),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      // Rebuild the UI after setting wallpaper
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Failed to set wallpaper: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: primaryColor,
          content: Text('Failed to set wallpaper. Please try again.',
              style: TextStyle(color: secondoryColor)),
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.wallapaper.url,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: gap,
            ),
            //button group

            //set as wallpaper
            GestureDetector(
                onTap: () {
                  _setWallpaper(widget.wallapaper.url);
                },
                child: const ReusableButton(
                    lable: "Set as Wallpaper", isLoad: false)),
            SizedBox(
              height: gap,
            ),
            //save as favourite
            const ReusableButton(lable: "Save as favourite", isLoad: false)
          ],
        ),
      ),
    );
  }
}
