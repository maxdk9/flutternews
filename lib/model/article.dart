import 'package:flutter/cupertino.dart';
import 'package:flutternews/database/db_service.dart';

class ArticleResponse{
  String status;
  int totalResults;
  List<Article> articles;
  ArticleResponse({required this.status,required this.totalResults,required this.articles});

  factory ArticleResponse.fromJson(Map<String,dynamic> json)=>ArticleResponse(
  status : json['status'],
  totalResults: json['totalResults'],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );
}


class Article{

  String author;
  bool favorite=false;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  Source source;
  String uid='';
  Article({required this.author,required this.title,required this.description,required this.url,
    required this.urlToImage,required this.publishedAt,required this.content,required this.source,
    this.uid='',required this.favorite}){
    this.uid=DatabaseService.generateUID(this.url);

  }


  factory Article.fromJson(Map<String,dynamic> json)=>Article
    (


    source : Source(name: json['source']['id'], id: json['source']['name']),
    author : json['author'],
    title : json['title'],
    description : json['description'],
    url : json['url'],
    urlToImage : json['urlToImage'],
    publishedAt : json['publishedAt'],
    content : json['content'],
    favorite: json['favorite']==null?false:json['favorite'],
    uid: json['uid']
  );

  Map<String, dynamic> toJson() => {
    'author':author,
    'title':title,
    'description':description,
    'url':url,
    'urlToImage':urlToImage,
    'publishedAt':publishedAt,
    'content':content,
    'source':source.toJson(),
    'favorite':favorite,
    'uid':uid
  };




}




class Source {
  final String? id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromjson(Map<String, dynamic>map)=>Source(
        id : map['id']??'',
        name : map['name'],
        );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}