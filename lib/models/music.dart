class Music{
  final int id;
  final String title;
  final String artist;
  final String category;
  final String asset;
  final int trackDuration;
  bool favorite;
  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.category,
    required this.asset,
    required this.trackDuration,
    required this.favorite
  });

  @override
  String toString() {
    return 'Music{title: $title, artist: $artist, category: $category, asset: $asset, trackDuration: $trackDuration}';
  }
}