import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (!isLoggedIn) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
