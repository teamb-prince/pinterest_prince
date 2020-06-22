import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_bloc.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_state.dart';

import 'bloc/select_board_from_url_event.dart';

//TODO とりあえずこっちに対応
class SelectBoardFromUrlArguments {
  SelectBoardFromUrlArguments(
      {@required this.imageUrl, this.linkUrl}); //TODO ここの設計は要相談

  final String imageUrl;
  final String linkUrl;
}

class SelectBoardFromUrlWidget extends StatelessWidget {
  static const double _iconImageSize = 40;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as SelectBoardFromUrlArguments;

    return BlocProvider(
      create: (context) => SelectBoardFromUrlBloc(
        RepositoryProvider.of<BoardsRepository>(context),
        RepositoryProvider.of<PinsRepository>(context),
      )..add(LoadData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ボードを選択', style: TextStyle(color: AppColors.black)),
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData(color: AppColors.black),
          brightness: Brightness.light,
          elevation: 0,
        ),
        body: _buildScreen(args),
      ),
    );
  }

  Widget _buildScreen(SelectBoardFromUrlArguments args) {
    return Builder(builder: (context) {
      return BlocBuilder<SelectBoardFromUrlBloc, SelectBoardFromUrlState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final boards = state.boards;

            return Container(
              child: ListView.builder(
                itemBuilder: (context, index) => index == boards.length
                    ? _buildAddNewBoardButton()
                    : _buildBoardTile(context, boards[index], args),
                itemCount: boards.length + 1,
              ),
            );
          }
          return Container();
        },
      );
    });
  }

  Widget _buildBoardTile(BuildContext context, BoardModel board,
      SelectBoardFromUrlArguments args) {
    return BlocBuilder<SelectBoardFromUrlBloc, SelectBoardFromUrlState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          final request = PinRequestModel(
            userId: 'mrypq',
            originalUserId: 'mrypq',
            url: args.linkUrl,
            imageUrl: args.imageUrl,
            boardId: board.id,
            description: 'てきとう',
          );
          //TODO ここでstateのSavedPinにstateがなったらpopuntilしたいのだが謎
          BlocProvider.of<SelectBoardFromUrlBloc>(context)
              .add(SavePin(pinRequestModel: request));
          Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
        },
        child: _buildTile(board),
      );
    });
  }

  Widget _buildTile(BoardModel board) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          SizedBox(
              height: _iconImageSize,
              width: _iconImageSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                    // 適当な画像です。
                    'https://d1fv7zhxzrl2y7.cloudfront.net/articlecontents/103160/dobai_AdobeStock_211353756.jpeg?1555031349',
                    fit: BoxFit.cover),
              )),
          const SizedBox(width: 16),
          Text(board.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAddNewBoardButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            backgroundColor: AppColors.red,
            child: Icon(Icons.add, color: AppColors.white),
          ),
          const SizedBox(width: 16),
          const Text('新規ボードを作成',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
