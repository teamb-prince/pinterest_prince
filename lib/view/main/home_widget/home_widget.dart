import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common_widget/rounded_tab_indicator.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';

import 'bloc/bloc.dart';

class HomeWidget extends StatelessWidget {
  final double _topNavigationBarHeight = 48;
  final double _tabIndicatorHeight = 40;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc(context.repository<PinsRepository>())..add(LoadData()),
      child: WillPopScope(
        onWillPop: () async => false,
        child: _buildScreen(context),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              labelPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              tabs: <Widget>[
                Tab(text: 'あなたにおすすめ'),
                Tab(text: 'ピックアップ'),
                Tab(text: 'フォロー中'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildStaggeredGridView(),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaggeredGridView() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is LoadedState) {
        final pins = state.pins;
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<HomeBloc>(context).add(LoadData());
          },
          child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(8),
            primary: false,
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            itemBuilder: (context, index) => _getChild(context, pins[index]),
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            itemCount: pins.length,
          ),
        );
      }
      return Container();
    });
  }

  Widget _getChild(BuildContext context, PinModel pin) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoute.pinDetail,
              arguments: PinDetailWidgetArguments(pin));
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  pin.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }
}
