import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';

class BoardDetailArgs {
  BoardDetailArgs({@required this.board, @required this.pins});

  final BoardModel board;
  final List<PinModel> pins;
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
      body: _buildScreen(context, args.pins),
    );
  }

  Widget _buildScreen(BuildContext context, List<PinModel> pins) {
    return _buildStaggeredGridView(pins);
  }

  Widget _buildHeader(BoardModel board) {
    return Text(board.name);
  }

  Widget _buildStaggeredGridView(List<PinModel> pins) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8),
      primary: false,
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      itemBuilder: (context, index) => _getChild(context, pins[index]),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      itemCount: pins.length,
    );
  }

  Widget _getChild(BuildContext context, PinModel pin) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoute.pinDetail,
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
