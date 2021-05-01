import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/models/user.dart';

class Database {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> addNoter(Notetaker notetaker) async {
    return await usersCollection.doc(notetaker.id).set(notetaker.toJson());
  }

  Stream<DocumentSnapshot> getNoter(Notetaker notetaker) {
    return usersCollection.doc(notetaker.id).snapshots();
  }
}
