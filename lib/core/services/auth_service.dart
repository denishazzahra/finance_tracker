import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  // Sign up with email/password
  static Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  // Login with email/password
  static Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credentials = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }
}
