import 'package:flutter/material.dart';
import 'package:flutter_client/router/router_names.dart';
import 'package:flutter_client/services/favourite_services.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final FavouriteServices _favouriteServices = FavouriteServices();
  bool _isLoading = false;
  List<dynamic> _favWallpapers = [];
  void _getFav() async {
    try {
      List<dynamic> favWallpapers = await _favouriteServices.getFromFav();
      setState(() {
        _favWallpapers = favWallpapers;
      });
    } catch (err) {
      throw Exception('Failed to add to favorites');
    }
  }

  @override
  void initState() {
    _getFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0e0f0f),
          title: const Text(
            "favourite",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: secondoryColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              StaggeredGrid.count(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                axisDirection: AxisDirection.down,
                crossAxisCount: 2,
                children: _favWallpapers.map((wallpaper) {
                  //wallapaper
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).goNamed(RouterNames.singleWallpaper,
                          extra: wallpaper);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              wallpaper.url,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            wallpaper.discription,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: secondoryColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
