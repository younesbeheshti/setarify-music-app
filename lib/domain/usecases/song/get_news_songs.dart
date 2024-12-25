import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/data/repository/song/song_repository_impl.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class GetNewsSongsUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepositoryImpl>().getNewsSongs();
  }
  

}