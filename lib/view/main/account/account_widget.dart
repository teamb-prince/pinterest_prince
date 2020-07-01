import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/rounded_tab_indicator.dart';
import 'package:pintersest_clone/view/main/boards_list/boards_list_widget.dart';
import 'package:pintersest_clone/view/main/pins_list/pins_list_widget.dart';
import 'package:pintersest_clone/view/main/user_detail/user_detail_widget.dart';

import 'bloc/bloc.dart';

class AccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (context) {
        return AccountBloc(context.repository<UsersRepository>())
          ..add(LoadData());
      },
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      if (state is LoadedState) {
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
              leading: _buildAccountIcon(context, state.user),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.setting);
                  },
                  icon: Icon(Icons.settings, color: AppColors.black),
                )
              ],
              bottom: const TabBar(
                indicator:
                    RoundedTabIndicator(height: 40, color: AppColors.black),
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.black,
                isScrollable: true,
                labelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
      return Container();
    });
  }

  Widget _buildAccountIcon(BuildContext context, UserModel user) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.userDetail,
            arguments: UserDetailWidgetArguments(user));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: AppColors.grey,
          backgroundImage: Image.network(user.profileImageUrl).image,
        ),
      ),
    );
  }
}
