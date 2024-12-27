import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/music/song_repo.dart';

class AddOrRemoveFavoriteSongUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) {
    return sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }



}