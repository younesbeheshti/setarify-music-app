import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

class SongModel {
  String? title;
  String? slug;
  String? genre;
  List? artist;
  String? release_date;
  Map? album;
  String? cover;
  bool? liked;
  String? songUrl;

  SongModel({
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

  SongModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    artist = json['artist'];
    album = json['album'];
    cover = json['cover'];
    slug = json['slug'];
    genre = json['genre'];
    release_date = json['release_date']?? "";
    liked = json['liked'];
  }
}

extension SongModelExt on SongModel {

  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      album: album!,
      cover: cover??"",
      slug: slug!,
      genre: genre!,
      release_date: release_date??"",
      liked: liked!,
      songUrl: songUrl?? "",
    );
  }
}