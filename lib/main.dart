import 'package:flutter/material.dart';
import 'package:flutternews/screens/login_screen.dart';
import 'package:flutternews/screens/main_screen.dart';
import 'package:flutternews/screens/registration_screen.dart';
import 'package:flutternews/screens/welcome_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'News Client',
    theme: ThemeData(
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueAccent,
    ),

    primarySwatch: Colors.blue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor:  Colors.blueAccent,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey
    )
    ),


    routes: {
      WelcomeScreen.id:(context)=>WelcomeScreen(),
      LoginScreen.id:(context)=>LoginScreen(),
      RegistrationScreen.id:(context)=>RegistrationScreen(),
      MainScreen.id:(context)=>MainScreen()
    },
    onGenerateRoute: (RouteSettings settings){
    return MaterialPageRoute(builder: (context){
    return
    Scaffold(
    body:Center(child: Text('Route not found')));
    });
    },
    initialRoute: WelcomeScreen.id,
    );
  }
}

