import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:liveDemo/Providers/Auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({
    Key key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: [
              // email
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (String value) {
                  _passwordFocusNode.requestFocus();
                },
                validator: (String value) {
                  if (EmailValidator.validate(value)) {
                    return null;
                  }
                  return 'Email is not valid';
                },
                onSaved: (String value) {
                  _email = value;
                },
              ),
              TextFormField(
                  decoration: InputDecoration(hintText: "Password"),
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  onSaved: (String value) {
                    _password = value;
                  },
                  validator: (String value) {
                    if (value.length >= 8) {
                      return null;
                    }
                    return 'Password too short';
                  }),
            ],
          ),
        ),
        RaisedButton(
          child: Text('Login'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              auth.login(_email, _password);
            }
          },
        )
      ],
    );
  }
}
