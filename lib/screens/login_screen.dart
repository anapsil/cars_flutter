import 'package:cars_flutter/models/api_response.dart';
import 'package:cars_flutter/models/user.dart';
import 'package:cars_flutter/network/login_api.dart';
import 'package:cars_flutter/screens/home_screen.dart';
import 'package:cars_flutter/utils/alert.dart';
import 'package:cars_flutter/utils/nav.dart';
import 'package:cars_flutter/widgets/app_button.dart';
import 'package:cars_flutter/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final _focusPassword = FocusNode();
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();

    Future<User> future = User.get();
    future.then((user) {
      if (user != null) {
        push(context, HomeScreen(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carros")),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          AppTextField("Login", "Digite o login",
              controller: _loginController,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusPassword),
          SizedBox(height: 16),
          AppTextField("Senha", "Digite a senha",
              password: true,
              controller: _senhaController,
              validator: _validatePassword,
              keyboardType: TextInputType.number,
              focusNode: _focusPassword),
          SizedBox(height: 16),
          AppButton("Login", onPressed: _onClickLogin, showProgress: _showProgress)
        ],
      ),
    );
  }

  _onClickLogin() async {
    bool formValid = _formKey.currentState.validate();

    if (!formValid) {
      return;
    }

    String login = _loginController.text;
    String password = _senhaController.text;

    setState(() {
      _showProgress = true;
    });

    final ApiResponse response = await LoginApi.login(login, password);

    if (response.success) {
      push(context, HomeScreen(), replace: true);
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Digite a senha";
    }
    if (value.length < 3) {
      return "A senha deve ter 3 caracteres";
    }
    return null;
  }
}
