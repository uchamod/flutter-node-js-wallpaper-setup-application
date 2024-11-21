import 'package:flutter_client/main.dart';
import 'package:flutter_client/models/wallpaper_model.dart';
import 'package:flutter_client/pages/favourite.dart';
import 'package:flutter_client/pages/homepage.dart';
import 'package:flutter_client/pages/login.dart';
import 'package:flutter_client/pages/register.dart';
import 'package:flutter_client/pages/single_wallpaper.dart';
import 'package:flutter_client/router/router_names.dart';
import 'package:go_router/go_router.dart';

class Routers {
  final GoRouter router = GoRouter(
    initialLocation: '/', // Set the initial route
    routes: [
      GoRoute(
        path: '/home',
        name: RouterNames.home,
        builder: (context, state) {
          return const Homepage();
        },
      ),
      GoRoute(
        path: '/',
        name: RouterNames.authCheck,
        builder: (context, state) {
          return const CheckAuthStatus();
        },
      ),
      GoRoute(
        path: '/register',
        name: RouterNames.register,
        builder: (context, state) {
          return const Register();
        },
      ),
      GoRoute(
        path: '/login',
        name: RouterNames.login,
        builder: (context, state) {
          return const Login();
        },
      ),
      GoRoute(
        path: '/fav',
        name: RouterNames.favourite,
        builder: (context, state) {
          return const Favourite();
        },
      ),
      GoRoute(
        path: '/singleWallpaper',
        name: RouterNames.singleWallpaper,
        builder: (context, state) {
          final wallpaper = state.extra as WallpaperModel;
          return SingleWallpaper(
            wallapaper: wallpaper,
          );
        },
      ),
    ],
  );
}
