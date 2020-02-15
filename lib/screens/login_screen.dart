import 'dart:ui';

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
          AppTextField(
            "Senha",
            "Digite a senha",
            password: true,
            controller: _senhaController,
            validator: _validatePassword,
            keyboardType: TextInputType.number,
            focusNode: _focusPassword,
          ),
          SizedBox(height: 16),
          AppButton("Login", onPressed: _onClickLogin)
        ],
      ),
    );
  }

  _onClickLogin() {
    bool formValid = _formKey.currentState.validate();

    if (!formValid) {
      return;
    }

    String login = _loginController.text;
    String senha = _senhaController.text;

    print("Login: $login, Senha: $senha");
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
