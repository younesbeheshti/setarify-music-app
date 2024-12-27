import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/bloc/favorite_button_state.dart';
import 'package:spotify_flutter_apk/domain/usecases/song/add_or_remove_favorite_song.dart';

import '../../service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async {
    var result =
        await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songId);

    result.fold(
      (l) {},
      (isFavorite) {
        emit(
          FavoriteButtonUpdated(
            isFavorite: isFavorite,
          ),
        );
      },
    );
  }
}
