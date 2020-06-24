import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_bloc.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_event.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_state.dart';

class EditCrawlingImageArgs {
  const EditCrawlingImageArgs({
    @required this.url,
    @required this.imageUrl,
    @required this.title,
    @required this.description,
    @required this.boardId,
  });

  final String url;
  final String imageUrl;
  final String title;
  final String description;
  final String boardId;
}

class EditCrawlingImageWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as EditCrawlingImageArgs;

    _title = args.title;
    _description = args.description;
    return BlocProvider(
      create: (context) => EditCrawlingImageBloc(
        RepositoryProvider.of<PinsRepository>(context),
      ),
      child: _buildScreen(args, context),
    );
  }

  Widget _buildScreen(EditCrawlingImageArgs args, BuildContext context) {
    return BlocConsumer<EditCrawlingImageBloc, EditCrawlingImageState>(
        listener: (context, state) {
      if (state is SavedPinState) {
        Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          title: const Text(
            'ピンのタイトルを編集',
            style: TextStyle(color: AppColors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildTitleTextForm(args),
                _buildDescriptionTextForm(args),
                _buildConfirmButton(args, context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTitleTextForm(EditCrawlingImageArgs args) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'タイトル',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return '画像のタイトルを入力してください';
          }
          return null;
        },
        initialValue: args.title,
        onSaved: (value) {
          _title = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextForm(EditCrawlingImageArgs args) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'コメント',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return '画像のコメントを入力してください';
          }
          return null;
        },
        initialValue: args.description,
        onSaved: (value) {
          _description = value;
        },
      ),
    );
  }

  Widget _buildConfirmButton(EditCrawlingImageArgs args, BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          final request = PinRequestModel(
            userId: 'mrypq',
            originalUserId: 'mrypq',
            url: args.url,
            imageUrl: args.imageUrl,
            boardId: args.boardId,
            title: _title,
            description: _description,
          );
          BlocProvider.of<EditCrawlingImageBloc>(context)
              .add(SavePin(pinRequestModel: request));
        }
      },
      textColor: AppColors.white,
      color: AppColors.red,
      child: const Text('保存'),
    );
  }
}
