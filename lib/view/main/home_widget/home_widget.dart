import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/view/main/home_detail_widget/home_detail_widget.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_bloc.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_event.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_state.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';

class HomeWidget extends StatelessWidget {
  final double _topNavigationBarHeight = 48;

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
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_topNavigationBarHeight),
          child: AppBar(
            brightness: Brightness.light,
            elevation: 0.0,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: Colors.black87,
              labelColor: Colors.black87,
              labelStyle: TextStyle(fontSize: 10.0),
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
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
      if (state is LoadedState) {
        final List<PinModel> pins = state.pins;
        return StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(8.0),
          primary: false,
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          itemBuilder: (context, index) => _getChild(context, pins[index]),
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
          itemCount: pins.length,
        );
      }
      return Container();
    });
  }

  Widget _getChild(BuildContext context, PinModel pin) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<HomeDetailWidget>(
              builder: (context) {
                Navigator.pushNamed(context, AppRoute.pinDetail,
                    arguments: PinDetailWidgetArguments(pin));
              },
              fullscreenDialog: true, // TODO　おしゃれに半モーダルにさせる必要あり
            ),
          );
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
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
