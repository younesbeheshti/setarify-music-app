import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/bloc/favorite_button_cubit.dart';
import 'package:spotify_flutter_apk/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

import '../../bloc/favorite_button_state.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;

  FavoriteButton({super.key, required this.songEntity, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                    songEntity);

                if (function != null) {
                  function!();
                }
              },
              icon: songEntity.liked!
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border_outlined),
              iconSize: 25,
              color: context.isDarkMode ? Color(0xff959595) : Color(0xff555555),
            );
          }

          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity);
              },
              icon: state.isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border_outlined),
              iconSize: 25,
              color: context.isDarkMode ? Color(0xff959595) : Color(0xff555555),
            );
          }

          return IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline_outlined),
            iconSize: 25,
            color: context.isDarkMode ? Color(0xff959595) : Color(0xff555555),
          );
        },
      ),
    );
  }
}
