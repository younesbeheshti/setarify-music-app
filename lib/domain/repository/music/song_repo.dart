import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

abstract class SongsRepository {
  Future<Either> getNewsSongs();
  //this is not play list (it is actually all music in the db)(there is not logic for play list for your own)
  Future<Either> getPlayList();

  Future<Either> addOrRemoveFavoriteSongs(SongEntity songEntity);

  Future<bool> isFavoriteSong(String songId);

  Future<Either> getUserFavoriteSongs();

  Future<String> getSongUrl(String song_slug);
}
