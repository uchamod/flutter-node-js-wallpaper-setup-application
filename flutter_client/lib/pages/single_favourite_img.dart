import 'package:flutter/material.dart';
import 'package:flutter_client/models/wallpaper_model.dart';
import 'package:flutter_client/services/favourite_services.dart';
import 'package:flutter_client/services/wallpaper_service.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:flutter_client/widget/reusable_button.dart';

class SingleFavouriteImg extends StatefulWidget {
  final WallpaperModel wallapaper;
  const SingleFavouriteImg({super.key, required this.wallapaper});

  @override
  State<SingleFavouriteImg> createState() => _SingleFavouriteImgState();
}

class _SingleFavouriteImgState extends State<SingleFavouriteImg> {
  bool _isLoading = false;
  final WallpaperService _wallpaperService = WallpaperService();
  final FavouriteServices _favouriteServices = FavouriteServices();
  //set as wallaper
  Future<void> _setWallpaper(String url) async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool result = await _wallpaperService.setWallpaper(url);
      Navigator.pop(context);
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

//remove from wallpaper
  void _removeFromFav(String id) async {
    try {
      await _favouriteServices.removeFromFav(id);
      Navigator.pop(context);
    } catch (err) {
      print("Failed to set wallpaper: $err");
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
                child: ReusableButton(
                    lable: "Set as Wallpaper", isLoad: _isLoading)),
            SizedBox(
              height: gap,
            ),
            //save as favourite
            GestureDetector(
                onTap: () {
                  _removeFromFav(widget.wallapaper.id);
                },
                child: const ReusableButton(
                    lable: "Remove from favourites", isLoad: false))
          ],
        ),
      ),
    );
  }
}
