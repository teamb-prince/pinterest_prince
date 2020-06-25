import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart';
import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/web/my_in_app_browser.dart';

class HomeDetailWidget extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());

  @override
  _HomeDetailWidgetState createState() => _HomeDetailWidgetState();
}

class _HomeDetailWidgetState extends State<HomeDetailWidget> {
  final PinsApi _pinsApi = DefaultPinsApi(ApiClient(Client()));
  String url =
      'https://avatars2.githubusercontent.com/u/23512935?s=460&u=8f50efae6e531658b6a52e0e70381c26408d7843&v=4';
  final BoxDecoration _roundedContainerDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
  );

  final RoundedRectangleBorder _buttonDecoration = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32),
  );

  final imageList = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinsDetailBackgroundColor,
      appBar: AppBar(
        title: const Text('Pin Detail'), // TODO 本来であればAppBarではなく画像の上に戻るボタンをつける
      ),
      body: CustomScrollView(
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
              return _buildImage(imageList[index]);
            }, childCount: imageList.length),
          )
        ],
      ),
    );
  }

  Widget _buildPinImage() {
    return Container(
      decoration: _roundedContainerDecoration,
      child: FutureBuilder(
          future: _pinsApi.getPin('ab917ee9-bf28-41ff-b914-550728159fae'),
          builder: (context, AsyncSnapshot<PinModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  _buildImage(snapshot.data.imageUrl),
                  _buildInformation(snapshot.data.title,
                      snapshot.data.description, snapshot.data.url),
                ],
              );
            } else {
              return const Text('No Data.');
            }
          }),
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

  Widget _buildInformation(String title, String description, String url) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16, top: 16),
      child: Column(
        children: [
          _buildImageInformation(title, description),
          _buildActionButton(url),
        ],
      ),
    );
  }

  Widget _buildImageInformation(String title, String description) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('ピンもと: $title'),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String url) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.share), //TODO シェア機能いる?
          _buildVisitSiteButton(url),
          _buildSaveBoardButton(),
          const Icon(Icons.more_horiz), //TODO その他の操作いる?
        ],
      ),
    );
  }

  Widget _buildVisitSiteButton(String url) {
    return FlatButton(
      shape: _buttonDecoration,
      color: AppColors.grey,
      child: const Text(
        'アクセス',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        widget.browser.open(url: url);
      },
    );
  }

  Widget _buildSaveBoardButton() {
    return FlatButton(
      shape: _buttonDecoration,
      child: const Text(
        '保存',
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
      ),
      color: AppColors.red,
      onPressed: () {
        print('save tapped'); // TODO boardへの保存処理
      },
    );
  }
}
