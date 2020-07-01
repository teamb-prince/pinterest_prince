import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/bottom_loader_widget.dart';
import 'package:pintersest_clone/view/common/pin_tile.dart';
import 'package:pintersest_clone/view/common/rounded_tab_indicator.dart';

import 'bloc/bloc.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  _HomeWidgetState() {
    _scrollController.addListener(_onScroll);
  }

  final double _topNavigationBarHeight = 48;
  final double _tabIndicatorHeight = 40;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200;

  HomeBloc bloc;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      bloc.add(LoadData());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              labelStyle: TextStyle(
                fontSize: 14,
              ),
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
      bloc = BlocProvider.of<HomeBloc>(context);
      if (state is LoadedState) {
        final pins = state.pins;
        return RefreshIndicator(
          onRefresh: () async {
            bloc.add(LoadData());
          },
          backgroundColor: AppColors.black,
          color: AppColors.white,
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            primary: false,
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            itemBuilder: (context, index) {
              final heroTag = '${pins[index].id}-home';
              return index >= state.pins.length
                  ? BottomLoaderWidget()
                  : PinTile(pin: pins[index], heroTag: pins[index].id);
            },
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            itemCount: pins.length,
          ),
        );
      }
      return Container();
    });
  }
}
