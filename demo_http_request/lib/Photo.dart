import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//Class  photo
class Photo {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.id, this.title, this.url, this.thumbnailUrl});

  // chuyen duw lieu tu Json
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  } 
}

// Tao cac function chuyen doi du lieu sang Json
Future<List<Photo>> fetchPhoto() async {
  final respone = await http.get("https://jsonplaceholder.typicode.com/photos");
  //return parsePhotos(respone.body);
  return compute(parsePhotos,respone.body); // ham callback trong 'package:flutter/foundation.dart'; cho lay du lieu thay vi return ngay
}

List<Photo> parsePhotos(String body) {
  final parsed = json.decode(body).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}
