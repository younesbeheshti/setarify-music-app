import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/bloc/favorite_button_state.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/add_or_remove_favorite_song.dart';

import '../../service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(SongEntity songEntity) async {
    var result =
        await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songEntity);

    result.fold(
      (l) {},
      (isFavorite) {
        emit(
          FavoriteButtonUpdated(
            isFavorite: songEntity.liked!,
          ),
        );
      },
    );
  }
}
