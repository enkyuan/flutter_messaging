import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:messaging_app/pages/home.dart';
import 'package:messaging_app/states/lib.dart';

class UserName extends StatefulWidget {
  UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  final _text = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    _text.text = (FirebaseAuth.instance.currentUser?.displayName ?? '');
    super.initState();
  }

  void createUserInFirestore() {
    users
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        users.add({
          'name': _text.text,
          'phone': FirebaseAuth.instance.currentUser?.phoneNumber,
          'status': 'Available',
          'uid': FirebaseAuth.instance.currentUser?.uid,
        });
      }
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoButton(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Observer(
                  builder: (BuildContext context) => CircleAvatar(
                    radius: 60,
                    child: userState.imagefile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              userState.imagefile!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              CupertinoIcons.camera_fill,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              onPressed: () => userState.takeImageFromCamera()),
          const Text("Enter your name"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 55),
            child: CupertinoTextField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
              maxLength: 15,
              controller: _text,
            ),
          ),
          CupertinoButton.filled(
              child: const Text("Continue"),
              onPressed: () {
                FirebaseAuth.instance.currentUser
                    ?.updateDisplayName(_text.text);

                createUserInFirestore();
                userState.createOrUpdateUserInFirestore(_text.text);

                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const HomePage()));
              }),
        ],
      ),
    );
  }
}
