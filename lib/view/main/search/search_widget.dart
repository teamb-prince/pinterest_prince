import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:flutter/rendering.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _searchTextController = TextEditingController();

  final String ideaText = 'おすすめのアイデア';
  final String famousText = 'Pinterest で人気のピン';

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

  final famousTitleList = [
    '夜景',
    '90年代 イラスト',
    '景色 幻想的',
    '京都',
    '夏祭り',
    'ネオン',
  ];

  final famousImageUrlList = [
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/nightview_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/90_illust_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/keshiki_topic.jpeg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/kyoto_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/matsuri_topic.jpg',
    'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/neon_topic.jpg',
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
              _buildBlockField(ideaTitleList, ideaImageUrlList),
              _buildBlockTitle(famousText),
              _buildBlockField(famousTitleList, famousImageUrlList),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: TextField(
        controller: _searchTextController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.black,
            size: 24,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          fillColor: AppColors.grey,
          filled: true,
          hintText: 'アイデアを検索',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: AppColors.black,
              size: 30,
            ),
            onPressed: () {
              // TODO boardに追加画面（カメラからである必要あるか？）
              print('tap camera');
              // Navigator.pushNamed(context, AppRoute.createBoard).then((_) {
              //   BlocProvider.of<BoardsListBloc>(context).add(LoadData());
              // });
            },
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

  Widget _buildBlockField(List<String> titleList, List<String> urlList) {
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
              return _buildTopicCard(index, titleList, urlList);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopicCard(
      int index, List<String> titleList, List<String> urlList) {
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
          // TODO ピン一覧へ遷移
          print('tap topic');
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
