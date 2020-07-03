import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:pintersest_clone/view/common/rounded_tab_indicator.dart';
import 'update.dart';

class NotificationWidget extends StatelessWidget {
  final double _topNavigationBarHeight = 48;
  final double _tabIndicatorHeight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_topNavigationBarHeight),
          child: AppBar(
            brightness: Brightness.light,
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicator: RoundedTabIndicator(
                  height: _tabIndicatorHeight, color: AppColors.black),
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.black,
              isScrollable: true,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              labelPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              tabs: <Widget>[
                Tab(text: '更新情報'),
                Tab(text: '受信トレイ'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            UpdateWidget(),
            _buildInbox(),
          ],
        ),
      ),
    );
  }

  Widget _buildInbox() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 120,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            '友達とアイデアをシェアしましょう',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        _buildSearchBar(),
        _buildAddress(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: AppColors.darkGrey,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '名前またはメールで検索',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.red,
            child: Icon(
              Icons.people,
              color: Colors.white,
              size: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '連絡先を同期',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
