import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calls extends StatelessWidget {
  const Calls({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Calls")
          )
        ],
    );
  }
}