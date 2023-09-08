import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../model/user.dart';
import '../service/shared_service.dart';
import '../utils/constant.dart';
import '../view/home.dart';

class AuthController extends ChangeNotifier {
  User? user;
  bool waitingForVerfication = true;
  int? userId;
  String? userToken;
  SharedService _sharedService = SharedService();
  Future<String?> getUserFromShared() async {
    await _sharedService.initialize();
    user = await _sharedService.getUser();
    print(user?.token);
    notifyListeners();
    return user?.token;
  }
  bool isLogedIn() => user != null;
  
  Future<void> login(String phoneNumber) async {
    http.Response _res = await http.post(Uri.parse(loginUrl), body: {
      "mobile": phoneNumber
    });
    print(_res.body);
    if (_res.statusCode == 200) {
      Map json = jsonDecode(_res.body);

      if (json['status']) {
        userId = json['data']['id']??json['data']['user']['id'];
        waitingForVerfication = true;
        notifyListeners();
      } else {
        // Toast.show(json['message']);
        throw "";
      }
    } else {
      // Toast.show("حصل خطأ ما");
    throw "";
    }
  }

  Future<void> loginCheck(String otp, BuildContext context)async{


    http.Response _res = await http.post(Uri.parse(loginCheckUrl), body: {
      "user_id":userId.toString(),
      "code":otp
    });


print(_res.body);
    if (_res.statusCode == 200) {
      Map json = jsonDecode(_res.body);
      if (json['status']) {
     

       user  = User.fromJson(json['data']['user']);
        waitingForVerfication = false;
        _sharedService.saveUser( user!);
        notifyListeners();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:((context) => HomeScreen())), (route) => false);
        
      } else {
        // Toast.show(json['message']);
      }
    } else {
      // Toast.show("حصل خطأ ما");
    }



      
  }
   
  void logout(){
    _sharedService.clear();
  }
}
