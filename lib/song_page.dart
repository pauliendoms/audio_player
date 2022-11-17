import 'package:audio_player/player.dart';
import 'package:flutter/material.dart';
import 'button.dart';
import 'song.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  List<Song> songs = getSongs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 35, 53),
      body: Center(
        child: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (_, index) {
            return buildSongButton(songs[index], context);
          },
        ),
      ),
    );
  }
}

List<Song> getSongs() {
  List<Song> songs = [
    Song("Smells Like Teen Spirit", "Nirvana",
        "https://www.youtube.com/watch?v=hTWKbfoikeg")
  ];
  return songs;
}

Padding buildSongButton(Song song, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AudioPlayerPage()),
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
