
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class ApiClient{
  final HttpClient _client = HttpClient();
  static const String _host = 'https://newsapi.org/v2';
  static const String _apiKey='210c7980357d4bf486f7e61ad2df87b7';

  Future<dynamic> newsEverthing() async{
    final parser =(dynamic json){
      final jsonMap=json as Map<String,dynamic>;
      final token =jsonMap['request_token'] as String;
      return token;
    };
    final result= _get(
      '/everything',parser, <String,dynamic>{'apiKey':ApiClient._apiKey}
    );

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
      if(response.statusCode==200){
        final dynamic json=await jsonDecode(response.body);

      }

    }
    catch(_)  {

    }
  }

}