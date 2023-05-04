import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/components/blur_image_page_scaffold.dart';
import 'package:messaging_app/components/lets_start.dart';
import 'package:messaging_app/components/logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlurImageScaffoldPage(
      imagePath: 'assets/images/background.png',
      body: [
        Logo(
          width: 150,
          height: 150,
          radius: 50,
        ),
        Text(
          "Hello",
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 60,
          ),
        ),
        Column(
          children: [
            Text("Messaging API for TeensNext",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
            ),
            ),
          ],
        ),
        LetsStart(),
      ],
    );
  }
}
