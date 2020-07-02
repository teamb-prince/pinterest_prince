import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/account/account_widget.dart';
import 'package:pintersest_clone/view/main/home/home_widget.dart';
import 'package:pintersest_clone/view/main/notification/notification_widget.dart';
import 'package:pintersest_clone/view/main/search/search_widget.dart';

class MainPageDestination {
  MainPageDestination(this.index, this.title, this.iconData);

  final int index;
  final String title;
  final IconData iconData;
}

List<MainPageDestination> mainPageDestinations = [
  MainPageDestination(0, 'ホーム', Icons.home),
  MainPageDestination(1, '検索', Icons.search),
  MainPageDestination(2, 'お知らせ', Icons.message),
  MainPageDestination(3, '保存済み', Icons.person),
];

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  bool _isVisible = true;
  final double _bottomNavBarPosition = 32;
  final double _bottomNavBarCornerRadius = 32;
  final double _bottomNavBarHorizontalPadding = 70;

  final double _selectedIconSize = 25;
  final double _unselectedIconSize = 20;

  void _updateIsVisible(bool isVisible) {
    setState(() {
      _isVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              HomeWidget(appearBottomNavBar: _updateIsVisible),
              SearchWidget(),
              NotificationWidget(),
              AccountWidget(),
            ],),
        Positioned(
          left: 0,
          right: 0,
          bottom: _bottomNavBarPosition,
          child: _buildBottomNavigationBar(context),
        ),
      ],
    ));
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: _bottomNavBarHorizontalPadding),
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(_bottomNavBarCornerRadius)),
            child: BottomNavigationBar(
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.black,
              unselectedItemColor: Colors.grey[500],
              selectedIconTheme: IconThemeData(size: _selectedIconSize),
              unselectedIconTheme: IconThemeData(size: _unselectedIconSize),
              onTap: (index) {
                if (!_isVisible) {
                  return;
                }
                setState(() {
                  _currentIndex = index;
                });
              },
              currentIndex: _currentIndex,
              items: mainPageDestinations
                  .map((item) => BottomNavigationBarItem(
                        icon: Icon(item.iconData),
                        title: Text(item.title,
                            style: const TextStyle(fontSize: 12)),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
