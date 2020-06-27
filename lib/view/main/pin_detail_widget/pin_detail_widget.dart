import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/web/my_in_app_browser.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/user_model.dart';

import 'package:pintersest_clone/view/main/pin_detail_widget/bloc/pin_detail_bloc.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/bloc/pin_detail_event.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/bloc/pin_detail_state.dart';

class PinDetailWidgetArguments {
  PinDetailWidgetArguments(this.pin);

  final PinModel pin;
}

class PinDetailWidget extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());

  @override
  _PinDetailWidgetState createState() => _PinDetailWidgetState();
}

class _PinDetailWidgetState extends State<PinDetailWidget> {
  final BoxDecoration _roundedContainerDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
  );

  final RoundedRectangleBorder _buttonDecoration = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32),
  );

  final List<String> imageList = [
    'https://automaton-media.com/wp-content/uploads/2019/05/20190501-91106-001.jpg',
    'https://c2.staticflickr.com/2/1496/26433173610_10a5654b94_o.jpg',
    'https://skyticket.jp/guide/wp-content/uploads/shutterstock_252533968.jpg',
    'https://d1fv7zhxzrl2y7.cloudfront.net/articlecontents/103160/dobai_AdobeStock_211353756.jpeg?1555031349',
    'https://cdn.sbfoods.co.jp/recipes/06608_l.jpg',
    'https://images3.imgbox.com/4a/4a/XnWFHADP_o.gif',
    'https://town.epark.jp/lp/magazine/wp-content/uploads/2019/11/sunshine_aquarium.jpg',
    'https://www.fashion-press.net/img/news/56610/bkg.jpg',
    'https://pbs.twimg.com/media/EZoZKkBUMAARw9Z.jpg',
  ];

  static const String accessText = 'アクセス';
  static const String saveText = '保存';
  static const String savedText = '保存しました！';
  static const String moreViewText = '表示';
  static const String urlText = 'ピンもと: ';
  static const String followText = 'フォロー';

  static const String dummyFollowerText = 'フォロワー  3人';

  final List<String> uploadTypeList = ['url', 'local'];

  static const double menuButtonSize = 45;
  static const double menuButtonFontSize = 17;

  String title;
  String description;
  String url;
  String uploadType;
  String userId;
  String imageUrl;
  dynamic args;

  void getPinData() {
    args =
        ModalRoute.of(context).settings.arguments as PinDetailWidgetArguments;
    title = args.pin.title.toString();
    description = args.pin.description.toString();
    url = args.pin.url.toString();
    uploadType = args.pin.uploadType.toString();
    userId = args.pin.userId.toString();
    imageUrl = args.pin.imageUrl.toString();
  }

  void _saveBoard() {
    // TODO ボードを保存する処理
    print('tap save');
  }

  void _moveToBoard() {
    // TODO 自分がこのピンを保存したボードに移動する処理？
    print('tap already saved');
  }

  void _accessSite() {
    widget.browser.open(url: url);
  }

  void _moreView() {
    // TODO 類似画像を表示する処理
    print('tap more view');
  }

  void _follow() {
    // TODO フォローする処理
    print('tap follow button');
  }

  @override
  Widget build(BuildContext context) {
    getPinData();
    return Scaffold(
      backgroundColor: AppColors.pinsDetailBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      _buildPinImage(),
                    ],
                  )
                ],
              ),
            ),
            SliverGrid(
              // TODO 細かいUIは後で
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return _buildSmallImage(imageList[index]);
              }, childCount: imageList.length),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPinImage() {
    return Stack(
      children: [
        Container(
            decoration: _roundedContainerDecoration,
            child: Column(
              children: [
                _buildImage(imageUrl),
                _buildInformation(),
              ],
            )),
        _buildBackButton(),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      child: Image.network(imageUrl),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    );
  }

  Widget _buildSmallImage(String imageUrl) {
    return Container(
      child: ClipRRect(
        child: Image.network(imageUrl),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.close,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(Icon(Icons.share)), //TODO シェア機能いる?

            uploadType == uploadTypeList[0]
                ? _buildAccessButton()
                : _buildMoreViewButton(),
            _buildSaveBoardButton(), // TODO 保存ずみ/未保存で表示を変える
            _buildIcon(Icon(Icons.more_horiz)), //TODO その他の操作いる?
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: icon,
    );
  }

  Widget _buildSaveBoardButton() {
    return _buildButton(saveText, AppColors.white, AppColors.red,
        menuButtonSize, menuButtonFontSize);
  }

  Widget _buildSavedButton() {
    return _buildButton(savedText, AppColors.black, AppColors.grey,
        menuButtonSize, menuButtonFontSize);
  }

  Widget _buildAccessButton() {
    return _buildButton(accessText, AppColors.black, AppColors.grey,
        menuButtonSize, menuButtonFontSize);
  }

  Widget _buildMoreViewButton() {
    return _buildButton(moreViewText, AppColors.black, AppColors.grey,
        menuButtonSize, menuButtonFontSize);
  }

  Widget _buildFollowButton() {
    return _buildButton(followText, AppColors.black, AppColors.grey, 40, 13);
  }

  Widget _buildInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          _buildPinInformation(),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildUrlInformation() {
    return Text(
      '$urlText $url',
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPinInformation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        uploadType == uploadTypeList[0]
            ? _buildUrlInformation()
            : _buildUserInfomation(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Container(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildUserInfomation() {
    return BlocProvider<PinDetailBloc>(
      create: (context) => PinDetailBloc(context.repository<UsersRepository>())
        ..add(RequestUser(userId)),
      child: BlocBuilder<PinDetailBloc, PinDetailState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final user = state.userModel;
            return _buildUser(user);
          } else if (state is NoDataState) {
            return const Text('No User.');
          } else if (state is ErrorState) {
            return Text(state.exception.toString());
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildUser(UserModel user) {
    final userName = '${user.lastName} ${user.firstName}';
    final profileImageUrl = user.profileImageUrl;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl),
                      radius: 20,
                    ),
                    onTap: () {
                      print('tap user icon');
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dummyFollowerText,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildFollowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color textColor, Color buttonColor,
      double height, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Container(
        height: height,
        child: FlatButton(
          shape: _buttonDecoration,
          color: buttonColor,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
          onPressed: () {
            switch (text) {
              case saveText:
                _saveBoard();
                break;
              case savedText:
                _moveToBoard();
                break;
              case accessText:
                _accessSite();
                break;
              case moreViewText:
                _moreView();
                break;
              case followText:
                _follow();
                break;
              default:
            }
          },
        ),
      ),
    );
  }
}
