import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/data/sources/songs/song_backed_service.dart';
import 'package:spotify_flutter_apk/domain/repository/music/song_repo.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl implements SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongService>().addOrRemoveFavoriteSongs(songId);();
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await sl<SongService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() {
    // TODO: implement getUserFavoriteSongs
    throw UnimplementedError();
  }

  @override
  Future<String> getSongUrl(String song_slug) async{
    return await sl<SongService>().getSongUrl(song_slug);
  }

}