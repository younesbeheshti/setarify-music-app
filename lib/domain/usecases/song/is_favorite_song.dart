import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/music/song_repo.dart';

class IsFavoriteSongUseCase extends UseCase<bool, String> {
  @override
  Future<bool> call({String? params})async {
    return sl<SongsRepository>().isFavoriteSong(params!);
  }



}