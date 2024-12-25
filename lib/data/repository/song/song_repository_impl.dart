import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/repository/music/song_repo.dart';

import '../../../service_locator.dart';
import '../../sources/songs/song_backed_service.dart';

class SongRepositoryImpl implements SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongService>().getNewsSongs();
  }

}