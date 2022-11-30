import 'package:audio_player/player.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'button.dart';
import 'song.dart';
import 'package:file_picker/file_picker.dart';
import 'assets/colors.dart';
import 'dart:io';
import 'dart:convert';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  List<Song> songs = [];

  @override void initState() {
    super.initState();

    setSonglist();
  }

  void setSonglist() async {
    final prefs = await SharedPreferences.getInstance();
    final song_strings = prefs.getStringList('songs');

    if (song_strings == null) {
      songs = [];
    } else {
      setState(() {
        songs.addAll(song_strings.map((string) => Song.fromJson(jsonDecode(string))));
      });
      // songs.addAll(song_strings.map((string) => Song.fromJson(jsonDecode(string))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 35, 53),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      print("are we doing this?");
                      final choose = await getSongs(songs);
                      setState(() {
                        songs = choose;
                      });
                    },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: MyButtonStyle(
                        child: Icon(
                          Icons.folder,
                          color: TEXTCOLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (_, index) {
                    return buildSongButton(songs[index], context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Song>> getSongs(List<Song> songs) async {
  final prefs =  await SharedPreferences.getInstance();
  List<String>? song_strings = prefs.getStringList('songs');
  // HELP!!
  print(song_strings);

  song_strings??= [];

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ['mp3'],
  );

  print(result);
  if (result != null) {
    songs.addAll(result.paths.map((path) => Song(path!.split("/").last, "Unknown", path)).toList());
    song_strings.addAll(result.paths.map((path) => jsonEncode(Song(path!.split("/").last, "Unknown", path))).toList());

    await prefs.setStringList('songs', song_strings);
  } else {
    // User canceled the picker
  }

  /* List<Song> songs = [
    Song("Smells Like Teen Spirit", "Nirvana",
        "https://www.youtube.com/watch?v=hTWKbfoikeg")
  ]; */
  print(song_strings);
  print("here we are now");
  return songs;
}

Padding buildSongButton(Song song, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AudioPlayerPage(song: song,)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SizedBox(
          width: 200,
          height: 60,
          child: MyButtonStyle(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    song.title,
                    style: TextStyle(
                      color: Color.fromARGB(255, 90, 100, 130),
                    ),
                  ),
                  Text(
                    song.author,
                    style: TextStyle(
                      color: Color.fromARGB(255, 90, 100, 130),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
