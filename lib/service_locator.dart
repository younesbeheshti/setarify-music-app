import 'package:get_it/get_it.dart';
import 'package:spotify_flutter_apk/data/repository/song/song_repository_impl.dart';
import 'package:spotify_flutter_apk/data/sources/auth/auth_backend_service.dart';
import 'package:spotify_flutter_apk/domain/repository/auth/auth.dart';
import 'package:spotify_flutter_apk/domain/repository/music/song_repo.dart';
import 'package:spotify_flutter_apk/domain/usecases/auth/sign_up.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/is_favorite_song.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/sources/songs/song_backed_service.dart';
import 'domain/usecases/auth/sign_in.dart';
import 'domain/usecases/song/get_play_list.dart';

final sl = GetIt.instance;


Future<void> initializeDependencies() async {

  sl.registerSingleton<AuthBackendService>(
    AuthBackendServiceImpl(),
  );

  sl.registerSingleton<SongService>(
    SongServiceImpl(),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<SongsRepository>(
    SongRepositoryImpl(),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(),
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(),
  );

  sl.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase(),
  );

  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase(),
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase(),
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase(),
  );

}