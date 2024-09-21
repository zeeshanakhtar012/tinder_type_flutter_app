import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

class ControllerUpdateProfile extends GetxController {
  var isLoading = false.obs;
  var user = User().obs;  // Reactive user property

  // Method to set the initial user
  void setUser(User newUser) {
    user.value = newUser;
  }

  Future<void> updateUserProfile(User updatedUser) async {
    isLoading(true);
    String? token = await ControllerLogin.getToken();

    try {
      final response = await http.post(
        Uri.parse('https://blaxity.codergize.com/api/user/update-profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'height': updatedUser.reference!.height,
          'eye_color': updatedUser.reference!.eyeColor,
          'ethnicity': updatedUser.reference!.ethnicity,
          'education': updatedUser.reference!.education,
          'language': updatedUser.reference!.language,
          'drink_habit': updatedUser.additionalInfo!.drinkingHabit,
          'smoke_habit': updatedUser.additionalInfo!.smokingHabit,
          'body_type': updatedUser.additionalInfo!.bodyType,
          'safety_practices': updatedUser.additionalInfo!.safetyPractice,
          'hobbies': updatedUser.hobbies,
          'desires': updatedUser.desires,
          'parties': updatedUser.parties,
          'looking_for': updatedUser.reference!.lookingFor,
          'attributes': updatedUser.reference!.attributes,
          'location': updatedUser.reference!.location,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("Profile updated successfully: $jsonResponse");
        user.value = updatedUser;  // Update user with new data
      } else {
        print("Failed to update profile: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while updating profile: $e");
    } finally {
      isLoading(false);
    }
  }
}
