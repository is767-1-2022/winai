import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FifthPage extends StatefulWidget {
  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late String _password;

  bool _hidePassword = true;
  MainAxisAlignment _buttonAlignment = MainAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 5'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  _firstName = newValue!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  _lastName = newValue!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidePassword = false;
                      });

                      Timer.periodic(
                        Duration(seconds: 5),
                        (timer) {
                          setState(() {
                            _hidePassword = true;
                          });
                        },
                      );
                    },
                    icon: Icon(Icons.remove_red_eye),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  _password = newValue!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Processing save : $_firstName $_lastName $_password'),
                      ),
                    );

                    context.read<LoginProfileModel>()
                      ..firstName = _firstName
                      ..lastName = _lastName
                      ..password = _password
                      ..age = 25;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginProfilePage(
                          profile: LoginProfile(
                            _firstName,
                            _lastName,
                            _password,
                            25,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Text('Validate and Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginProfile {
  final String firstName;
  final String lastName;
  final String password;
  final int age;

  const LoginProfile(
    this.firstName,
    this.lastName,
    this.password,
    this.age,
  );
}

class LoginProfileModel extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _password = '';
  int _age = 0;
  get firstName => this._firstName;
  set firstName(value) {
    this._firstName = value;
    notifyListeners();
  }

  get lastName => this._lastName;
  set lastName(value) {
    this._lastName = value;
    notifyListeners();
  }

  get password => this._password;
  set password(value) {
    this._password = value;
    notifyListeners();
  }

  get age => this._age;
  set age(value) {
    this._age = value;
    notifyListeners();
  }
}

class LoginProfilePage extends StatelessWidget {
  const LoginProfilePage({super.key, required this.profile});

  final LoginProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('First name - ${profile.firstName}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Last name - ${profile.lastName}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Password - ******'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Age - ${profile.age}'),
          ),
        ],
      ),
    );
  }
}
