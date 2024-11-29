import 'package:flutter/material.dart';
import 'package:flutter_client/pages/favourite.dart';
import 'package:flutter_client/pages/search.dart';
import 'package:flutter_client/pages/wall_page.dart';
import 'package:flutter_client/util/constants.dart';

class Homepage extends StatefulWidget {
 int selectedIndex;
 Homepage({super.key, required this.selectedIndex});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> _pages = [];

  int _selectedIndex = 0;
  void toggleButton(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [const WallPage(), const Search(), const Favourite()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff0e0f0f),
          type: BottomNavigationBarType.shifting,
          currentIndex: widget.selectedIndex,
          elevation: 1,
          selectedItemColor: primaryColor,
          unselectedItemColor: secondoryColor,
          onTap: toggleButton,
          items: const [
            BottomNavigationBarItem(
                backgroundColor: const Color(0xff0e0f0f),
                label: "Home",
                icon: Icon(
                  Icons.home,
                  size: 24,
                )),
            BottomNavigationBarItem(
                backgroundColor: const Color(0xff0e0f0f),
                label: "Search",
                icon: Icon(
                  Icons.search,
                  size: 24,
                )),
            BottomNavigationBarItem(
                backgroundColor: const Color(0xff0e0f0f),
                label: "Favourite",
                icon: Icon(
                  Icons.favorite,
                  size: 24,
                )),
          ]),
    );
  }
}
