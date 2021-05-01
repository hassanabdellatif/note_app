import 'package:cloud_firestore/cloud_firestore.dart';

class Notetaker {
  String id, username, email, password, phone;
  DateTime createdAt;
  Notetaker(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.phone,
      this.createdAt});

  List<Notetaker> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Notetaker(
        id: doc.get('user_id') ?? '',
        username: doc.get('username') ?? '',
        email: doc.get('email') ?? '',
        password: doc.get('password') ?? '',
        phone: doc.get('phone') ?? '',
        createdAt: doc.get("createdAt") ?? '',
      );
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'createdAt': createdAt
    };
  }
}
