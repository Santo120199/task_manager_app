import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_manager_app/ui/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key, required this.title }) : super(key: key);

  final String title;
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isVisible = false;

  _SplashScreenState(){
    Timer(const Duration(milliseconds: 2000),(){
      setState(()async {
        await Get.to(()=>LoginPage());
      });
    });

    Timer(const Duration(milliseconds: 10),(){
      setState(() {
        _isVisible = true; 
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue,Colors.blue[200]!],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0,1.0],
          tileMode: TileMode.clamp,
        )
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: ClipOval(
                child: Icon(Icons.android_rounded, size:120),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2.0,
                  offset: Offset(5.0,3.0),
                  spreadRadius: 2.0,
                )
              ]
            ),
          )
        ),
      ),

    );
  }
}