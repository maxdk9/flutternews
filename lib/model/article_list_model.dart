import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutternews/api_client/api_client.dart';
import 'package:flutternews/model/article.dart';

import 'article.dart';

class ArticleListModel extends ChangeNotifier{
  final ApiClient _apiClient=ApiClient();
  var _articles=<Article>[];
  List<Article> get articles=>List.unmodifiable(_articles);
  Timer? queryTimer;
  String? _searchQuery;

  Future<void> loadArticles() async{
    final ArticleResponse response=await _apiClient.newsHeadlinesDay();
    _articles.addAll(response.articles);
  }

  Future <void> SearchArticles(String query) async {
    queryTimer?.cancel();
    print('Query is $query');
    queryTimer=Timer(const Duration(seconds: 1 ),() async{
      print('Query is $query');
      if(query==_searchQuery){
        return;
      }
      if(query.isEmpty){
        final ArticleResponse response=await _apiClient.newsHeadlinesDay();
        _articles.clear();
        _articles.addAll(response.articles);
        return;
      }
      if(query.length<2){
        return;
      }
      _searchQuery=query;
      final ArticleResponse response=await _apiClient.newsSearchDay(query);
      _articles.clear();
      _articles.addAll(response.articles);
    });

  }

  void UpdateFavorites(List<Article> favorites) {
    for(Article article in _articles){
       article.favorite=favorites.where((element) => element.uid==article.uid).toList().length>0;

    }
  }
}