import 'package:flutter/material.dart';
import 'package:flutter_client/util/constants.dart';

class WallPage extends StatefulWidget {
  const WallPage({super.key});

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
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
