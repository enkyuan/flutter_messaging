import 'package:flutter/cupertino.dart';

class Calls extends StatelessWidget {
  const Calls({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Calls"),
            
          )
        ],
    );
  }
}