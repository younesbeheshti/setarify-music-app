import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter_apk/core/configs/theme/app_colors.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';
import 'package:spotify_flutter_apk/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_flutter_apk/presentation/song_player/pages/song_player.dart';

import '../../../core/configs/assets/app_images.dart';
import '../bloc/news_songs_state.dart';

class NewsSongs extends StatefulWidget {
  NewsSongs({super.key});

  @override
  State<NewsSongs> createState() => _NewsSongsState();
}

class _NewsSongsState extends State<NewsSongs> {
  List songsCover = [
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (state is NewsSongsLoaded) {
              return _songs(songsCover);
              // return _songs(state.songs);
            }

            return Container();
          },
        ),
      ),
    );
  }

  // Widget _songs(List<SongEntity> songs)
  Widget _songs(List songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                        // SongPlayerPage(),
                        //TODO : pass the songs
                        SongPlayerPage(songEntity : songs[index]),
              ),
            );
          },
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        // image: NetworkImage(AppURLs.imageUrl + songs[index].image + ' - ' + songs[index].title + 'jpg?' + AppURLs.mediaAlt),
                        image: AssetImage(AppImages.musicCover),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        transform: Matrix4.translationValues(10, 10, 0),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: context.isDarkMode
                              ? Color(0xff959595)
                              : Color(0xff555555),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode
                              ? AppColors.darkGrey
                              : Color(0xffE6E6E6),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // Text(songs[index].title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                Text(
                  'music title',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),

                SizedBox(
                  height: 5,
                ),
                // Text(songs[index].artist, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                Text(
                  'artist name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 14,
      ),
      itemCount: songs.length,
    );
  }
}
