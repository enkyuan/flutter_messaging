import 'dart:ui';

import 'package:flutter/material.dart';

class BlurImageScaffoldPage extends StatelessWidget {
  const BlurImageScaffoldPage({Key? key, this.imagePath, this.body}) : super(key: key);
  final body;
  final imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'), fit: BoxFit.fill
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.black.withOpacity(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: body,
          ),
        ),
      ),
    );
  }
}
