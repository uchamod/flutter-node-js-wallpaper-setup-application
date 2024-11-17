import 'package:flutter/material.dart';
import 'package:flutter_client/util/constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "360 Wallpaper",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: secondoryColor),
          ),
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
