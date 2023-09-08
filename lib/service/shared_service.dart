import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';



class SharedService {

  late SharedPreferences shared;
  Future<void> initialize() async {
    shared = await SharedPreferences.getInstance();
  }

  Future<User?> getUser() async{
    int? id = shared.getInt('id');
    if (id == null) {
      return null;
    }

    return User(
        id: id,
        token: shared.getString('token') ?? '',
        name: shared.getString('name') ?? '',
        image: shared.getString('image') ?? '',
        mobile: shared.getString('mobile') ?? '',);
  }

  void saveUser( User user) {
    shared.setInt('id', user.id);
    shared.setString('token', user.token);
    shared.setString('name', user.name);
    shared.setString('image', user.image);
    shared.setString('mobile', user.mobile);

  }

  Future<void> clear() async {
    shared.clear();
  }
}
