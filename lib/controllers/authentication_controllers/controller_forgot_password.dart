import 'dart:convert';
import 'dart:developer';

import 'package:blaxity/views/screens/screen_resetPassword_successfull.dart';
import 'package:blaxity/views/screens/screen_reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/ApiEndPoint.dart';
import '../../constants/firebase_utils.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  Rx<TextEditingController> email = TextEditingController().obs;

  // Use an enum to represent the selected option
  var selectedOption = SelectedOption.none.obs;

  void selectOption(SelectedOption option) {
    selectedOption.value = option;
  }
  /// Get Otp
  Future<void> GetOtp() async {
    if (selectedOption.value == null) {
      FirebaseUtils.showError("Email field cannot be empty.");
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(APiEndPoint.forgotPassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email.value.text}),
      );

      var data = jsonDecode(response.body);
      log(data.toString());

      if (response.statusCode == 200) {
        FirebaseUtils.showSuccess("OTP sent to email ${email.value.text}");
      } else if (response.statusCode == 422) {
        // Extract and join email errors if any
        List<String> emailErrors = List<String>.from(data['email'] ?? []);
        String errorMessage = emailErrors.join(', ') ?? "The email field is required.";
        FirebaseUtils.showError(errorMessage);
      } else if (response.statusCode == 404) {
        FirebaseUtils.showError("Email does not exist.");
      } else if (response.statusCode == 500) {
        FirebaseUtils.showError("Internal server error.");
      } else {
        FirebaseUtils.showError("${email.value.text} is not registered.");
      }
    } catch (e) {
      log("Exception Error: $e");
      FirebaseUtils.showError("An error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
  /// Verify Otp For Forgot Password
  TextEditingController otpController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> UpdatePassword({required String email}) async {
    String otpText = otpController.text;
    int otp = int.parse(otpText);
    String _password = password.text;
    String _confirmPassword = confirmPassword.text;

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(APiEndPoint.resetPassword),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'password': _password,
          'password_confirmation': _confirmPassword,
        }),
      );

      log(response.body.toString());
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        FirebaseUtils.showSuccess("Password reset successfully.");
        Get.to(ScreenPasswordSuccessfull());
      } else if (response.statusCode == 422) {
        // Extract errors from response
        String emailErrors = (responseData['email'] as List?)?.join(', ') ?? '';
        String otpErrors = (responseData['otp'] as List?)?.join(', ') ?? '';
        String passwordErrors = (responseData['password'] as List?)?.join(', ') ?? '';

        // Construct a comprehensive error message
        String errorMessage = [emailErrors, otpErrors, passwordErrors].where((s) => s.isNotEmpty).join('\n');
        FirebaseUtils.showError(errorMessage.isNotEmpty ? errorMessage : "Validation failed.");
      } else if (response.statusCode == 400) {
        FirebaseUtils.showError("Invalid OTP or email.");
      } else if (response.statusCode == 500) {
        FirebaseUtils.showError("Internal server error. Please try again later.");
      } else {
        FirebaseUtils.showError("Unexpected error occurred. Please try again.");
      }
    } catch (e) {
      log("Exception Error: $e");
      FirebaseUtils.showError("An error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}

enum SelectedOption { none, sms, email }
