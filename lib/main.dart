import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pintersest_clone/api/image_api.dart';
import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_bloc.dart';
import 'package:pintersest_clone/view/main/crawling_image/crawling_image_widget.dart';
import 'package:pintersest_clone/view/main/main_navigation_page.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';

import 'api/api_client.dart';
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
        )
      ],
      child: MaterialApp(
        title: 'Pinterest',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) =>
              SearchImageBloc(context.repository<ImageRepository>()),
          child: MainNavigationPage(),
        ),
      ),
    );
  }
}
