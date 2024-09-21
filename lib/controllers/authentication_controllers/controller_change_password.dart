import 'dart:convert';
import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/views/screens/screen_signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/firebase_utils.dart';
import 'controller_sign_in_.dart';

class ControllerChangePassword extends GetxController {

  Rx<TextEditingController> oldPassword = TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  var isLoading = false.obs;

  Future<void> changePassword() async {
    String? token = await ControllerLogin.getToken();
    isLoading.value = true;

    final response = await http.post(
      Uri.parse('https://blaxity.codergize.com/api/user/change-password'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        'old_password': oldPassword.value.text,
        'new_password': newPasswordController.value.text,
        'new_password_confirmation': confirmPasswordController.value.text,
      }),
    );

    log(response.body.toString());
    log(token.toString());

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data.toString());
        log("Password changed successfully");
        Get.to(ScreenLogin());
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        String errorMessage = '';

        if (data['error'] != null) {
          if (data['error']['old_password'] != null) {
            errorMessage += 'Old password: ${data['error']['old_password'].join(', ')}\n';
          }
          if (data['error']['new_password'] != null) {
            errorMessage += 'New password: ${data['error']['new_password'].join(', ')}\n';
          }
          if (data['error']['new_password_confirmation'] != null) {
            errorMessage += 'Password confirmation: ${data['error']['new_password_confirmation'].join(', ')}\n';
          }
        }
        FirebaseUtils.showError(errorMessage.isNotEmpty ? errorMessage : "Validation failed.");
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        FirebaseUtils.showError(data['message'] ?? "Old password is incorrect.");
      } else {
        log('Unexpected status code: ${response.statusCode}');
        log('Response body: ${response.body}');
        FirebaseUtils.showError("An unexpected error occurred.");
      }
    } catch (e) {
      log("Exception: ${e.toString()}");
      FirebaseUtils.showError("An error occurred while changing the password.");
    } finally {
      isLoading.value = false;
    }
  }
}
