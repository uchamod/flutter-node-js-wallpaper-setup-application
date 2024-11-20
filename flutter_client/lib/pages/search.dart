import 'package:flutter/material.dart';
import 'package:flutter_client/models/wallpaper_model.dart';
import 'package:flutter_client/services/wallpaper_service.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:flutter_client/widget/reusable_textfiled.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<WallpaperModel> _wallpapers = [];
  final WallpaperService _wallpaperService = WallpaperService();
  //search wallpapers
  void _searchWalls() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<WallpaperModel> wallpapers =
          await _wallpaperService.searchWallpaper(_searchController.text);
      setState(() {
        _wallpapers = wallpapers;
      });
    } catch (err) {
      print("Error fetching wallpapers: $err");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0e0f0f),
          elevation: 0.0, // Remove shadow
          //search bar
          title: ReusableTextfiled(
            controller: _searchController,
            inputType: TextInputType.name,
            inputAction: TextInputAction.done,
            isShow: false,
            hint: "Search for wallpapers",
            onSubmit: (String _) {
              _searchWalls();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: secondoryColor,
                          ),
                        ),
                      )
                    : _wallpapers.isNotEmpty
                        ? StaggeredGrid.count(
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            axisDirection: AxisDirection.down,
                            crossAxisCount: 2,
                            children: _wallpapers.map((wallpaper) {
                              //wallapaper
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                        : const Center(
                            child: SizedBox(),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
