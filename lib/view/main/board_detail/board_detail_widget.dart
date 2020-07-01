import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/pin_tile.dart';

import 'bloc/bloc.dart';

class BoardDetailArgs {
  BoardDetailArgs({@required this.board});

  final BoardModel board;
}

class BoardDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as BoardDetailArgs;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          args.board.name,
          style: const TextStyle(color: AppColors.black),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: BlocProvider(
        create: (context) =>
            BoardDetailBloc(RepositoryProvider.of<PinsRepository>(context))
              ..add(LoadPins(boardId: args.board.id)),
        child: _buildScreen(context),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return _buildStaggeredGridView();
  }

  Widget _buildStaggeredGridView() {
    return BlocBuilder<BoardDetailBloc, BoardDetailState>(
        builder: (context, state) {
      if (state is LoadedState) {
        return StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(8),
            primary: false,
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            itemBuilder: (context, index) =>
                PinTile(pin: state.pins[index], heroTag: state.pins[index].id),
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            itemCount: state.pins.length);
      }
      return Container();
    });
  }
}
