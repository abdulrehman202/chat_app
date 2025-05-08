import 'dart:async';

import 'package:chat_app/View/channel_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  _initProcess() async {
    try{
    await Future.delayed(const Duration(seconds: 5));
    
    var ip = await NetworkInfo().getWifiGatewayIP();

    Constants.IP_ADD = ip.toString();
    _moveToFirstScreen(context);}
    catch(e){
      Constants.IP_ADD = '192.168.90.157';
    }
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
        context, MaterialPageRoute(builder: (builder) => ChannelScreen()));
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
