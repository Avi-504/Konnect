import 'dart:io';
import 'package:Konnect/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AuthForm extends StatefulWidget {
  final bool isloading;
  final void Function(String email, String username, String password,
      File imagefile, bool isLogin, BuildContext ctx) submitFn;

  AuthForm(this.submitFn, this.isloading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  var userEmail = '';
  var userName = '';
  var userPassword = '';
  File userImageFile;
  void _pickedImage(File image) {
    userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Select an Image'),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        userEmail.trim(),
        userName.trim(),
        userPassword.trim(),
        userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: _isLogin
                ? MediaQuery.of(context).size.height * 0.3
                : MediaQuery.of(context).size.height * 0.08,
          ),
          TypewriterAnimatedTextKit(
            onTap: () {
              print("Tap Event");
            },
            text: ["Konnect..."],
            textStyle: TextStyle(
              fontSize: 45.0,
              fontFamily: "Agne",
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
            alignment: AlignmentDirectional.topStart, // or Alignment.topLeft
            speed: Duration(seconds: 1),
            totalRepeatCount: 2,
            repeatForever: false,
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Card(
              margin: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!_isLogin) UserImagePicker(_pickedImage),
                          if (!_isLogin)
                            TextFormField(
                              autocorrect: true,
                              textCapitalization: TextCapitalization.words,
                              enableSuggestions: false,
                              key: ValueKey('UserName'),
                              onSaved: (newValue) {
                                userName = newValue;
                              },
                              decoration: InputDecoration(
                                labelText: 'User Name',
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.length < 2) {
                                  return 'User Name must be 3 characters long.';
                                }
                                return null;
                              },
                            ),
                          TextFormField(
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            enableSuggestions: false,
                            key: ValueKey('Email'),
                            onSaved: (newValue) {
                              userEmail = newValue;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Please Enter a Valid Email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            key: ValueKey('Password'),
                            onSaved: (newValue) {
                              userPassword = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Password must be 8 characters long';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          if (widget.isloading) CircularProgressIndicator(),
                          if (!widget.isloading)
                            RaisedButton(
                                child: Text(_isLogin ? 'Login' : 'SignUp'),
                                onPressed: _trySubmit),
                          if (!widget.isloading)
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create An Account'
                                  : 'Already have a Account'),
                            ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
