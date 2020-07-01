import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/select_board_from_url/select_board_from_url_widget.dart';

class EditCrawlingImageArgs {
  const EditCrawlingImageArgs({
    @required this.url,
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });

  final String url;
  final String imageUrl;
  final String title;
  final String description;
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
    return _buildScreen(args, context);
  }

  Widget _buildScreen(EditCrawlingImageArgs args, BuildContext context) {
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
//    });
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

          Navigator.pushNamed(
            context,
            AppRoute.selectBoardFromUrl,
            arguments: SelectBoardFromUrlArguments(
              url: args.url,
              imageUrl: args.imageUrl,
              title: _title,
              description: _description,
            ),
          );
        }
      },
      textColor: AppColors.white,
      color: AppColors.red,
      child: const Text('保存'),
    );
  }
}
