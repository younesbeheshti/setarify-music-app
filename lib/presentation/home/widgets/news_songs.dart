import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';
import 'package:spotify_flutter_apk/presentation/home/bloc/news_songs_cubit.dart';

import '../bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return CircularProgressIndicator();
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Column();
      },
      separatorBuilder: (context, index) => SizedBox(width: 14,),
      itemCount: songs.length,
    );
  }
}
