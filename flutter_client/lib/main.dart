import 'package:flutter/material.dart';
import 'package:flutter_client/pages/homepage.dart';
import 'package:flutter_client/pages/login.dart';
import 'package:flutter_client/router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "wallpaper-setup app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff0e0f0f),
          fontFamily: GoogleFonts.poppins().fontFamily,
          brightness: Brightness.dark),
      routerConfig: Routers().router,
    );
  }
}

//check user  auth states
class CheckAuthStatus extends StatefulWidget {
  const CheckAuthStatus({super.key});

  @override
  _CheckAuthStatusState createState() => _CheckAuthStatusState();
}

class _CheckAuthStatusState extends State<CheckAuthStatus> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    setState(() {
      isLoggedIn = token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const Homepage() : const Login();
  }
}
