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
    '美しい風景写真',
    '猫の写真',
    'お城 外観',
    '星空',
    'ディズニーランド',
    'スパゲッティ 写真',
  ];

  final ideaImageUrlList = [
    'https://x.hankyu-travel.com/cms_photo_image/image_search_kikan5.php?p_photo_mno=00000-BP19_-04821.jpg',
    'https://mk0yosowalk01fy9de1s.kinstacdn.com/wp-content/uploads/2014/02/%E7%BE%8E%E3%81%97%E3%81%84%E3%83%92%E3%82%99%E3%83%BC%E3%83%81-%E3%83%9B%E3%83%AF%E3%82%A4%E3%83%88%E3%83%98%E3%83%95%E3%82%99%E3%83%B3%E3%83%92%E3%82%99%E3%83%BC%E3%83%81-620x400.jpg',
    'https://tripeditor.com/wp-content/uploads/2018/04/16151051/2016-3.jpg',
    'https://pbs.twimg.com/profile_images/595885946383437826/ZWYWRFHM_400x400.jpg',
    'https://www.taiyo-park.com/photo/mv-img.jpg',
    'https://blog-imgs-42.fc2.com/s/o/r/soranosorakobako/sora2.jpg',
    'https://ure.pia.co.jp/mwimgs/d/4/686/img_d4ff05beb962a5eb07f95f3efe2bafc8323075.jpg',
    'https://video.kurashiru.com/production/videos/051f2807-ac06-4049-8428-7b3008bdb523/compressed_thumbnail_square_large.jpg?1531895042',
  ];

  final famousTitleList = [
    '夜景',
    '90年代 イラスト',
    '景色 幻想的',
    '京都',
    '七夕',
    'ネオン',
  ];

  final famousImageUrlList = [
    'https://static.retrip.jp/spot/bee33900-d3f7-48c2-9d1b-404205ea8d55/images/c864aa00-cb0c-46ab-afe3-807fbdf9d040_m.jpg',
    'https://pbs.twimg.com/profile_images/1217773315407769605/mJsVuI4n_400x400.jpg',
    'https://dnaimg.com/2013/07/16/adnan-bubalo-tuscany-landscape-photography-zsg/002.jpg',
    'https://amd.c.yimg.jp/amd/20200229-00023521-gonline-000-1-view.jpg',
    'https://www.kurobe-unazuki.jp/wp-content/uploads/2018/08/bba20b28ce765961ddad715c2e7b61f9.jpg',
    'https://d1p3yg7ncaw58a.cloudfront.net/projects/2019/11/11/139428.jpg',
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
                color: AppColors.black.withOpacity(0.6),
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
