import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChannelDetails extends StatefulWidget {
  const ChannelDetails(
      {Key? key, required this.messengerUid, required this.messengerName})
      : super(key: key);

  final String messengerUid;
  final String messengerName;

  @override
  State<ChannelDetails> createState() =>
      _ChannelDetailsState(messengerUid, messengerName);
}

class _ChannelDetailsState extends State<ChannelDetails> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  late final String messengerUid;
  late final String messengerName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var channelDocId;

  _ChannelDetailsState(String messengerUid, String messengerName);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages
        .where('users', isEqualTo: {messengerUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            channelDocId = querySnapshot.docs.single.id;
          } else {
            messages.add({
              'users': {
                currentUserId: null,
                messengerUid: null,
              }
            }).then((value) => {
              channelDocId = value
            });
          }
        })
        .catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(channelDocId)
            .collection('messages')
            .orderBy('createdOn', descending: true)
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

          if (snapshot.hasData) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                previousPageTitle: "Back",
                middle: Text(messengerName),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero, 
                  onPressed: (onPressed) {
                    
                }),
                ),
              child: Container(),
            );
          }

          return Container();
        });
  }
}
