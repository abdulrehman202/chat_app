import 'dart:async';

import 'package:chat_app/View/chat_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  _initProcess() async {
    await Future.delayed(const Duration(seconds: 5));
    _moveToFirstScreen(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initProcess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context)
    );
  }

  _moveToFirstScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (builder) => ChatScreen()));
  }

  Widget _body(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Constants.getParentWidth(context) * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Constants.SPLASH_ICON_PATH,
            ),
            Text(Constants.APP_NAME, style: const TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}
