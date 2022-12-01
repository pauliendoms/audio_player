import 'package:audio_player/button.dart';
import 'package:flutter/material.dart';
import 'assets/colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'song.dart';

class AudioPlayerPage extends StatefulWidget {
  final Song song;
  const AudioPlayerPage({super.key, required this.song});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  double slider_value = 0;

  final audioPlayer = AudioPlayer();
  bool playing = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        playing = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
    //String url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
    //audioPlayer.setUrl(url);

    // final result = await FilePicker.platform.pickFiles();
    final result = 'yolo';

    if (result != null) {
      //final file = File(result.files.single.path!);
      // final path = '/data/user/0/com.example.audio_player/cache/file_picker/Nirvana - Smells Like Teen Spirit (Official Music Video)';
      final path = widget.song.url;
      audioPlayer.setUrl(path, isLocal: true);
      //print(file.path);
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      audioPlayer.stop();
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: MyButtonStyleRound(
                        child: Icon(
                          Icons.arrow_back,
                          color: TEXTCOLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: MyButtonStyleRound(
                  child: Icon(
                    Icons.radio_button_checked,
                    size: 75,
                    color: TEXTCOLOR,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    thumbColor: TEXTCOLOR,
                    activeColor: TEXTCOLOR,
                    inactiveColor: LIGHTBLUE,
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audioPlayer.seek(position);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: MyButtonStyleRound(
                      child: Icon(
                        Icons.skip_previous,
                        color: TEXTCOLOR,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (playing) {
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.resume();
                      }
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: MyButtonStyleRound(
                        child: Icon(
                          playing ? Icons.pause : Icons.play_arrow,
                          color: TEXTCOLOR,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: MyButtonStyleRound(
                      child: Icon(
                        Icons.skip_next,
                        color: TEXTCOLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
