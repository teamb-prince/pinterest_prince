import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/create_pin_widget/create_pin_widget.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_bloc.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_event.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_state.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';
import 'package:pintersest_clone/view/main/user_detail_widget/user_detail_widget.dart';

// 詳細画面に渡すためのサンプルデータです
final UserModel sampleUser = UserModel(
    id: 'mrypq',
    firstName: 'めろ子',
    lastName: 'めろ田',
    profileImageUrl:
        'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/profile_image.jpeg',
    description: 'めろぴっぴです',
    location: 'めろ王国',
    web: 'https://github.com/mrypq',
    createdAt: DateTime.parse('2020-01-01T10:10:10Z'));

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  File _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _searchTextController = TextEditingController();

  Future _getImage(bool fromCamera) async {
    PickedFile pickedFile;
    if (fromCamera) {
      pickedFile = await _picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.getImage(source: ImageSource.gallery);
    }
    _image = File(pickedFile.path);
    await Navigator.pushNamed(context, AppRoute.createPin,
        arguments: CreatePinArguments(_image));
  }

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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'アカウント',
            style: TextStyle(color: AppColors.black),
          ),
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.userDetail,
                  arguments: UserDetailWidgetArguments(sampleUser));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const CircleAvatar(
                backgroundColor: AppColors.grey,
                child: Text('TA'),
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.black87,
            labelColor: Colors.black87,
            labelStyle: TextStyle(fontSize: 10),
            tabs: <Widget>[
              Tab(text: 'ボード'),
              Tab(text: 'ピン'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(color: Colors.red),
            _buildScrollView(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is LoadedState) {
        final pins = state.pins;
        return Container(
          padding: const EdgeInsets.all(8),
          child: CustomScrollView(slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(children: <Widget>[_buildSearchBar()])
              ]),
            ),
            SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemBuilder: (context, index) => _getChild(context, pins[index]),
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              itemCount: pins.length,
            ),
          ]),
        );
      }
      return Container();
    });
  }

  Widget _buildSearchBar() {
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

  void _showModalBottomSheet(BuildContext context) {
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
                    _getImage(true);
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  child: const Text('カメラロール', style: _textStyle),
                  onTap: () {
                    _getImage(false);
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  child: const Text('URLから追加', style: _textStyle),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.inputUrl);
                  },
                ),
              ],
            ),
          );
        });
  }
}
