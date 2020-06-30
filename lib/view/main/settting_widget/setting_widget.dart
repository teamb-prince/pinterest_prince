import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class SettingItem {
  SettingItem({@required this.iconData, @required this.text});

  final IconData iconData;
  final String text;
}

final List<SettingItem> settingItems = [
  SettingItem(iconData: Icons.power_settings_new, text: 'ログアウト')
];

class SettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '設定',
          style: TextStyle(color: AppColors.black),
        ),
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: _buildListView(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Container();
  }

  Widget _buildListView(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            _buildListTile(context, settingItems[index]),
        itemCount: settingItems.length,
      ),
    );
  }

  Widget _buildListTile(BuildContext context, SettingItem settingItem) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        leading: Icon(settingItem.iconData),
        title: Text(settingItem.text,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
