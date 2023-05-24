import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChannelDetails extends StatefulWidget {
  const ChannelDetails(
      {Key? key, required this.messengerUid, required this.messengerName})
      : super(key: key);

  final messengerUid;
  final messengerName;

  @override
  State<ChannelDetails> createState() =>
      _ChannelDetailsState(messengerUid, messengerName);
}

class _ChannelDetailsState extends State<ChannelDetails> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final messengerUid;
  final messengerName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var channelDocId;
  var _textController = new TextEditingController();

  _ChannelDetailsState(this.messengerUid, this.messengerName);

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await messages
        .where('users', isEqualTo: {messengerUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              channelDocId = querySnapshot.docs.single.id;
            });
            print(channelDocId);
          } else {
            await messages.add({
              'users': {
                currentUserId: null,
                messengerUid: null,
              },
              'names': {
                currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                messengerUid: messengerName,
              }
            }).then((value) => {channelDocId = value});
          }
        })
        .catchError((error) {});
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    messages.doc(channelDocId).collection('threads').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'messengerName': messengerName,
      'msg': msg,
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String sender) {
    return sender == currentUserId;
  }

  Alignment getAlignment(sender) {
    if (sender == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages
            .doc(channelDocId)
            .collection('threads')
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
            var data;
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                previousPageTitle: "Back",
                middle: Text(messengerName),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // TODO: Implement this
                  },
                  child: Icon(CupertinoIcons.phone),
                ),
              ),
              child: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    reverse: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      data = document.data()!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChatBubble(
                          clipper: ChatBubbleClipper6(
                            nipSize: 0,
                            radius: 0,
                            type: isSender(data['uid'].toString())
                                ? BubbleType.sendBubble
                                : BubbleType.receiverBubble,
                          ),
                          alignment: getAlignment(data['uid'].toString()),
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: isSender(data['uid'].toString())
                              ? Color(0xFF08C187)
                              : Color(0xffE7E7ED),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['msg'].toString(),
                                      style: TextStyle(
                                          color:
                                              isSender(data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.black),
                                      maxLines: 100,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      data['createdOn'] == null
                                          ? DateTime.now().toString()
                                          : data['createdOn']
                                              .toDate()
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color:
                                              isSender(data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.black),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: CupertinoTextField(controller: _textController),
                      )),
                      CupertinoButton(
                        child: Icon(CupertinoIcons.arrow_up_circle_fill),
                        onPressed: () => sendMessage(_textController.text),
                      )
                    ],
                  ),
                ],
              )),
            );
          } else {
            return Container();
          }
        });
  }
}
