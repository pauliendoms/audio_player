import 'dart:convert';
import 'package:event/event.dart';

class Song extends EventArgs {
  String title = "";
  String author = "";
  String url = "";

  static Event NextSong = Event<Song>();

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