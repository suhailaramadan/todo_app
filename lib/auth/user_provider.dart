import 'package:flutter/foundation.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider with ChangeNotifier{
  UserModel? currentUser;
  updateUser(UserModel? user){
    currentUser=user;
    notifyListeners();
  }
}