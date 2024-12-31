import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_flutter_apk/data/sources/songs/song_backed_service.dart';
import 'package:spotify_flutter_apk/domain/repository/music/song_repo.dart';
import 'package:spotify_flutter_apk/presentation/song_player/bloc/song_player_state.dart';

import '../../../service_locator.dart';

class SongPlayerCubit extends Cubit<SongPlayerState>{

  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {

    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }


  void updateSongPlayer(){
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    final fileUrl = sl<SongsRepository>().getSongUrl(url);

    try{
      await audioPlayer.setUrl(await fileUrl);
      emit(SongPlayerLoaded());
    }catch(e) {
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() async {
    audioPlayer.dispose();
    return super.close();
  }

}