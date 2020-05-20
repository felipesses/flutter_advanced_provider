import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.uid,
    this.email,
    this.password,
  });
  final String uid;
  String email;
  String password;
}
