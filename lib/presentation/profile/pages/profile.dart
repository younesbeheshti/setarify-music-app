import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter_apk/common/widgets/appbar/app_bar.dart';
import 'package:spotify_flutter_apk/core/configs/theme/app_colors.dart';
import 'package:spotify_flutter_apk/domain/usecases/auth/log_out.dart';
import 'package:spotify_flutter_apk/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify_flutter_apk/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify_flutter_apk/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify_flutter_apk/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify_flutter_apk/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../service_locator.dart';
import '../bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff2C2B2B),
        action: PopupMenuButton<String>(
          onSelected: (value) async {
            // Handle menu item selection
            await sl<LogOutUseCase>().call();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpOrSignInPage()));
          },
          icon: Icon(Icons.more_vert), // Icon for the menu trigger
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 'Log Out',
              child: Text('Log out'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileInfo(context),
            SizedBox(
              height: 30,
            ),
            _favoriteSongs(),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          color: context.isDarkMode ? Color(0xff2C2B2B) : Colors.white,
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            //TODO: remove this column
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        // image: NetworkImage(state.userEntity.imageUrl,);
                        image: AssetImage(AppImages.userImage),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("@JohnDoe"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "John-Doe",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );

            /*

            if (state is ProfileInfoLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          // image: NetworkImage(state.userEntity.imageUrl,);
                          image: AssetImage(AppImages.userDefaultProfileImage),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(state.userEntity.userName?? "@JohnDoe"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.userEntity.fullName?? "John-Doe",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return Text("please try again");
            }
*/
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FAVORITE SONGS",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is FavoriteSongsLoaded) {
                  if (state.favoriteSongs.isEmpty) {
                    return Text("No favorite songs available");
                  }

                  return Flexible(
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SongPlayerPage(
                                        songEntity: state.favoriteSongs[index]),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          state.favoriteSongs[index].cover ??
                                              '',
                                        ), // Fallback icon
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // 'music title',
                                        state.favoriteSongs[index].title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'music artist',
                                        state.favoriteSongs[index].artist[0]
                                            ['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          color: Color(0xffCC6C6C6),
                                        ),
                                      ),
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
                                  FavoriteButton(
                                    songEntity: state.favoriteSongs[index],
                                    key: UniqueKey(),
                                    function: () {
                                      context
                                          .read<FavoriteSongsCubit>()
                                          .removeSong(index);
                                    },
                                  ),
                                  // FavoriteButton(),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemCount: state.favoriteSongs.length,
                    ),
                  );
                }

                if (state is FavoriteSongsFailure) {
                  return Text("Please try again");
                }

                return Container(); // Fallback for any unhandled state
              },
            ),
          ],
        ),
      ),
    );
  }
}
