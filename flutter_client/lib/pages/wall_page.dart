import 'package:flutter/material.dart';
import 'package:flutter_client/models/wallpaper_model.dart';
import 'package:flutter_client/router/router_names.dart';
import 'package:flutter_client/services/auth_services.dart';
import 'package:flutter_client/services/wallpaper_service.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class WallPage extends StatefulWidget {
  const WallPage({super.key});

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  final AuthServices _authServices = AuthServices();
  final WallpaperService _wallpaperService = WallpaperService();
  List<WallpaperModel> _wallpapers = [];

  void _getWalls() async {
    try {
      List<WallpaperModel> randomWallpapers =
          await _wallpaperService.randomWallpaper();
      setState(() {
        _wallpapers = [...randomWallpapers];
      });
    } catch (err) {
      print("Error random fetching wallpapers: $err");
    }
  }

  void _logout() {
    _authServices.logOut();
    GoRouter.of(context).goNamed(RouterNames.login);
  }

  @override
  void initState() {
    _getWalls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0e0f0f),
          title: const Text(
            "360°",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: secondoryColor),
          ),
          actions: [
            IconButton(
                onPressed: _logout,
                icon: const Icon(
                  Icons.logout_sharp,
                  size: 24,
                  color: secondoryColor,
                ))
          ],
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
                children: _wallpapers.map((wallpaper) {
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
