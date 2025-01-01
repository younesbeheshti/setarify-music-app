import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/get_user_favorite_song.dart';
import 'package:spotify_flutter_apk/presentation/profile/bloc/favorite_songs_state.dart';

import '../../../service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetUserFavoriteSongUseCase>().call();

    result.fold(
      (l) {
        emit(FavoriteSongsFailure());
      },
      (list) {
        favoriteSongs = list;
        print("len -> ${list.length}");
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      },
    );
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}
