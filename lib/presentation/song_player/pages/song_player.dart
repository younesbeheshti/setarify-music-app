import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/widgets/appbar/app_bar.dart';
import 'package:spotify_flutter_apk/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify_flutter_apk/core/configs/assets/app_images.dart';
import 'package:spotify_flutter_apk/core/configs/theme/app_colors.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';
import 'package:spotify_flutter_apk/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_flutter_apk/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  //TODO : get songEntity
  // final SongEntity songEntity;
  // SongPlayerPage({super.key, required this.songEntity});

  SongPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          "Now Playing",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert_outlined),
        ),
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(
            //TODO : url for the song duration there is problem with link ...
            // AppURLs.songUrl + songEntity.image + ' - ' + songEntity.title + 'mp3?' + AppURLs.mediaAlt
            'https://github.com/rafaelreis-hotmart/Audio-Sample-files/blob/master/sample.mp3?raw=true'),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Column(
            children: [
              _songCover(context),
              SizedBox(
                height: 20,
              ),
              _songDetail(),
              SizedBox(
                height: 30,
              ),
              _songPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: Image.asset(AppImages.musicCover).image,
          fit: BoxFit.cover,
          //TODO : network image from backend
          // image: NetworkImage(AppURLs.imageUrl + songEntity.image + ' - ' + songEntity.title + 'jpg?' + AppURLs.mediaAlt),
        ),
      ),
    );
  }

  //TODO : songs detail
  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'music title',
              // songEntity.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'music artist',
              // songEntity.artist,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xffCC6C6C6),
              ),
            )
          ],
        ),
        FavoriteButton(),
        //TODO : favorite button
        // FavoriteButton(songEntity: songEntity),
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return CircularProgressIndicator();
        }

        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songPosition),
                  ),
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songDuration),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
