import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<AppUser> createOrGetUser(AppUser user) async {
    final doc = _users.doc(user.id);
    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set({
        ...user.toFirestore(),
        'provider': 'spotify',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return user;
  }
}
