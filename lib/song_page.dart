import 'package:flutter/material.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 35, 53),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 36, 40, 59),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 26, 30, 48),
                offset: Offset(5, 5),
                blurRadius: 15,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 26, 30, 48),
                offset: Offset(-5, -5),
                blurRadius: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
