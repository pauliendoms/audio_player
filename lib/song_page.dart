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

  @override
  void initState() {
    super.initState();

    setSonglist();

    Song.NextSong.subscribe((s) => {
          if (songs.indexOf(s as Song) == (songs.length - 1))
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AudioPlayerPage(
                          song: songs[0],
                        )),
              )
            }
          else
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AudioPlayerPage(
                      song: songs[songs.indexOf(s as Song) + 1],
                    ),
                  ))
            }
        });

        Song.PreviousSong.subscribe((s) => {
          if (songs.indexOf(s as Song) == 0)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AudioPlayerPage(
                          song: songs[songs.length - 1],
                        )),
              )
            }
          else
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AudioPlayerPage(
                      song: songs[songs.indexOf(s as Song) - 1],
                    ),
                  ))
            }
        });
  }

  void setSonglist() async {
    final prefs = await SharedPreferences.getInstance();
    final song_strings = prefs.getStringList('songs');

    if (song_strings == null) {
      songs = [];
    } else {
      setState(() {
        songs.addAll(
            song_strings.map((string) => Song.fromJson(jsonDecode(string))));
      });
      // songs.addAll(song_strings.map((string) => Song.fromJson(jsonDecode(string))));
    }
  }

  Future<void> _showInfo() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: DARKSHADOW,
            title: Text(
              'Tips',
              style: TextStyle(
                color: TEXTCOLOR,
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Add songs to the list by clicking the folder icon in the top left corner",
                  style: TextStyle(
                    color: TEXTCOLOR,
                  ),
                ),
              ),
              SimpleDialogOption(
                child: Text(
                  "Swipe on a song to remove it from the list",
                  style: TextStyle(
                    color: TEXTCOLOR,
                  ),
                ),
              ),
            ],
          );
        })) {
      case null:
        // dialog dismissed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 35, 53),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: MyButtonStyleRound(
                        child: Icon(
                          Icons.folder,
                          color: TEXTCOLOR,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showInfo(),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: MyButtonStyleRound(
                        child: Icon(
                          Icons.info_outline,
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
                    return Dismissible(
                      key: UniqueKey(),
                      child: buildSongButton(songs[index], context),
                      onDismissed: (direction) async {
                        setState(() {
                          songs.removeAt(index);
                        });
                        final list =
                            songs.map((song) => jsonEncode(song)).toList();
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setStringList('songs', list);
                      },
                    );
                    // return buildSongButton(songs[index], context);
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
  final prefs = await SharedPreferences.getInstance();
  List<String>? song_strings = prefs.getStringList('songs');
  // HELP!!
  print(song_strings);

  song_strings ??= [];

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ['mp3'],
  );

  print(result);
  if (result != null) {
    songs.addAll(result.paths
        .map((path) => Song(path!.split("/").last, "Unknown", path))
        .toList());
    song_strings.addAll(result.paths
        .map((path) => jsonEncode(Song(path!.split("/").last, "Unknown", path)))
        .toList());

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
    padding: const EdgeInsets.all(7.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AudioPlayerPage(
                    song: song,
                  )),
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
