import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

class SongModel {
  String? title;
  String? artist;
  String? album;
  String? imageUrl;
  String? songUrl;
  bool? isFavorite;
  String? songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.album,
    required this.imageUrl,
    required this.songUrl,
    required this.isFavorite,
    required this.songId
  });


  SongModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    artist = json['artist'];
    album = json['album'];
    imageUrl = json['imageUrl'];
    songUrl = json['songUrl'];
  }

  // String? title;
  // String? artist;
  // num? duration;
  // Timestamp? releaseDate;
  //
  // SongModel({
  //   required this.title,
  //   required this.artist,
  //   required this.duration,
  //   required this.releaseDate,
  // });
  //
  // SongModel.fromJson(Map<String, dynamic> json) {
  //   title = json['title'];
  //   artist = json['artist'];
  //   duration = json['duration'];
  //   releaseDate = json['releaseDate'];
  // }
}

extension SongModelExt on SongModel {

  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      album: album!,
      imageUrl: imageUrl!,
      songUrl: songUrl!,
      isFavorite: isFavorite!,
      songId: songId!,
    );
  }
}


// extension SongEntityExt on SongEntity {
//   SongModel toModel() {
//     return SongModel(
//       title: title!,
//       artist: artist!,
//       duration: duration!,
//       releaseDate: releaseDate!,
//     );
//   }
// }
