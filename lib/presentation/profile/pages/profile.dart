import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter_apk/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter_apk/common/widgets/appbar/app_bar.dart';
import 'package:spotify_flutter_apk/core/configs/theme/app_colors.dart';
import 'package:spotify_flutter_apk/presentation/profile/bloc/profile_info_cubit.dart';

import '../../../core/configs/assets/app_images.dart';
import '../bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff2C2B2B),
      ),
      body: Column(
        children: [
          _profileInfo(context)
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 3.5,
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
                      )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(state.userEntity.userName!),
                  SizedBox(height: 10,),
                  Text(state.userEntity.fullName!, style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return Text("please try again");
            }

            return Center(
              child: Text(""),
            );
          },
        ),
      ),
    );
  }

}
