import 'package:flutter/material.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class UserDetailWidgetArguments {
  UserDetailWidgetArguments(this.user);

  final UserModel user;
}

class UserDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildScreen(context),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as UserDetailWidgetArguments;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          const SizedBox(height: 8),
          _buildUserInfoView(args.user),
        ],
      ),
    );
  }

  Widget _buildUserInfoView(UserModel user) {
    return Center(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 64,
            backgroundImage:
                Image.network(user.profileImageUrl, fit: BoxFit.cover).image,
          ),
          const SizedBox(height: 8),
          Text(user.id,
              style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          _buildButtons()
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),

          FlatButton(
            padding: const EdgeInsets.all(16),
            onPressed: () {},
            child: const Text('フォロー',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            color: AppColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
