import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common_widget/rounded_tab_indicator.dart';
import 'package:pintersest_clone/view/main/boards_list_widget/boards_list_widget.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_bloc.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_event.dart';
import 'package:pintersest_clone/view/main/pins_list_widget/pins_list_widget.dart';
import 'package:pintersest_clone/view/main/user_detail_widget/user_detail_widget.dart';

// 詳細画面に渡すためのサンプルデータです
final UserModel sampleUser = UserModel(
    id: 'mrypq',
    firstName: 'めろ子',
    lastName: 'めろ田',
    profileImageUrl:
        'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/profile_image.jpeg',
    description: 'めろぴっぴです',
    location: 'めろ王国',
    web: 'https://github.com/mrypq',
    createdAt: DateTime.parse('2020-01-01T10:10:10Z'));

class AccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc(context.repository<PinsRepository>())..add(LoadData()),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'アカウント',
            style: TextStyle(color: AppColors.black),
          ),
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.userDetail,
                  arguments: UserDetailWidgetArguments(sampleUser));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const CircleAvatar(
                backgroundColor: AppColors.grey,
                child: Text('TA'),
              ),
            ),
          ),
          bottom: const TabBar(
            indicator: RoundedTabIndicator(height: 40, color: AppColors.black),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.black,
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            labelPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            tabs: <Widget>[
              Tab(text: 'ボード'),
              Tab(text: 'ピン'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BoardsListWidget(),
            PinsListWidget(),
          ],
        ),
      ),
    );
  }
}
