import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/music/song_repo.dart';

class AddOrRemoveFavoriteSongUseCase extends UseCase<Either, SongEntity> {
  @override
  Future<Either> call({SongEntity? params}) {
    return sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }



}