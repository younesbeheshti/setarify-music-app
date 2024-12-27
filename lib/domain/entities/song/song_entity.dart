class SongEntity {
  final String title;
  final String artist;
  final String album;
  final String imageUrl;
  final String songUrl;
  final bool isFavorite;
  final String songId;

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
    required this.artist,
    required this.album,
    required this.imageUrl,
    required this.songUrl,
    required this.isFavorite,
    required this.songId
  });


}
