
import 'package:bmi_calculator/signup_page.dart';
import 'package:flutter/material.dart';

import 'package:bmi_calculator/login_page.dart';
//import 'package:bmi_calculator/BmiCalculator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'bmi_calculator.dart';

class AuthController extends GetxController{
  static AuthController instance=Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user,_initialScreen);
}
  _initialScreen(User? user){
    if(user==null){
      print("login Page");
      Get.offAll(()=>LoginPage());
    }else{
      Get.offAll(()=>BmiCalculator());
    }
  }
  void register(String email, password)async {
    try{
     await auth.createUserWithEmailAndPassword(email: email, password: password);

    }catch(e){
      Get.snackbar("About User", "User message",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account creation failed",
          style: TextStyle(
              color:Colors.white
          ),

        ),
        messageText:  Text(
          e.toString(),
          style: TextStyle(
              color:Colors.white
          ),

        ),
        );


      }
    }
  void login(String email, password)async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);

    }catch(e){
      Get.snackbar("About Login", "Login message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed",
          style: TextStyle(
              color:Colors.white
          ),

        ),
        messageText:  Text(
          e.toString(),
          style: TextStyle(
              color:Colors.white
          ),

        ),
      );


    }
  }

  void logOut() async {
    await auth.signOut();
  }
  }



