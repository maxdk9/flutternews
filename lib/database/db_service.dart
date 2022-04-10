import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutternews/model/article.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  static const Uuid _uuid = Uuid();

  final CollectionReference _favoritesCollection = Firestore.instance
      .collection('favorites');
  final _auth = FirebaseAuth.instance;
  List<Article> _articles = <Article>[];

  List<Article> get articles => List.unmodifiable(_articles);


  static String generateUID(String url) {
    return _uuid.v5(Uuid.NAMESPACE_URL, url);
  }


  Future addFavorite(Article article) async {
    FirebaseUser user = await _auth.currentUser();
    CollectionReference _favoritesUserCollection = Firestore.instance
        .collection(user.uid);
    _articles.add(article);
    return await _favoritesUserCollection.document(article.uid).setData(
        article.toJson());
  }

  Future deleteFavorite(Article article) async {
    FirebaseUser user = await _auth.currentUser();
    CollectionReference _favoritesUserCollection = Firestore.instance
        .collection(user.uid);
    if(_articles.contains(article)){
      _articles.remove(article);
    }
    return await _favoritesUserCollection.document(article.uid).delete();
  }

  Future loadFavorites() async{
    FirebaseUser user = await _auth.currentUser();
    CollectionReference _favoritesUserCollection = Firestore.instance
        .collection(user.uid);
    QuerySnapshot snapshot=await _favoritesUserCollection.getDocuments();
    List<Article> res= snapshot.documents.map((DocumentSnapshot e) => Article.fromJson(e.data)).toList();
    _articles.clear();
    _articles.addAll(res);
  }


}
