class SongEntity {
  final String title;
  final String slug;
  final String genre;
  final List artist;
  String?  release_date;
  final Map album;
  String? cover;
  final bool liked;
  String? songUrl;

  // final String title;
  // final String artist;
  // final num duration;
  // final Timestamp releaseDate;
  // final bool isFavorite;
  // final String songId;

  // SongEntity({
  //   required this.title,
  //   required this.artist,
  //   required this.duration,
  //   required this.releaseDate,
  //   required this.isFavorite
  //   required this.songId
  // });

  SongEntity({
    required this.title,
    required this.slug,
    required this.genre,
    required this.artist,
    this.release_date,
    required this.album,
    this.cover,
    required this.liked,
    this.songUrl,
  });
}
