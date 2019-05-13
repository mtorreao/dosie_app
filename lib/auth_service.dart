import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final AuthService _authService = new AuthService._internal();

  FirebaseUser user;

  factory AuthService() {
    return _authService;
  }

  AuthService._internal();

  Future<FirebaseUser> getUser() async {
    if (user == null) {
      user = await FirebaseAuth.instance.signInAnonymously();
    }

    return user;
  }
}
