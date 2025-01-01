import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/music/song_repo.dart';

class GetUserFavoriteSongUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async{
    return await sl<SongsRepository>().getUserFavoriteSongs();
  }




}