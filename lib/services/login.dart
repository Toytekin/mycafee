import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycofeekahve/models/usermodel.dart';
import 'package:mycofeekahve/services/save_user.dart';

class FrLogin {
  var fireAuth = FirebaseAuth.instance;
  var save = FrSaveUser();

  Future<UserModel?> kaydet(UserModel userModel) async {
    try {
      var userCredential = await fireAuth.createUserWithEmailAndPassword(
          email: userModel.userMail, password: userModel.userSifre);
      var user = userCredential.user;
      debugPrint('Kayıt başarılı ');
      if (user != null) {
        var newuser = UserModel(
          userID: user.uid,
          userName: userModel.userName,
          userMail: user.email ?? '',
          userSifre: userModel.userSifre,
        );
        await save.userEkle(newuser);
        return newuser;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('FrLogin kaydet fonksiyonunda hatam var  $e');
      return null;
    }
  }
}
