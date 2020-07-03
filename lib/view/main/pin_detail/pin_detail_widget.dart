import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/base_button_widget.dart';
import 'package:pintersest_clone/view/main/select_board_from_url/select_board_from_url_widget.dart';
import 'package:pintersest_clone/view/main/similar_pins_list/similar_pins_list.dart';
import 'package:pintersest_clone/view/web/my_in_app_browser.dart';

import 'bloc/bloc.dart';

class PinDetailWidgetArguments {
  PinDetailWidgetArguments({@required this.pin, @required this.heroTag});

  final PinModel pin;
  final String heroTag;
}

class PinDetailWidget extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());

  @override
  _PinDetailWidgetState createState() => _PinDetailWidgetState();
}

class _PinDetailWidgetState extends State<PinDetailWidget> {
  final List<String> uploadTypeList = ['url', 'local'];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as PinDetailWidgetArguments;
    return Hero(
      tag: args.heroTag,
      child: Material(
        type: MaterialType.transparency,
        child: BlocProvider<PinDetailBloc>(
          create: (context) => PinDetailBloc(
              context.repository<UsersRepository>(),
              context.repository<PinsRepository>())
            ..add(LoadData(args.pin.userId, args.pin.id)),
          child: _buildScreen(context, args),
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, PinDetailWidgetArguments args) {
    final _similarPinsListWidget = SimilarPinsListWidget(
      label: args.pin.label.toString(),
    );
    return Scaffold(
      backgroundColor: AppColors.pinsDetailBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildPinImage(args.pin),
                  _similarPinsListWidget,
                ],
              ),
            ),
            _buildBackButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPinImage(PinModel pin) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildImage(pin),
                  _buildInformation(pin),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(PinModel pin) {
    return Image.network(pin.imageUrl, fit: BoxFit.cover);
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildActionButton(PinModel pin) {
    return BlocBuilder<PinDetailBloc, PinDetailState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LoadedState) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: Icon(Icons.share)),
                  const SizedBox(width: 8),
                  pin.uploadType == uploadTypeList[0]
                      ? _buildAccessButton(pin.url)
                      : _buildMoreViewButton(),
                  const SizedBox(width: 8),
                  state.saved
                      ? _buildSavedButton()
                      : _buildSaveBoardButton(pin),
                  const SizedBox(width: 8),
                  Flexible(child: Icon(Icons.more_horiz)),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _buildSaveBoardButton(PinModel pin) {
    return BaseButton(
        title: '保存',
        buttonColor: AppColors.red,
        buttonTextColor: AppColors.white,
        buttonHeight: 50,
        onPressedCallback: () {
          Navigator.of(context).pushNamed(AppRoute.selectBoardFromUrl,
              arguments: SelectBoardFromUrlArguments(
                  url: pin.url,
                  imageUrl: pin.imageUrl,
                  title: pin.title,
                  description: pin.description));
        });
  }

  Widget _buildSavedButton() {
    return BaseButton(
        title: '保存しました!',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        buttonHeight: 50,
        onPressedCallback: () => print('tap saved'));
  }

  Widget _buildAccessButton(String url) {
    return BaseButton(
        title: 'アクセス',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        buttonHeight: 50,
        onPressedCallback: () => widget.browser.open(url: url));
  }

  Widget _buildMoreViewButton() {
    return BaseButton(
        title: '表示',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        buttonHeight: 50,
        onPressedCallback: () => print('tap more view'));
  }

  Widget _buildFollowButton() {
    return BaseButton(
        title: 'フォロー',
        buttonColor: AppColors.grey,
        buttonTextColor: AppColors.black,
        buttonHeight: 50,
        onPressedCallback: () => print('tap follow'));
  }

  Widget _buildInformation(PinModel pin) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          _buildPinInformation(pin),
          _buildActionButton(pin),
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
          padding: const EdgeInsets.symmetric(vertical: 7),
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
