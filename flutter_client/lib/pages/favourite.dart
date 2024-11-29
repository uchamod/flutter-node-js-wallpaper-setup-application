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
  @override
  void initState() {
    super.initState();
    _getFav();
  }

  //get saved wallpapers
  Future<void> _getFav() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<dynamic> favWallpapers = await _favouriteServices.getFromFav();
      setState(() {
        _favWallpapers = favWallpapers;
      });
    } catch (err) {
      throw Exception('Failed to get from favorites ${err}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: secondoryColor,
                ),
              )
            : _favWallpapers.isEmpty
                ? const Center(
                    child: Text(
                    "No Saved Wallpapers",
                    style: TextStyle(
                        color: secondoryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ))
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
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
                                GoRouter.of(context).goNamed(
                                    RouterNames.singleFavouriteWallpaper,
                                    extra: wallpaper);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        wallpaper["url"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      wallpaper["description"],
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
