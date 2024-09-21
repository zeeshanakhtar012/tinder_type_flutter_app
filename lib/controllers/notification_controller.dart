import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import '../models/user.dart';

class NotificationController extends GetxController {
  // Reactive state management variables
  var isLoading = false.obs;
  RxList<Notification> notifications = <Notification>[].obs;

  // Fetch notifications from API
  Future<void> fetchNotifications() async {
    isLoading.value = true; // Set loading to true
    try {
      String apiUrl = 'https://blaxity.codergize.com/api/notifications';
      String? token = await ControllerLogin.getToken(); // Implement getToken() to retrieve your token

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log(response.body);
      if (response.statusCode == 200) {
        // Parse and store the response data
        var data = json.decode(response.body);

        // Check if 'notification' field exists and is not empty
        if (data['notifications'] != null) {
          notifications.value = parseNotifications(data['notifications']);
        } else {
          notifications.value = [];
        }
      } else {
        notifications.value = [];
        print("Failed to fetch notifications. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      notifications.value = []; // Ensure list is empty on error
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }

  // Helper method to parse a list of notifications
  List<Notification> parseNotifications(List<dynamic> notificationsJson) {
    return notificationsJson.map<Notification>((json) => Notification.fromJson(json)).toList();
  }


}
