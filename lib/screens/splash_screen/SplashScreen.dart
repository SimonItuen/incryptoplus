import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:incryptoplus_app/screens/webview_screen/WebviewScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;
  bool textVisible=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 166));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        animationStatus = status;
      });
    Future.delayed(Duration.zero, () async{
      /*await _animationController.forward();
      await _animationController.reverse();
      await _animationController.forward();
      await _animationController.reverse();
      await _animationController.forward();
      setState(() {
        textVisible=true;
      });
      await _animationController.reverse();*/
      Future.delayed(Duration(milliseconds: 2000), (){
        Navigator.of(context).pushReplacementNamed(WebviewScreen.routeName);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          /*Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()..setEntry(2,3,0.002)..rotateY(pi * _animation.value),*/
          Container(
            child: Center(child: Image.asset('assets/images/logo.png',width: MediaQuery.of(context).size.width*0.4,)),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 166),
            opacity: 1,
            child: Padding(
              padding: const EdgeInsets.only(top:8),
              child: Text('Incryptoplus', style: TextStyle(color:Colors.black, fontSize: 28),),
            ),
          )
        ],
      ),
    );
  }
}
