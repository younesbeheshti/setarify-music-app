import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

import '../../models/song/song_model.dart';

abstract class SongService {
  Future<Either> getNewsSongs();
}

class SongServiceImpl implements SongService {
  @override
  Future<Either> getNewsSongs() async {
    try {

      // TODO: implement getNewsSongs
      List <SongEntity> songList = [];


      // var data = await FirebaseFireStore.instance.collection("songs").orderBy("releaseDate", descenting: true).get();
      //
      // for (var element in data.docs) {
      //   var song = SongModel.fromJson(element.data());
      //
      //   songList.add(song.toEntity());
      // }

      return Right(songList);
    }catch (e) {
      return Left(e.toString());
    }

  }

}