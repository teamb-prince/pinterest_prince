import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pintersest_clone/api/board_api.dart';
import 'package:pintersest_clone/api/image_api.dart';
import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/authentication//login_top_widget/login_top_widget.dart';
import 'package:pintersest_clone/view/authentication//login_widget/login_widget.dart';
import 'package:pintersest_clone/view/authentication//sign_up_widget/create_account_widget.dart';
import 'package:pintersest_clone/view/main/crawling_image/crawling_image_widget.dart';
import 'package:pintersest_clone/view/main/create_pin_widget/create_pin_widget.dart';
import 'package:pintersest_clone/view/main/input_url_widget/input_url_widget.dart';
import 'package:pintersest_clone/view/main/main_navigation_page.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/select_board_from_url_widget.dart';
import 'package:pintersest_clone/view/main/user_detail_widget/user_detail_widget.dart';

import 'api/api_client.dart';
import 'data/boards_repository.dart';
import 'data/image_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  ApiClient _apiClient = ApiClient(Client());

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ImageRepository>(
          create: (_) => ImageRepository(DefaultImageApi(_apiClient)),
        ),
        RepositoryProvider<PinsRepository>(
          create: (_) => PinsRepository(DefaultPinsApi(_apiClient)),
        ),
        RepositoryProvider<BoardsRepository>(
          create: (_) => BoardsRepository(DefaultBoardsApi(_apiClient)),
        )
      ],
      child: MaterialApp(
          title: 'Pinterest',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: AppRoute.home,
          routes: {
            AppRoute.home: (context) => MainNavigationPage(),
            AppRoute.pinDetail: (context) => PinDetailWidget(),
            AppRoute.userDetail: (context) => UserDetailWidget(),
            AppRoute.inputUrl: (context) => InputUrlWidget(),
            AppRoute.crawlingImage: (context) => CrawlingImageWidget(),
            AppRoute.loginTop: (context) => LoginTopWidget(),
            AppRoute.createAccount: (context) => SignUpWidget(),
            AppRoute.login: (context) => LoginWidget(),
            AppRoute.createPin: (context) => CreatePinWidget(),
            AppRoute.selectBoardFromUrl: (context) =>
                SelectBoardFromUrlWidget(),
          }),
    );
  }
}
