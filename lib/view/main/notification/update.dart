import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/view/main/search_pins_list/search_pins_list.dart';

class UpdateWidget extends StatelessWidget {
  final String text1 = '「スパゲッティ」のトレンドのピン一覧を見てみましょう！';
  final String text2 = '「90年代 アニメ」「スポーツカー」など、おすすめの検索キーワードをご紹介';
  final String text3 = '「夏祭り」に関する新着おすすめアイデアが14件あります';
  final String text4 = '「宇宙」に関連する「銀河」「宇宙 綺麗」などの検索キーワード';
  final String text5 = '人気のキーワードで検索して、素敵なアイデアを保存しましょう！';
  final String text6 = 'アイデアの保存をお忘れなく！今週のおすすめのアイデアをご紹介';

  final ideaList1 = [
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/b9a5adf5-68f0-493a-bd48-dcd7e9816519',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/e343c75a-70e5-4616-a03d-6e98b7a0f032',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/db66fd32-582d-494e-9fb0-918f459cc39b',
  ];

  final ideaList2 = [
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/matsuri/004.png',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/matsuri/000.jpeg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/matsuri/006.png',
  ];

  final ideaList3 = [
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/thumb/6b5570665c5856bfca57d831d14ef516.jpeg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/thumb/ZRw.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/thumb/2eaaf8b0ae33f1b2.jpg',
  ];

  final keywordList1 = [
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/90/002.png',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/512714e0-8ab3-4841-b7de-46760b09346b',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/aca5dd83-9561-47ba-b87f-26dce30da62c',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/002.png',
  ];

  final titleList1 = ['90年代 アニメ', 'スポーツカー', 'キャンドル', '星空  風景'];
  final labelList1 = ['Illust', 'Car', 'Candle', 'Starry Sky'];

  final keywordList2 = [
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/726459fa-7829-4450-9657-320d3b826a37',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/5875fcb3-b24d-4325-82d1-955586b161e3',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/b4cde3bd-cdcf-42aa-91d7-0696b7688644',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/15599894-7540-4d85-95cb-434660e5c409',
  ];

  final titleList2 = ['宇宙', '銀河', '宇宙 綺麗', '銀河系'];
  final labelList2 = ['Nebula', 'Nebula', 'Nebula', 'Nebula'];

  final keywordList3 = [
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/thumb/img_history.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/thumb/26433173610_10a5654b94_o.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/thumb/main.jpg',
    'https://bucket-pinterest-001.s3.ap-northeast-1.amazonaws.com/thumb/eac29b89-93e1-4297-b521-504d2b2cba2f',
  ];

  final titleList3 = ['世界遺産', 'ディズニー 夜景', '絶品グルメ', 'オフィス'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildFeatureText(text1, 1),
          _buildIdeaField(ideaList1, 'スパゲッティ', 'Spaghetti', context),
          _buildFeatureText(text2, 2),
          _buildKeyWordField(keywordList1, titleList1, labelList1, context),
          _buildFeatureText(text3, 4),
          _buildIdeaField(ideaList2, '夏祭り', 'Matsuri', context),
          _buildFeatureText(text4, 4),
          _buildKeyWordField(keywordList2, titleList2, labelList2, context),
          _buildFeatureText(text5, 8),
          _buildKeyWordField(keywordList3, titleList3, labelList1, context),
          _buildFeatureText(text6, 9),
          _buildIdeaField(ideaList3, 'おすすめ', '', context),
        ],
      ),
    );
  }

  Widget _buildIdeaField(
      List<String> imageUrl, String title, String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
      ),
      child: GestureDetector(
        child: Container(
          width: 402,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIdeaCardImage(imageUrl, 0),
                _buildIdeaCardImage(imageUrl, 1),
                _buildIdeaCardImage(imageUrl, 2),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoute.searchPinsList,
            arguments: SearchPinsListWidgetArguments(
              label: label,
              title: title,
            ),
          );
        },
      ),
    );
  }

  Widget _buildIdeaCardImage(List<String> imageUrl, int index) {
    return Container(
      height: 200,
      width: 133,
      child: Image.network(
        imageUrl[index],
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildKeyWordField(List<String> imageUrl, List<String> title,
      List<String> labelList, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
      ),
      child: Container(
        width: 402,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildKeywordCardImage(
                      imageUrl, title, labelList, 0, context),
                  _buildKeywordCardImage(
                      imageUrl, title, labelList, 1, context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildKeywordCardImage(
                      imageUrl, title, labelList, 2, context),
                  _buildKeywordCardImage(
                      imageUrl, title, labelList, 3, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeywordCardImage(List<String> imageUrl, List<String> title,
      List<String> labelList, int index, BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            height: 99,
            width: 200,
            child: Image.network(
              imageUrl[index],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 99,
            width: 200,
            color: AppColors.black.withOpacity(0.5),
            child: Center(
              child: Text(
                title[index],
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.searchPinsList,
          arguments: SearchPinsListWidgetArguments(
            label: labelList[index],
            title: title[index],
          ),
        );
      },
    );
  }

  Widget _buildFeatureText(String text, int day) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '  $day日前',
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 12,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
