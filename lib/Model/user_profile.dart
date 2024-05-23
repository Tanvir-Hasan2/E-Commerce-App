import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String name;
  final String email;
  final String uid;
  const UserProfile(
      {required this.name, //required tkn e use
      // kori jkn value ta null thakte parbe na
      required this.email,
      required this.uid});

//multiple constructor create
// er subidha dei with diff
// name, r "factory" keyword use kore
// multiple constructor create kora hoy

  factory UserProfile.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    //ei khane snapshot ekta instance create kora hoyse.
    final data = snapshot.data()!;
    return UserProfile(
        name: data['name'],
        email: data['email'],
        uid: data['uid']
    );
  }

  toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }
}
