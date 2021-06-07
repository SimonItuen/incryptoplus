import 'package:flutter/material.dart';
import 'package:incryptoplus_app/screens/splash_screen/SplashScreen.dart';
import 'package:incryptoplus_app/screens/webview_screen/WebviewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Incryptoplus',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: appColor,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (_) => SplashScreen(),
        WebviewScreen.routeName: (_) => WebviewScreen()
      },
    );
  }
  MaterialColor appColor = const MaterialColor(
    0xFF0742C0,
    const <int, Color>{
      50: const Color(0xFF0742C0),
      100: const Color(0xFF0742C0),
      200: const Color(0xFF0742C0),
      300: const Color(0xFF0742C0),
      400: const Color(0xFF0742C0),
      500: const Color(0xFF0742C0),
      600: const Color(0xFF0742C0),
      700: const Color(0xFF0742C0),
      800: const Color(0xFF0742C0),
      900: const Color(0xFF0742C0),
    },
  );
}

