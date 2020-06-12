import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_bloc.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_event.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_state.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc(context.repository<PinsRepository>())..add(LoadData()),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: const Text(("Home")),
        ),
        Expanded(
          child: _buildStaggeredGridView(),
        )
      ],
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
        onTap: () => print(pin.id),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  pin.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                  onTap: () {
                    print("tapped more");
                  },
                  child: Icon(Icons.more_horiz))
            ],
          ),
        ));
  }
}
