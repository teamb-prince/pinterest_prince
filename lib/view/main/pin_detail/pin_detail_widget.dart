import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/base_button_widget.dart';
import 'package:pintersest_clone/view/web/my_in_app_browser.dart';

import 'bloc/bloc.dart';

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

  final List<String> uploadTypeList = ['url', 'local'];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as PinDetailWidgetArguments;
    return BlocProvider<PinDetailBloc>(
      create: (context) => PinDetailBloc(context.repository<UsersRepository>(),
          context.repository<PinsRepository>())
        ..add(LoadData(args.pin.userId, args.pin.id)),
      child: Scaffold(
        backgroundColor: AppColors.pinsDetailBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: [
                        _buildPinImage(args.pin),
                      ],
                    )
                  ],
                ),
              ),
              SliverGrid(
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
      ),
    );
  }

  Widget _buildPinImage(PinModel pin) {
    return Stack(
      children: [
        Container(
            decoration: _roundedContainerDecoration,
            child: Column(
              children: [
                _buildImage(pin),
                _buildInformation(pin),
              ],
            )),
        _buildBackButton(),
      ],
    );
  }

  Widget _buildImage(PinModel pin) {
    return ClipRRect(
      child: Image.network(pin.imageUrl),
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

  Widget _buildActionButton(String uploadType, String url) {
    return BlocBuilder<PinDetailBloc, PinDetailState>(
      builder: (context, state) {
        if (state is LoadedState) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(Icon(Icons.share)),
                  const SizedBox(
                    width: 8,
                  ),
                  uploadType == uploadTypeList[0]
                      ? _buildAccessButton(url)
                      : _buildMoreViewButton(),
                  const SizedBox(
                    width: 8,
                  ),
                  state.saved ? _buildSavedButton() : _buildSaveBoardButton(),
                  const SizedBox(
                    width: 8,
                  ),
                  _buildIcon(const Icon(Icons.more_horiz)),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildIcon(Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: icon,
    );
  }

  Widget _buildSaveBoardButton() {
    return BaseButton(
        title: '保存',
        buttonColor: AppColors.red,
        buttonTextColor: AppColors.white,
        onPressedCallback: () => print('tap save'));
  }

  Widget _buildSavedButton() {
    return BaseButton(
        title: '保存しました!',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        onPressedCallback: () => print('tap saved'));
  }

  Widget _buildAccessButton(String url) {
    return BaseButton(
        title: 'アクセス',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        onPressedCallback: () => widget.browser.open(url: url));
  }

  Widget _buildMoreViewButton() {
    return BaseButton(
        title: '表示',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        onPressedCallback: () => print('tap more view'));
  }

  Widget _buildFollowButton() {
    return BaseButton(
        title: 'フォロー',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        onPressedCallback: () => print('tap follow'));
  }

  Widget _buildInformation(PinModel pin) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          _buildPinInformation(pin),
          _buildActionButton(pin.uploadType, pin.url),
        ],
      ),
    );
  }

  Widget _buildUrlInformation(String url) {
    return Text(
      'ピンもと:  $url',
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPinInformation(PinModel pin) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        pin.uploadType == uploadTypeList[0]
            ? _buildUrlInformation(pin.url)
            : _buildUserInformation(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Container(
            child: Text(
              pin.title,
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
          pin.description,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildUserInformation() {
    return BlocBuilder<PinDetailBloc, PinDetailState>(
      builder: (context, state) {
        if (state is LoadedState) {
          final user = state.user;
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
    );
  }

  Widget _buildUser(UserModel user) {
    final userName = '${user.lastName} ${user.firstName}';
    final profileImageUrl = user.profileImageUrl;
    return Padding(
      padding: const EdgeInsets.all(2),
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'フォロワー  3人',
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
}
