import 'package:flutter/cupertino.dart';
import 'package:messaging_app/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var screens = [const Messages(), const Calls(), Contacts(), const UserProfile()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        resizeToAvoidBottomInset: true,
        tabBar: CupertinoTabBar(
          height: 60.0,
          items: const [
            BottomNavigationBarItem(
              label: "Messages",
              icon: Icon(CupertinoIcons.ellipses_bubble),
            ),
            BottomNavigationBarItem(
              label: "Calls",
              icon: Icon(CupertinoIcons.phone),
            ),
            BottomNavigationBarItem(
              label: "Contacts",
              icon: Icon(CupertinoIcons.collections),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(CupertinoIcons.person),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return screens[index];
        },
      ),
    );
  }
}
