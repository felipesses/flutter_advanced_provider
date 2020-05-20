import 'package:advanced_provider/models/user_model.dart';
import 'package:advanced_provider/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  User user = User();

  final formKey = GlobalKey<FormState>();

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context);

      final user = await auth.signInAnonymously();

      print(user.uid);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signIn(BuildContext context, String email, String pass) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context);
      final user = await auth.signInWithEmailAndPass(email, pass);
      print(user.uid);
    } catch (e) {}
  }

  set email(String value) => user.email = value;
  String get email => user.email;

  set password(String value) => user.password = value;
  String get password => user.password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) => email = value,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                onSaved: (value) => password = value,
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              RaisedButton(
                  child: Text('Sign in'),
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      await _signIn(context, email, password);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
