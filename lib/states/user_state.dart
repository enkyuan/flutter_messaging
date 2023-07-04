import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

/*
* stopped at Demo section of documentation
* timestamp : 17:59
*/

// Include generated file
part 'user_state.g.dart';

// Class used with rest of codebase
class UserState = _UserState with _$UserState;

abstract class _UserState with Store {
  @observable
  Map<String, dynamic> users = ObservableMap();
  final ImagePicker _picker = ImagePicker();

  @observable
  File? imagefile;

  var _profilePicUrl;
  var _userCollection = FirebaseFirestore.instance.collection('users');

  @action
  initUserListener() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        users[data['uid']] = {
          'name': data['name'],
          'phone': data['phone'],
          'status': data['status'],
          'picture': data['picture'],
        };
      });
    });
  }

  void takeImageFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    imagefile = File(image!.path);
    _uploadFile();
  }

  void _uploadFile() {
    if (imagefile == null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final profileImagesRef = storageRef
        .child('${FirebaseAuth.instance.currentUser?.uid}/photos/profile.jpg');

    profileImagesRef.putFile(imagefile!).snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          break;
        case TaskState.paused:
          break;
        case TaskState.success:
          profileImagesRef.getDownloadURL().then((value) => null);
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
        default:
      }
    });
  }

  void createOrUpdateUserInFirestore(String userName) {
    FirebaseAuth.instance.currentUser?.updateDisplayName(userName);
    var docId;
    this
        ._userCollection
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      // create user info in Firestore use case
      if (querySnapshot.docs.isEmpty) {
        this._userCollection.add({
          'name': userName,
          'phone': FirebaseAuth.instance.currentUser?.phoneNumber,
          'status': 'Available',
          'uid': FirebaseAuth.instance.currentUser?.uid,
          'picture': _profilePicUrl
        });
      } else {
        docId = querySnapshot.docs.first.id;
      }

      // update user info in Firestore use case
      if (docId != null) {
        this._userCollection.doc().update({
          'name': userName,
          'phone': FirebaseAuth.instance.currentUser?.phoneNumber,
          'status': 'Available',
          'uid': FirebaseAuth.instance.currentUser?.uid,
          'picture': _profilePicUrl
        });
      }
    }).catchError((error) {});
  }
}
