import 'package:melo_cli/example/modules/users/domain/models/user_model.dart';

import '../network/local/prefs.dart';

class UserManager {
  UserModel? user;
  String? token;

  UserManager({this.token, this.user});

  Future<void> save(UserModel user, String token) async {
    await Prefs.setString('token', token);
    this.token = token;
    this.user = user;
  }
}
