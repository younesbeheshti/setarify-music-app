import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/is_favorite_song.dart';

import '../../models/song/song_model.dart';

abstract class SongService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
}

class SongServiceImpl implements SongService {
  @override
  Future<Either> getNewsSongs() async {
    try {

      // TODO: implement getNewsSongs
      List <SongEntity> songList = [];


      // var data = await FirebaseFireStore.instance.collection("songs").orderBy("releaseDate", descenting: true).limit(3).get();
      //
      // for (var element in data.docs) {
      //   var song = SongModel.fromJson(element.data());
      //
      // TODO: implement isFavoriteSong
      //   bool isFavorite = await sl<IsFavoriteSongUseCase>().call(params: element.reference.id);
      //   songModel.isFavorite = isFavorite;
      //   songModel.songId = element.reference.id;

      //   songList.add(song.toEntity());
      // }

      return Right(songList);
    }catch (e) {
      return Left(e.toString());
    }

  }

  @override
  Future<Either> getPlayList() async {
    try {

      // TODO: implement getNewsSongs
      List <SongEntity> songList = [];


      // var data = await FirebaseFireStore.instance.collection("songs").orderBy("releaseDate", descenting: true).get();
      //
      // for (var element in data.docs) {
      //   var songModel = SongModel.fromJson(element.data());
      //
      // TODO: implement isFavoriteSong
      //   bool isFavorite = await sl<IsFavoriteSongUseCase>().call(params: element.reference.id);
      //   songModel.isFavorite = isFavorite;
      //   songModel.songId = element.reference.id;

      //   songList.add(song.toEntity());
      // }

      return Right(songList);
    }catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) {
    // TODO: implement addOrRemoveFavoriteSongs
    throw UnimplementedError();
  }

  @override
  Future<bool> isFavoriteSong(String songId) {
    // TODO: implement isFavoriteSong
    throw UnimplementedError();
  }

}