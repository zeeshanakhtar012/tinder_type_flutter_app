import 'dart:convert';
import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/views/screens/screen_signin.dart';
import 'package:blaxity/views/screens/screen_splash.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/firebase_utils.dart';

class ControllerLogin extends GetxController {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    String apiUrl = APiEndPoint.login;
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    var responseData = jsonDecode(response.body);
    log(response.body);
    log(responseData.toString());
    if (response.statusCode == 200) {
      if (responseData['user']['verified'] == 1) {
        var token = responseData['access_token'];
        var id = responseData['user']['id'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        await prefs.setInt('id', id);
        return responseData;
      } else {
        return {
          'error': 'Email is not verified.',
          'verified': responseData['user']['verified']
        };
      }
    } else {
      return responseData;
    }
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    print('Retrieved Token: $token');
    return token;
  }

  static Future<int?> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    return id;
  }
  static Future<String?> getUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('userType');
    return userType;
  }

 static Future<void> logoutUser() async {
    String? token = await ControllerLogin.getToken(); // Retrieve the stored token
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    String url = 'https://blaxity.codergize.com/api/logout';
    log('Logout URL: $url');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      log('Logout Response: ${response.body}');

      if (response.statusCode == 200) {
        // Handle successful logout
        var data = json.decode(response.body);
        FirebaseUtils.showSuccess('Logged out successfully');

        // Clear the token and other user data
      } else if (response.statusCode == 401) {
        // Handle unauthorized error (e.g., invalid token)
        FirebaseUtils.showError('Unauthorized: Invalid token');
        log('Error 401: Unauthorized');
      } else if (response.statusCode == 500) {
        // Handle server error
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Internal server error');
        log('Error 500: ${data['message']}');
      } else {
        // Handle unexpected errors
        FirebaseUtils.showError('Unexpected error: ${response.statusCode}');
        log('Unexpected error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that might occur during the HTTP request process
      FirebaseUtils.showError('An error occurred while logging out.');
      log('Exception: $e');
    }
  }

  /// Clears the token and user type from SharedPreferences and navigates to the splash screen
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('userType');
    await prefs.remove('id');
    Get.offAll(ScreenSplash()); // Navigate to the splash screen and remove all previous routes
  }

}
