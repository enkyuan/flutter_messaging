import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:messaging_app/pages/channel_details.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  void callMessagesScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: ((context) =>
                ChannelDetails(messengerUid: uid, messengerName: name))));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error occurred"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading"),
            );
          }

          if (snapshot.hasData) {
            var data;
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text("Messages"),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    data = document.data()!;
                    return CupertinoListTile(
                      title: Text(data['title']),
                    );
                  }).toList()),
                )
              ],
            );
          }
          return Container();
        });
  }
}
