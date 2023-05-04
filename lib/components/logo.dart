import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, this.width, this.height, this.radius})
      : super(key: key);
  final width;
  final height;
  final radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        shape: BoxShape.rectangle,
        color: Colors.white.withOpacity(0.8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(2.0),
        child: Image(
          image: AssetImage('assets/images/speech_bubble.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
