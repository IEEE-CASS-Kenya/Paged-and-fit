import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LogIn> {
  double? _deviceWidth, _deviceHeight;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth! * 0.05,
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleWidget(),
              _loginForm(),
              _loginButton(),
              registerPageLink(),
            ],
          )),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      'Paged & Fit',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _loginUser,
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
      child: const Text(
        'Log in',
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }

  Widget registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Don't have an account?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  void _loginUser() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
    }
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 0.20,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_emailForm(), _passwordForm()],
          )),
    );
  }

  Widget _emailForm() {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Email...'),
      onSaved: (_value) {
        setState(() {
          _email = _value;
        });
      },
      validator: (_value) {
        bool _result = _value!.contains(
          RegExp(
              r"^[a-zA-Z0-9.! #$%&'*+/=? ^_`{|}~-]+@[a-zA-Z0-9-]+(?:\. [a-zA-Z0-9-]+)*$"),
        );
        return _result ? null : "Please enter a valid email address";
      },
    );
  }

  Widget _passwordForm() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Password...'),
      onSaved: (_value) {
        setState(() {
          _password = _value;
        });
      },
      validator: (_value) => _value!.length > 6
          ? null
          : "Please enter a password with more than 6 characters",
    );
  }
}
