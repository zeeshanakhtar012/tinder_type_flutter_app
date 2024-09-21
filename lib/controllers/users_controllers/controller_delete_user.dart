

import 'dart:developer';

import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class ControllerDeleteUser extends GetxController{

  var isLoading = false.obs;
  Future<void> DeleteUser() async {
    String? token = await ControllerLogin.getToken();
    // int? userId = await ControllerLogin.getUid();

    final response = await http.delete(Uri.parse("https://blaxity.codergize.com/api/user/delete-account/5"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }
    );
    log(response.body);
    log(token.toString());
    try{
      if (response.statusCode == 200) {
        print("Account Deleted successfully.");
      } else{
        print("Account not Deleted.");
      }
    }catch(e){
      print(e);
    }
  }
}