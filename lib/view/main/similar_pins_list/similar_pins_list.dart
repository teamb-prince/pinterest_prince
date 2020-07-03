import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/pin_tile.dart';
import 'package:pintersest_clone/view/main/similar_pins_list/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/view/main/pin_detail/pin_detail_widget.dart';

class SimilarPinsListWidget extends StatefulWidget {
  const SimilarPinsListWidget({this.label});
  final String label;

  @override
  _SimilarPinsListWidgetState createState() =>
      _SimilarPinsListWidgetState(label: label);
}

class _SimilarPinsListWidgetState extends State<SimilarPinsListWidget> {
  _SimilarPinsListWidgetState({this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SimilarPinsBloc>(
      create: (context) => SimilarPinsBloc(context.repository<PinsRepository>())
        ..add(LoadData(label)),
      child: BlocBuilder<SimilarPinsBloc, SimilarPinsState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final pinsList = state.pins;
            return _buildSimilarPinsField(pinsList);
          } else if (state is ErrorState) {
            return Text(state.exception.toString());
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(color: Colors.blue);
        },
      ),
    );
  }

  Widget _buildSimilarPinsField(List<PinModel> pins) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: <Widget>[
          _buildSimilarPinsText(),
          _buildPinsList(pins),
        ],
      ),
    );
  }

  Widget _buildSimilarPinsText() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Text(
          '似ているピン',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            fontFamily: 'SourceHanCodeJP',
          ),
        ),
      ),
    );
  }

  Widget _buildPinsList(List<PinModel> pins) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      primary: false,
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      // Hero ってネストできないらしい 何でや リッチにするのは諦めた
      // itemBuilder: (context, index) => PinTile(pin: pins[index], heroTag: pins[index].id),
      itemBuilder: (context, index) =>
          _buildPinTile(pins[index].imageUrl, pins[index]),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      itemCount: pins.length,
    );
  }

// TODO 無限スクロールできたら追加して欲しい
  Widget _buildPinTile(String imageUrl, PinModel pin) {
    return GestureDetector(
      child: Container(
        child: ClipRRect(
          child: Image.network(imageUrl),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onTap: () {
        Navigator.pushReplacementNamed(context, AppRoute.pinDetail,
            arguments: PinDetailWidgetArguments(pin: pin, heroTag: pin.id));
      },
    );
  }
}
