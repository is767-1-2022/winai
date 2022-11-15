import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
  late String _email;
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  _email = newValue!;
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    var msg = "Create user";

                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      msg = "Create user successfully.";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$msg'),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        msg = 'The password provided is too weak.';
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        msg = 'The account already exists for that email.';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$msg'),
                        ),
                      );
                      return;
                    } catch (e) {
                      print(e);
                      msg = 'Error ${e.toString()}';

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$msg'),
                        ),
                      );
                      return;
                    }

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
                child: Text('Create user'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    var msg = '';
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password);
                      msg = "Login successfully.";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$msg'),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        msg = 'No user found for that email.';
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        msg = 'Wrong password provided for that user.';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$msg'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Log in'),
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
