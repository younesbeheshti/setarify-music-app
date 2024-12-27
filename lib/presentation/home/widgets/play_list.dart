import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../song_player/pages/song_player.dart';
import '../bloc/play_list_cubit.dart';
import '../bloc/play_list_state.dart';

//TODO : after fetching music form server(state.songs), turn in to stateless widget

class PlayList extends StatefulWidget {
  PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  List songs = [
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
    AppImages.musicCover,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          if (state is PlayListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffCC6C6C6)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // _songs(state.songs)
                  _songs(songs)
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  // Widget _songs(List<SongEntity> songs)
  Widget _songs(List songs) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>

                    //TODO : pass the music
                    // SongPlayerPage(songEntity : song[index]),
                    SongPlayerPage(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : Color(0xffE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode
                          ? Color(0xff959595)
                          : Color(0xff555555),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'music title',
                        // songs[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'music artist',
                        // songs[index].artist,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Color(0xffCC6C6C6),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    // songs[index].duration.toString().replaceAll('.', ':'),
                    '00:00',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_outline_outlined),
                    iconSize: 25,
                    color: context.isDarkMode
                        ? Color(0xff959595)
                        : Color(0xff555555),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemCount: songs.length,
    );
  }
}
