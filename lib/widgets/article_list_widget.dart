
import 'package:flutter/material.dart';
import 'package:flutternews/database/db_service.dart';
import 'package:flutternews/model/article_list_model.dart';
import 'package:flutternews/model/article.dart';


import 'article_item_widget.dart';

class ArticleListWidget extends StatefulWidget {
  const ArticleListWidget({Key? key}) : super(key: key);

  @override
  _ArticleListWidgetState createState() => _ArticleListWidgetState();
}

class _ArticleListWidgetState extends State<ArticleListWidget> {
  final ArticleListModel model=ArticleListModel();
  final DatabaseService databaseService=DatabaseService();

  void changeArticleFavorites(Article article) async{
    if(article.favorite){
      await databaseService.addFavorite(article);
    }
    else{
      await databaseService.deleteFavorite(article);
    }
  }

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  void loadArticles() async{
    await model.loadArticles();
    await databaseService.loadFavorites();
    model.UpdateFavorites(databaseService.articles);
    setState(() {

    });
  }

  void searchArticles(String query) async{
    await model.SearchArticles(query);
    model.UpdateFavorites(databaseService.articles);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.articles.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              Article article=model.articles[index];
              return ArticleItemWidget(article: article,changeArticleFavorites: changeArticleFavorites,);
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: searchArticles,
            decoration: InputDecoration(filled: true,fillColor: Colors.white.withAlpha(235),border: OutlineInputBorder()),
          ),
        )
      ],
    );
  }


}


