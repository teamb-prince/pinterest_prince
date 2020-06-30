import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/auth_repository.dart';
import 'package:pintersest_clone/model/login_request_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/authentication/login_form_widget/bloc/login_bloc.dart';
import 'package:pintersest_clone/view/authentication/login_form_widget/bloc/login_event.dart';
import 'package:pintersest_clone/view/authentication/login_form_widget/bloc/login_state.dart';

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _id = '';
  String _password = '';
  bool _existError = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
              RepositoryProvider.of<AuthRepository>(context),
            ),
        child: _buildScreen(context));
  }

  Widget _buildScreen(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is SuccessState) {
        Navigator.pushReplacementNamed(context, AppRoute.home);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          title: const Text(
            'ログイン',
            style: TextStyle(color: AppColors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildIdTextForm(),
                _buildPasswordTextForm(),
                _buildConfirmButton(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildIdTextForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'id',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'idを入力してください';
          }
          return null;
        },
        onSaved: (value) {
          _id = value;
        },
      ),
    );
  }

  Widget _buildPasswordTextForm() {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is ErrorState) {
        setState(() {
          _existError = true;
        });
      }
    }, builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'password',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'passwordを入力してください';
            } else if (_existError) {
              return 'idかpasswordが間違っています';
            }
            return null;
          },
          onSaved: (value) {
            _password = value;
          },
        ),
      );
    });
  }

  Widget _buildConfirmButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          final request = LoginRequestModel(
            id: _id,
            password: _password,
          );
          BlocProvider.of<LoginBloc>(context)
              .add(Login(loginRequestModel: request));
        }
      },
      textColor: AppColors.white,
      color: AppColors.red,
      child: const Text('ログイン'),
    );
  }
}
