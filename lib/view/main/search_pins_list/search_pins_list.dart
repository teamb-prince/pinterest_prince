import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/common/pin_tile.dart';

import 'bloc/bloc.dart';

class SearchPinsListWidgetArguments {
  SearchPinsListWidgetArguments({@required this.label, this.title});

  final String label;
  final String title;
}

class SearchPinsListWidget extends StatefulWidget {
  @override
  _SearchPinsListWidgetState createState() => _SearchPinsListWidgetState();
}

class _SearchPinsListWidgetState extends State<SearchPinsListWidget> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as SearchPinsListWidgetArguments;
    return BlocProvider<SearchPinsListBloc>(
      create: (context) =>
          SearchPinsListBloc(context.repository<PinsRepository>())
            ..add(LoadData(args.label)),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            '${args.title} のピン',
            style:
                TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: AppColors.black),
          elevation: 0,
        ),
        body: _buildScrollView(context),
      ),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return BlocBuilder<SearchPinsListBloc, SearchPinsListState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NoDataState) {
        return Container();
      }
      if (state is LoadedState) {
        final pins = state.pins;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(slivers: <Widget>[
            SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemBuilder: (context, index) {
                final heroTag = '${pins[index].id}-account';
                return PinTile(pin: pins[index], heroTag: heroTag);
              },
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              itemCount: pins.length,
            ),
          ]),
        );
      }
      return Container();
    });
  }
}
