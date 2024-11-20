import 'package:flutter/material.dart';
import 'package:flutter_client/router/router_names.dart';
import 'package:flutter_client/services/auth_services.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:go_router/go_router.dart';

class WallPage extends StatefulWidget {
  const WallPage({super.key});

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  final AuthServices _authServices = AuthServices();

  void _logout() {
    _authServices.logOut();
    GoRouter.of(context).goNamed(RouterNames.login);
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
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
