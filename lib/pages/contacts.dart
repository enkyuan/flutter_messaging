import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:messaging_app/pages/channel_details.dart';
import 'package:messaging_app/states/lib.dart';

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key);

  var currentUser = FirebaseAuth.instance.currentUser?.uid;

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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: currentUser)
            .snapshots(),
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
            return CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  largeTitle: Text("Contacts"),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Observer(
                      builder: (BuildContext context) =>
                      CupertinoListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(userState.users[data['uid']]['picture']),
                        ),
                        onTap: () => callMessagesScreen(
                            context, userState.users[data['uid']]['name'], data['uid']),
                        title: Text(userState.users[data['uid']]['name']),
                        subtitle: Text(userState.users[data['uid']]['status']),
                      ),
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
