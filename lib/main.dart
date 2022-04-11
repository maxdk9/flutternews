import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/screens/articles_screen.dart';
import 'package:flutternews/screens/favorites_screen.dart';
import 'package:flutternews/screens/login_screen.dart';
import 'package:flutternews/screens/registration_screen.dart';
import 'package:flutternews/screens/webview_screen.dart';
import 'package:flutternews/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String startRoute=WelcomeScreen.id;
  Firebase.initializeApp().whenComplete(()  {
    if (FirebaseAuth.instance.currentUser != null)
    {
      startRoute=ArticlesScreen.id;
    };
    runApp(MyApp(startRoute: startRoute,));
    }
  );
}

class MyApp extends StatelessWidget {
  final String startRoute;

  const MyApp({Key? key, required this.startRoute}) : super(key: key);
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
              backgroundColor: Colors.blueAccent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey)),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WebviewScreen.id: (context) => WebviewScreen(),
        ArticlesScreen.id: (context) => ArticlesScreen(),
        FavoritesScreen.id: (context) => FavoritesScreen()
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return Scaffold(body: Center(child: Text('Route not found')));
        });
      },
      initialRoute: startRoute,
    );
  }
}
