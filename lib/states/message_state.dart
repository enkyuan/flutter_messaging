import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'message_state.g.dart';

class MessageState = _MessageState with _$MessageState;

// Store class
abstract class _MessageState with Store {
  var currentUser = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @observable
  Map<String, dynamic> threads = ObservableMap();

  @action
  void refreshMessagesForCurrentUser() {
    var messageDocuments = [];
    messages
        .where('users.$currentUser', isNull: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      messageDocuments = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> names = data['names'];
        names.remove(currentUser);

        return {'docid': doc.id, 'name': names.values.first};
      }).toList();

      for (var doc in messageDocuments) {
        FirebaseFirestore.instance
            .collection('messages/${doc['docid']}/threads')
            .orderBy('createdOn', descending: true)
            .limit(1)
            .snapshots()
            .listen((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            threads[doc['name']] = {
              'msg': snapshot.docs.first['msg'],
              'time': snapshot.docs.first['createdOn'],
              'messengerName': doc['name'], 
              'messengerUid': snapshot.docs.first['uid']
            };
          }
        });
      }
    });
  }
}
