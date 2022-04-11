import 'package:flutter/material.dart';
import 'package:flutternews/database/db_service.dart';
import 'package:flutternews/model/article.dart';
import 'article_item_widget.dart';

class FavoritesListWidget extends StatefulWidget {
  const FavoritesListWidget({Key? key}) : super(key: key);

  @override
  _FavoritesListWidgetState createState() => _FavoritesListWidgetState();
}

class _FavoritesListWidgetState extends State<FavoritesListWidget> {
  final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(() {});
  }

  void loadFavorites() async {
    await databaseService.loadFavorites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: databaseService.articles.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              Article article = databaseService.articles[index];
              return ArticleItemWidget(
                article: article,
                changeArticleFavorites: changeArticleFavorites,
              );
            }),
      ],
    );
  }

  void changeArticleFavorites(Article article) async {
    await databaseService.deleteFavorite(article);
    await databaseService.loadFavorites();
    setState(() {});
  }
}
