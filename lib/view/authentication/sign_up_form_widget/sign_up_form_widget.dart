import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/auth_repository.dart';
import 'package:pintersest_clone/model/sign_up_request_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/authentication/sign_up_form_widget/bloc/sign_up_bloc.dart';
import 'package:pintersest_clone/view/authentication/sign_up_form_widget/bloc/sign_up_event.dart';
import 'package:pintersest_clone/view/authentication/sign_up_form_widget/bloc/sign_up_state.dart';

class SignUpFormWidget extends StatefulWidget {
  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  String _id = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _existSameId = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(
              RepositoryProvider.of<AuthRepository>(context),
            ),
        child: _buildScreen(context));
  }

  Widget _buildScreen(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SuccessState) {
        final userModel = state.userModel;
        print(userModel.id);
        Navigator.pushReplacementNamed(context, AppRoute.loginTop);
      } else if (state is ExistUserState) {
        setState(() {
          _existSameId = true;
          _formKey.currentState.validate();
        });
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
            '登録',
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
                _buildIdTextForm(context),
                _buildEmailTextForm(),
                _buildPasswordTextForm(),
                _buildConfirmPasswordTextForm(),
                _buildConfirmButton(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildIdTextForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        key: const Key('id_text_form'),
        decoration: const InputDecoration(
          labelText: 'id',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'idを入力してください';
          } else if (_existSameId) {
            return '同じidを使用しているユーザーがいます';
          }
          return null;
        },
        onSaved: (value) {
          _id = value;
        },
      ),
    );
  }

  Widget _buildEmailTextForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        key: const Key('email_text_form'),
        decoration: const InputDecoration(
          labelText: 'email',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'emailを入力してください';
          } else if (!EmailValidator.validate(value)) {
            return '正しいemailを入力してください';
          }
          return null;
        },
        onSaved: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildPasswordTextForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        controller: _passwordController,
        key: const Key('password_text_form'),
        decoration: InputDecoration(
          labelText: 'password',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        obscureText: _obscurePassword,
        validator: (value) {
          if (value.isEmpty) {
            return 'passwordを入力してください';
          } else if (value.length < 5) {
            return 'パスワードが短すぎます';
          }
          return null;
        },
        onSaved: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordTextForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        key: const Key('confirm_password_text_form'),
        decoration: InputDecoration(
          labelText: 'password',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(_obscureConfirmPassword
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
        ),
        obscureText: _obscureConfirmPassword,
        validator: (value) {
          if (value.isEmpty) {
            return '確認用のpasswordを入力してください';
          } else if (value.length < 5) {
            return 'パスワードが短すぎます';
          } else if (value != _passwordController.text) {
            return 'パスワードが一致していません';
          }
          return null;
        },
        onSaved: (value) {
          _confirmPassword = value;
        },
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return RaisedButton(
      key: const Key('confirm_button'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: () {
        setState(() {
          _existSameId = false;
        });
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          final request = SignUpRequestModel(
            id: _id,
            email: _email,
            password: _password,
            confirmPassword: _confirmPassword,
          );
          BlocProvider.of<SignUpBloc>(context)
              .add(SignUp(signUpRequestModel: request));
        }
      },
      textColor: AppColors.white,
      color: AppColors.red,
      child: Text('保存'),
    );
  }
}
