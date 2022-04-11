import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutternews/model/article.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  static const Uuid _uuid = Uuid();

  final CollectionReference _favoritesCollection = FirebaseFirestore.instance
      .collection('favorites');
  final _auth = FirebaseAuth.instance;

  List<Article> _articles = <Article>[];

  List<Article> get articles => List.unmodifiable(_articles);


  static String generateUID(String url) {
    return _uuid.v5(Uuid.NAMESPACE_URL, url);
  }


  Future addFavorite(Article article) async {
    User? user = await _auth.currentUser;
    CollectionReference _favoritesUserCollection = FirebaseFirestore.instance
        .collection(user!.uid);
    _articles.add(article);
    return await _favoritesUserCollection.doc(article.uid).set(
        article.toJson());
  }

  Future deleteFavorite(Article article) async {
    User? user = await _auth.currentUser;
    CollectionReference _favoritesUserCollection = FirebaseFirestore.instance
        .collection(user!.uid);
    if(_articles.contains(article)){
      _articles.remove(article);
    }
    return await _favoritesUserCollection.doc(article.uid).delete();
  }

  Future loadFavorites() async{
    User? user = await _auth.currentUser;
    CollectionReference _favoritesUserCollection = FirebaseFirestore.instance
        .collection(user!.uid);
    QuerySnapshot snapshot=await _favoritesUserCollection.get();

    List<Article> res=snapshot.docs.map((DocumentSnapshot e) => Article.fromJson(e.data()! as Map<String,dynamic> )).toList();

    //List<Article> res= snapshot.docs.map((DocumentSnapshot e) => Article.fromJson(e.data)).toList();
    _articles.clear();
    _articles.addAll(res);
  }
}
