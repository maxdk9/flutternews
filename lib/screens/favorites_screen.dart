import 'package:flutter/material.dart';
import 'package:flutternews/screens/articles_screen.dart';
import 'package:flutternews/widgets/favorites_list_widget.dart';

class FavoritesScreen extends StatefulWidget {
  static const String id = 'favorites_screen';

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAVORITES'),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black12,
        child: InkWell(
          onTap:()=> {
            Navigator.pushNamed(context, ArticlesScreen.id)
          },
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Theme.of(context).accentColor,

                ),
                Text('GOTO NEWS'),
              ],
            ),
          ),
        ),
      ),
      body:
      FavoritesListWidget(),
    );
  }
}
