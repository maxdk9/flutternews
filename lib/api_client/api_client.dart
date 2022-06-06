
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutternews/model/article.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';


class ApiClient{
  final HttpClient _client = HttpClient();
  static const String _host = 'https://newsapi.org/v2';
  static const String _apiKey='210c7980357d4bf486f7e61ad2df87b7';
  //static const String _apiKey='c82749bba25d4d6689e43e79ac6152e4';

  Future<ArticleResponse> newsSearchDay(String query) async{
    final parser =(dynamic json){

      final jsonMap=json as Map<String,dynamic>;
      final ArticleResponse response=ArticleResponse.fromJson(json);
      return response;
    };
    final result= await _get(
        '/everything',parser, <String,dynamic>{
      'q': query,
      'language': 'en',
      'from': GetFormattedDate(DateTime.now()),
      'to':GetFormattedDate(DateTime.now()),
      'sort':'popularity',
      'apiKey':ApiClient._apiKey,
    }
    );
    return result;
  }


  Future<ArticleResponse> newsHeadlinesDay() async{
    final parser =(dynamic json){

      final jsonMap=json as Map<String,dynamic>;
      final ArticleResponse response=ArticleResponse.fromJson(json);
      return response;
    };

    final result= await _get(
      '/top-headlines',parser, <String,dynamic>{
      'language': 'en',
        'from': GetFormattedDate(DateTime.now()),
        'to':GetFormattedDate(DateTime.now()),
        'sort':'popularity',
        'apiKey':ApiClient._apiKey,
      }
    );
    return result;
  }

  Uri _makeUri(String path,[Map<String,dynamic>? parameters]){
    final uri=Uri.parse('$_host$path');
    if(parameters!=null){
      return uri.replace(queryParameters: parameters);
    }
    else{
      return uri;
    }
  }

  Future<T> _get<T>(String path,
      T Function(dynamic json) parser,
      [Map<String,dynamic>? parameters]) async{
    final url= _makeUri(path,parameters);
    try{
      final Response response=await get(url);
      final dynamic json=await jsonDecode(response.body);
      return parser(json);
    }
    catch(e)  {
      Fluttertoast.showToast(
          msg: "Error!${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 14.0
      );
      throw Exception(e.toString());
    }
  }

  String GetFormattedDate(DateTime d) {
    String result = d.toString().substring(0,10);
    return result;
  }



}