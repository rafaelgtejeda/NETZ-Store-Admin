import 'dart:convert';

import 'package:get/get.dart';
import 'package:netzstore/models/login_model.dart';
import 'package:netzstore/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<bool> setLoginDetails(LoginModel model) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(
      "login_details",
      model != null ? jsonEncode(model.toJson()) : "null",
    );
  }

  static Future<LoginModel> loginDetails() async {
    
    final prefs = await SharedPreferences.getInstance();

    if ((prefs.getString("login_details") != "null" && prefs.getString("login_details") != null)) {

      return LoginModel.fromJson(

        jsonDecode(

          prefs.getString("login_details") ?? "null",

        ),

      );

    } else {

      return LoginModel();

    }
  }

  static Future<bool> isLoggedIn() async {

    final prefs = await SharedPreferences.getInstance();

    return (prefs.getString("login_details") != "null" &&
            prefs.getString("login_details") != null)
        ? true
        : false;
  }

  static Future<void> logout() async {
    
    await setLoginDetails(LoginModel());

    Get.offAll(() => const LoginPage());

  }

}
