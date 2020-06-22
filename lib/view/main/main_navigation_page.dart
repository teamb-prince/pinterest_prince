import 'package:flutter/material.dart';
import 'package:pintersest_clone/view/main/account_widget/account_widget.dart';
import 'package:pintersest_clone/view/main/home_widget/home_widget.dart';
import 'package:pintersest_clone/view/main/notification_widget/notification_widget.dart';
import 'package:pintersest_clone/view/main/search_widget/search_widget.dart';

class MainPageDestination {
  MainPageDestination(this.index, this.title, this.body, this.iconData);

  final int index;
  final String title;
  final Widget body;
  final IconData iconData;
}

List<MainPageDestination> mainPageDestinations = [
  MainPageDestination(0, 'ホーム', HomeWidget(), Icons.home),
  MainPageDestination(1, '検索', SearchWidget(), Icons.search),
  MainPageDestination(2, 'お知らせ', NotificationWidget(), Icons.notifications),
  MainPageDestination(3, '保存済み', AccountWidget(), Icons.person),
];

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainPageDestinations[_currentIndex].body,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Material(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: mainPageDestinations
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.iconData),
                  title: Text(item.title),
                ))
            .toList(),
      ),
    );
  }
}
