import 'package:flutter/material.dart';
import 'package:flutternews/screens/favorites_screen.dart';
import 'package:flutternews/widgets/article_list_widget.dart';

class ArticlesScreen extends StatefulWidget {
  static const String id = 'article_screen';
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NEWS'),
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black12,
          child: InkWell(
            onTap:()=> {
              Navigator.pushReplacementNamed(context, FavoritesScreen.id)
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Theme.of(context).accentColor,

                  ),
                  Text('GO TO FAVORITES'),
                ],
              ),
            ),
          ),
        ),
        body:
            ArticleListWidget(),
        );
  }

}
