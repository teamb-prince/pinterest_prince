import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';

const List<Color> _kColors = const <Color>[
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.pink,
  Colors.indigo,
  Colors.purple,
  Colors.blueGrey,
];

List<StaggeredTile> _generateRandomTiles(int count) {
  Random rnd = Random();
  return List.generate(
      count, (i) => StaggeredTile.count(2, rnd.nextDouble() + 2));
}

List<Color> _generateRandomColors(int count) {
  Random rnd = Random();
  return List.generate(count, (i) => _kColors[rnd.nextInt(_kColors.length)]);
}

class AccountWidget extends StatelessWidget {
  AccountWidget()
      : _tiles = _generateRandomTiles(_kItemCount).toList(),
        _colors = _generateRandomColors(_kItemCount).toList();

  static const int _kItemCount = 100;
  final List<StaggeredTile> _tiles;
  final List<Color> _colors;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('random tiles'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    _buildHeader(),
                  ],
                )
              ],
            ),
          ),
          SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            staggeredTileBuilder: _getTile,
            itemBuilder: _getChild,
            itemCount: _kItemCount,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
//            Navigator.push(context, route);
          },
        ),
      ],
    );
  }

  StaggeredTile _getTile(int index) => _tiles[index];

  Widget _getChild(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PinDetailWidget();
            },
            fullscreenDialog: true, // TODO　おしゃれに半モーダルにさせる必要あり
          ),
        );
      },
      child: Container(
        key: ObjectKey('$index'),
        color: _colors[index],
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('$index'),
          ),
        ),
      ),
    );
  }
}
