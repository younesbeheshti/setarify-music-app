import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_flutter_apk/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter_apk/core/configs/assets/app_images.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          hideBackButton: true,
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 40,
            width: 40,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _homeTopCart(),
              _tabs(),
            ],
          ),
        ));
  }

  Widget _homeTopCart() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: Image.asset(AppImages.homeArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      isScrollable: true,
      indicatorColor: AppColors.primary,
      tabs: [
        Text(
          "News",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Videos",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Artists",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Podcasts", 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
