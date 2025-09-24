import 'package:flutter/material.dart';
import 'package:my_blog_app/screens/authenticate/login.dart';
import 'package:my_blog_app/screens/authenticate/sign_up.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showLogin = true;

  void toggle() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogin ? Login(onTap: toggle) : SignUp(onTap: toggle);
  }
}