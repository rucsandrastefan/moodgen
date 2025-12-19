import 'package:my_flutter_app/models/user.dart';

class UserRepository {
  Future<AppUser> getOrCreateUser(AppUser user) async {
    // Firebase / local DB logic
    return user;
  }
}
