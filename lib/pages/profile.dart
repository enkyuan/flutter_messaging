import 'package:flutter/cupertino.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text("Profile"),
        ),
      ],
    );
  }
}
