class WallpaperModel {
  final String id;
  final String discription;
  final String url;
  final String cretor;

  WallpaperModel(
      {required this.id,
      required this.discription,
      required this.url,
      required this.cretor});

  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
      id: json['id'],
      url: json['url'],
      discription: json['description'] ?? 'No description',
      cretor: json['photographer'] ?? 'Unknown photographer',
    );
  }
}
