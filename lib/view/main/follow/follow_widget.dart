import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/base_button_widget.dart';
import 'package:pintersest_clone/view/main/follow/bloc/bloc.dart';

class FollowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowBloc>(
      create: (context) {
        return FollowBloc(context.repository<UsersRepository>(),
            context.repository<PinsRepository>())
          ..add(LoadData());
      },
      child: BlocBuilder<FollowBloc, FollowState>(builder: (context, state) {
        if (state is LoadedDataState) {
          return ListView.builder(
            itemBuilder: (context, index) {
//            user, pins
              return _buildFollowTile(state.users[index], state.pins);
            },
            itemCount: 4,
          );
        }
        return Container();
      }),
    );
  }

  Widget _buildFollowTile(UserModel user, Map<String, List<PinModel>> pins) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildInformation(user),
          Container(height: 400, child: _buildImages(pins[user.id])),
        ],
      ),
    );
  }

  Widget _buildInformation(UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildUserInfo(user),
        BaseButton(
          title: 'フォロー',
          buttonTextColor: AppColors.white,
          buttonColor: AppColors.red,
          onPressedCallback: () => print('follow'),
        ),
      ],
    );
  }

  Widget _buildUserInfo(UserModel user) {
    return Row(
      children: [
        Container(
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(user.profileImageUrl),
            )),
        const SizedBox(
          width: 16,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.id,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${Random().nextInt(10)}万フォロワー'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImages(List<PinModel> pins) {
    final imageUrl1 = (pins.isNotEmpty)
        ? pins[0].imageUrl
        : 'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/sample/006.png';
    final imageUrl2 = (pins.length >= 2)
        ? pins[1].imageUrl
        : 'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/sample/004.png';
    final imageUrl3 = (pins.length >= 3)
        ? pins[2].imageUrl
        : 'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/sample/003.png';
    final imageUrl4 = (pins.length >= 4)
        ? pins[3].imageUrl
        : 'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/sample/008.png';
    return GridView.count(
      crossAxisCount: 2,
      primary: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: _buildImageTile(imageUrl1),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: _buildImageTile(imageUrl2),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: _buildImageTile(imageUrl3),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: _buildImageTile(imageUrl4),
        ),
      ],
    );
  }

  Widget _buildImageTile(String imageUrl) {
    return Container(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
