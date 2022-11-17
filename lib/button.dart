import 'package:flutter/material.dart';

class MyButtonStyle extends StatelessWidget {
  final child;
  const MyButtonStyle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
          child: child,
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(25),
            color: Color.fromARGB(255, 36, 40, 59),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 24, 28, 47),
                offset: Offset(5, 5),
                blurRadius: 15,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 44, 48, 69),
                offset: Offset(-5, -5),
                blurRadius: 15,
              ),
            ],
          ),
        );
  }
}

class MyButtonStyleRound extends StatelessWidget {
  final child;
  const MyButtonStyleRound({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
          child: child,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            //borderRadius: BorderRadius.circular(25),
            color: Color.fromARGB(255, 36, 40, 59),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 24, 28, 47),
                offset: Offset(5, 5),
                blurRadius: 15,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 44, 48, 69),
                offset: Offset(-5, -5),
                blurRadius: 15,
              ),
            ],
          ),
        );
  }
}


/*

Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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

*/