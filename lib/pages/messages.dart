import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:messaging_app/pages/channel_details.dart';
import 'package:messaging_app/states/lib.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  void initState() {
    super.initState();
    messageState.refreshMessagesForCurrentUser();
  }

  void callMessagesScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: ((context) => ChannelDetails(
                  messengerUid: uid,
                  messengerName: name,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) => 
      CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Messages"),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              messageState.threads.values.toList().map((data) {
                return CupertinoListTile(
                  title: Text(data['messengerName']),
                  subtitle: Text(data['msg']),
                  onTap: () => callMessagesScreen(context, data['messengerName'], data['messengerUid']),
              );
            }).toList()),
          )
        ],
      )
    );
  }
}

