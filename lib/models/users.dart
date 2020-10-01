import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  String photoUrl;
  final String displayName;

  User({
    this.id,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
    );
  }
}
