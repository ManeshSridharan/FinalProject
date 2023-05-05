import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/widgets/image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );
  final bool isLoading;

  final void Function(
    String email,
    String password,
    String username,
    File image,
    String usertype,
    bool _isLogin,
    BuildContext ctx,
  ) submitFn;

  // const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  _AuthFormState() {
    _currentItemSelected = _options[0];
  }

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true; //Keep track fo login/register page
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _options = [
    'Caretaker',
    'Patient',
  ];
  var _currentItemSelected = "";
  var _userType = "";
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Pick an Image!'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _userType,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (String value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please Enter A Valid Email Address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (String value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Username Must At Least Be 4 Characters Long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'UserName',
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (String value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password Must At Least Be 7 Characters Long';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  if (!_isLogin)
                    DropdownButtonFormField(
                      key: ValueKey('usertype'),
                      isDense: true,
                      isExpanded: false,
                      value: _currentItemSelected,
                      items: _options.map((dropdownItems) {
                        return DropdownMenuItem(
                            value: dropdownItems, child: Text(dropdownItems));
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _currentItemSelected = newValueSelected;
                          _userType = newValueSelected;
                        });
                      },
                      onSaved: (value) {
                        _userType = value;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.red,
                      ),
                      decoration: InputDecoration(
                        labelText: "Type of User",
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(_isLogin
                          ? "Create New Account"
                          : 'Already have an account?'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
