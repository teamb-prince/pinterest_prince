import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/model/board_request_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common_widget/base_text_field.dart';

import 'bloc/bloc.dart';

class CreateBoardWidget extends StatefulWidget {
  @override
  _CreateBoardWidgetState createState() => _CreateBoardWidgetState();
}

class _CreateBoardWidgetState extends State<CreateBoardWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateBoardBloc>(
      create: (context) =>
          CreateBoardBloc(context.repository<BoardsRepository>()),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return BlocConsumer<CreateBoardBloc, CreateBoardState>(
        listener: (context, state) {
      if (state is SuccessState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('新規ボードを作成',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black)),
          iconTheme: const IconThemeData(color: AppColors.black),
          brightness: Brightness.light,
          backgroundColor: AppColors.white,
          elevation: 0,
          actions: <Widget>[
            _buildCreateButton(context),
          ],
        ),
        body: _buildTextField(context),
      );
    });
  }

  Widget _buildCreateButton(BuildContext context) {
    return BlocBuilder<CreateBoardBloc, CreateBoardState>(
        builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: FlatButton(
          onPressed: () {
            final boardRequest =
                BoardRequestModel(name: _textEditingController.text);

            BlocProvider.of<CreateBoardBloc>(context)
                .add(SaveBoard(boardRequest));
          },
          color: AppColors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Text('作成', style: TextStyle(color: AppColors.white)),
        ),
      );
    });
  }

  Widget _buildTextField(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: BaseTextField(
          title: 'ボード名',
          hintText: '追加',
          textEditingController: _textEditingController,
        ));
  }
}
