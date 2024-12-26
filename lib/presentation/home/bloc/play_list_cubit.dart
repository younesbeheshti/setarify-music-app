import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_flutter_apk/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_flutter_apk/service_locator.dart';

import '../../../domain/usecases/song/get_play_list.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold((l) {
      emit(
        PlayListLoadFailure(),
      );
    }, (data) {
      emit(
        PlayListLoaded(songs: data),
      );
    });
  }
}
