import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:messaging_app/pages/channel_details.dart';

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key);

  var currentUser = FirebaseAuth.instance.currentUser?.uid;

  void callMessagesScreen(BuildContext context, String name, String uid) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: ((context) => ChannelDetails(
        messengerUid: uid,
        messengerName: name,
        )
      ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('uid', isNotEqualTo: currentUser)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error occurred"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          }

          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text("Contacts"),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return CupertinoListTile(
                      onTap: () =>
                          callMessagesScreen(context, data['name'], data['uid']),
                      title: Text(data['name']),
                      subtitle: Text(data['status']),
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
