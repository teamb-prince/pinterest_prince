import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/view/main/search_pins_list/search_pins_list.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _searchTextController = TextEditingController();

  final String ideaText = 'おすすめのアイデア';
  final String popularText = 'Pinterest で人気のピン';

  final ideaTitleList = [
    '美しい砂漠',
    'ビーチの壁紙',
    '世界遺産',
    '猫の写真',
    'お城 外観',
    '星空',
    'ディズニーランド',
    'メイクアップ',
  ];

  final ideaImageUrlList = [
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/desert_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/beach_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/heritage_topic.jpeg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/cat_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/castle_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/star_topic.jpeg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/disney_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/makeup_topic.gif',
  ];

  final ideaLabelList = [
    'Desert',
    '',
    '',
    'Cat',
    'Castle',
    'Starry Sky',
    '',
    '',
  ];

  final popularTitleList = [
    '夜景',
    '90年代 イラスト',
    '景色 幻想的',
    '京都',
    '夏祭り',
    'ネオン',
  ];

  final popularImageUrlList = [
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/nightview_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/90_illust_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/keshiki_topic.jpeg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/kyoto_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/matsuri_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/neon_topic.jpg',
  ];

  final popularLabelList = [
    '',
    'Illust',
    '',
    '',
    'Matsuri',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildSearchBar(context),
              _buildBlockTitle(ideaText),
              _buildBlockField(
                  ideaTitleList, ideaImageUrlList, ideaLabelList, context),
              _buildBlockTitle(popularText),
              _buildBlockField(popularTitleList, popularImageUrlList,
                  popularLabelList, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: AppColors.black,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text(
                  'アイデアを検索',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                Icons.camera_alt,
                color: AppColors.black,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlockTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildBlockField(List<String> titleList, List<String> urlList,
      List<String> labelList, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 330,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            titleList.length,
            (index) {
              return _buildTopicCard(
                  index, titleList, urlList, labelList, context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopicCard(int index, List<String> titleList,
      List<String> urlList, List<String> labelList, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            _buildTopicImage(urlList[index]),
            Container(
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            _buildTopicText(titleList[index]),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoute.searchPinsList,
            arguments: SearchPinsListWidgetArguments(
              label: labelList[index],
              title: titleList[index],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopicText(String text) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTopicImage(String imageUrl) {
    return Container(
      width: 300,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
