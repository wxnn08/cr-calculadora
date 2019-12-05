import 'package:calculadora_cr/screens/home_screen.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CR Simulator',
      theme: ThemeData(
        primaryColor: Color(0xFF4E8EF2),
        accentColor: Color(0xFFFF08AC),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF4E8EF2),
          textTheme: ButtonTextTheme.primary,
        ),
        backgroundColor: Color(0xFFD5D5F3),
        floatingActionButtonTheme: FloatingActionButtonThemeData(),
      ),
      home: CustomSplash(
        imagePath: 'assets/icon/icon.png',
        backGroundColor: Colors.white,
        animationEffect: 'zoom-out',
        logoSize: 200,
        home: HomeScreen(),
        duration: 2500,
        type: CustomSplashType.StaticDuration,
      ),
    );
  }
}
