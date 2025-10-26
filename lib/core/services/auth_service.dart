import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  // Sign up with email/password
  static Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = credentials.user;
    if (user != null) {
      await user.updateDisplayName(displayName);
      await user.reload();
    }
    return user;
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

  static Future<User?> loginWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final clientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];

      googleProvider.setCustomParameters({'client_id': clientId});

      final UserCredential userCredential = await auth.signInWithPopup(
        googleProvider,
      );
      user = userCredential.user;
    } else {
      final clientId = dotenv.env['GOOGLE_ANDROID_CLIENT_ID'];
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(clientId: clientId);
      final googleUser = await googleSignIn.authenticate(scopeHint: ['email']);
      final googleAuth = googleUser.authentication;

      // Create credential for Firebase
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      user = userCredential.user;
    }

    return user;
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static DateTime getCreationTime() {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    final temp = user.metadata.creationTime!;
    DateTime date = DateTime(temp.year, temp.month);
    return date;
  }
}
