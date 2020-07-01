import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/common/pin_tile.dart';
import 'package:pintersest_clone/view/main/create_pin/create_pin_widget.dart';

import 'bloc/bloc.dart';

class PinsListWidget extends StatefulWidget {
  @override
  _PinsListWidgetState createState() => _PinsListWidgetState();
}

class _PinsListWidgetState extends State<PinsListWidget> {
  File _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _searchTextController = TextEditingController();

  Future _getImage(bool fromCamera, Function(Object) callback) async {
    PickedFile pickedFile;
    if (fromCamera) {
      pickedFile = await _picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.getImage(source: ImageSource.gallery);
    }
    _image = File(pickedFile.path);
    await Navigator.pushNamed(context, AppRoute.createPin,
            arguments: CreatePinArguments(_image))
        .then(callback);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinsListBloc>(
      create: (context) =>
          PinsListBloc(context.repository<PinsRepository>())..add(LoadData()),
      child: _buildScrollView(context),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return BlocBuilder<PinsListBloc, PinsListState>(builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NoDataState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              _buildSearchBar(context),
            ],
          ),
        );
      }
      if (state is LoadedState) {
        final pins = state.pins;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    _buildSearchBar(context),
                  ],
                )
              ]),
            ),
            SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemBuilder: (context, index) =>
                  PinTile(pin: pins[index], heroTag: pins[index].id),
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              itemCount: pins.length,
            ),
          ]),
        );
      }
      return Container();
    });
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 24,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
                hintText: '自分のピンを探す',
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showModalBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<PinsListBloc>(context);
    const _textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    const _heightRatio = 0.3;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * _heightRatio,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  child: const Text('写真をとる', style: _textStyle),
                  onTap: () {
                    _getImage(true, (_) {
                      bloc.add(LoadData());
                    });
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  child: const Text('カメラロール', style: _textStyle),
                  onTap: () {
                    _getImage(false, (_) {
                      bloc.add(LoadData());
                    });
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  child: const Text('URLから追加', style: _textStyle),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.inputUrl)
                        .then((value) {
                      bloc.add(LoadData());
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
