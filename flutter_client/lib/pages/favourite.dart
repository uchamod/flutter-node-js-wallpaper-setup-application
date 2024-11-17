import 'package:flutter/material.dart';
import 'package:flutter_client/util/constants.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
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
