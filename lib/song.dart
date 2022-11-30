import 'dart:convert';

class Song {
  String title = "";
  String author = "";
  String url = "";

  Song(String t, String a, String u) {
    this.title = t;
    this.author = a;
    this.url = u;
  }

  Song.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      author = json['author'],
      url = json['url'];
  
  Map<String, dynamic> toJson() => {
    'title' : title,
    'author' : author,
    'url' : url,
  };
}