import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String? _name, _email, _password;
  File? _image;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _title(),
              _profileImageWidget(),
              _registrationForm(),
              _registerButton(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _title() {
    return const Text(
      "Paged & Fit",
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black),
    );
  }

  Widget _registrationForm() {
    return Container(
      height: _deviceHeight! * 0.30,
      child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _nameTextField(),
              _emailForm(),
              _passwordForm(),
            ],
          )),
    );
  }

  Widget _profileImageWidget() {
    var _imageProvider = _image != null
        ? FileImage(_image!)
        : const NetworkImage("https://i.pravatar.cc/300");

    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then((_result) {
          setState(() {
            _image = File(_result!.files.first.path!);
          });
        });
      },
      child: Container(
        height: _deviceHeight! * 0.15,
        width: _deviceHeight! * 0.15,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: _imageProvider as ImageProvider,
        )),
      ),
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

  Widget _nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Name...'),
      validator: (_value) =>
          _value!.length > 0 ? null : "please enter a valid name",
      onSaved: (_value) {
        setState(() {
          _name = _value;
        });
      },
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

  Widget _registerButton() {
    return MaterialButton(
      onPressed: () {},
      minWidth: _deviceWidth! * 0.50,
      height: _deviceHeight! * 0.05,
      color: Colors.red,
      child: const Text(
        "Register",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
