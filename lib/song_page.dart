import 'package:audio_player/player.dart';
import 'package:flutter/material.dart';
import 'button.dart';
import 'song.dart';
import 'package:file_picker/file_picker.dart';
import 'assets/colors.dart';
import 'dart:io';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  List<Song> songs = [];
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
  print("Trying to find where I am");
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ['mp3'],
  );

  if (result != null) {
    songs.addAll(result.paths.map((path) => Song(path!.split("/").last, "Unknown", path)).toList());
  } else {
    // User canceled the picker
  }

  /* List<Song> songs = [
    Song("Smells Like Teen Spirit", "Nirvana",
        "https://www.youtube.com/watch?v=hTWKbfoikeg")
  ]; */
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
  );
}
