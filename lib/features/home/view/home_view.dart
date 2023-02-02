import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/home/widgets/side_drawer.dart';
import 'package:twitter_clone/theme/pallete.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  onCreateTweet() {}

  @override
  Widget build(BuildContext context) {
    var navBarItems = [
          // home
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 0
                  ? AssetsConstants.homeFilledIcon
                  : AssetsConstants.homeOutlinedIcon,
              color: Pallete.whiteColor,
            ),
          ),

          // search
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Pallete.whiteColor,
            ),
          ),

          // twitter circle
          BottomNavigationBarItem(
            icon: Icon(
              _page == 2 ? CupertinoIcons.mic_fill : CupertinoIcons.mic,
              color: Pallete.whiteColor,
            ),
          ),

          // Notifications
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 3
                  ? AssetsConstants.notifFilledIcon
                  : AssetsConstants.notifOutlinedIcon,
              color: Pallete.whiteColor,
            ),
          ),

          // Messages
          BottomNavigationBarItem(
            icon: Icon(
              _page == 4 ? CupertinoIcons.mail : CupertinoIcons.mail_solid,
              color: Pallete.whiteColor,
            ),
          ),
        ];
    return Scaffold(
      appBar: _page == 0 ? UIConstants.appBar : null,
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      drawer: const SideDrawer(),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: navBarItems,
      ),
    );
  }
}
