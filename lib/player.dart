import 'package:audio_player/button.dart';
import 'package:flutter/material.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 35, 53),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: MyButtonStyle(
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: MyButtonStyle(child: Icon(Icons.info_outline),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
