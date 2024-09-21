import 'dart:convert';
import 'dart:developer';
import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_photos_page5.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_wait_list_club.dart';
import 'package:blaxity/views/screens/screen_clubs_home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/firebase_utils.dart';
import '../../models/event.dart' as model;

import '../../models/user.dart';

class ControllerCreateEvent extends GetxController {
  List<String> optionsParties = [
    'Meet & Greet', 'Swinger Cruise', 'House Party', 'Glow Party', 'Key Party', 'Swinger Resort',
  ];

  RxString selectPartyType = "".obs;
  RxString eventPrivacy = "".obs;
  RxString eventPricing = "".obs;
  XFile? image;
  RxString capacity = "".obs;
  RxInt attendeeLimit = 0.obs;
  var capacityLimited = false.obs;
  var isLoading = false.obs;

  var eventTitleController = TextEditingController();
  var eventDescriptionController = TextEditingController();
  var eventDateController = TextEditingController();
  var eventTimeController = TextEditingController();
  var eventPriceController = TextEditingController();
  var locationController = TextEditingController();
  var entrancePriceController = TextEditingController();

  void increment() {
    attendeeLimit.value++;
  }

  void decrement() {
    if (attendeeLimit.value > 0) {
      attendeeLimit.value--;
    }
  }

  Future<void> CreateEvent(bool isHome,User user) async {
    isLoading.value = true;
    String? token = await ControllerLogin.getToken();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(APiEndPoint.createEvent),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    }

    request.fields.addAll({
      'title': eventTitleController.text,
      'description': eventDescriptionController.text,
      'date': eventDateController.text,
      'time': formatTime(eventTimeController.text), // Ensure time is in HH:mm:ss format
      'type_of_party': selectPartyType.value,
      'privacy': eventPrivacy.value,
      'pricing': eventPricing.value,
      'capacity_limited': capacityLimited.value==true?'1':'0',
      'attendee_limit': capacityLimited.value ? attendeeLimit.value.toString() : '0',
      'location': locationController.text,
      'enterance_price': eventPricing.value == 'Paid' ? entrancePriceController.text : '0',
    });


    print("Request fields: ${request.fields}");
    isLoading.value = true;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Response status: ${response.statusCode}");
      print("Response body: $responseBody");

      if (response.statusCode == 201) {
        final data = jsonDecode(responseBody);
        log("Event created successfully.");
        FirebaseUtils.showSuccess("Event created successfully.");

        if (isHome) {
          EventController().fetchEvents();
          EventController().fetchMyEvents();
          Navigator.pop(Get.context!);
        } else {
          String? userType = await ControllerLogin.getUserType();
          if (userType == "individual_event_organizer") {
            Get.offAll(ScreenAddPhotos(step: "", user: user));
          } else {
            Get.offAll(ScreenWaitListClub(user: user));
          }
        }
      } else {
        // Handle error responses
        handleCreateEventErrorResponse(response.statusCode, responseBody);
      }
    } catch (e) {
      log("Error during event creation: $e");
      FirebaseUtils.showError("Error during event creation: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Method to handle error responses
  void handleCreateEventErrorResponse(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    if (statusCode == 400) {
      // Handle validation errors
      FirebaseUtils.showError("Validation Error: ${data['message']}");
      if (data['errors'] != null) {
        final errors = data['errors'] as Map<String, dynamic>;
        errors.forEach((field, messages) {
          FirebaseUtils.showError("$field: ${messages.join(', ')}");
        });
      }
    } else if (statusCode == 500) {
      // Handle server errors
      FirebaseUtils.showError("Internal Server Error: ${data['message']}");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }
  Future<void> updateEvent(model.Event event) async {
    isLoading.value = true;
    String? token = await ControllerLogin.getToken();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(APiEndPoint.updateEvent+"${event.id}"),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    }

    request.fields.addAll({
      'title': eventTitleController.text,
      'description': eventDescriptionController.text,
      'date': eventDateController.text,
      'time': formatTime(eventTimeController.text), // Ensure time is in HH:mm:ss format
      'type_of_party': selectPartyType.value,
      'privacy': eventPrivacy.value,
      'pricing': eventPricing.value,
      'capacity_limited': capacityLimited.value==true?'1':'0',
      'attendee_limit': capacityLimited.value ? attendeeLimit.value.toString() : '0',
      'location': locationController.text,
      'enterance_price': eventPricing.value == 'Paid' ? entrancePriceController.text : '0',
    });


    print("Request fields: ${request.fields}");
    isLoading.value = true;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      log("Response status code: ${response.statusCode}");
      log("Response body: $responseBody");

      if (response.statusCode == 200) {
        // Success
        final data = jsonDecode(responseBody);
        FirebaseUtils.showSuccess("Event updated successfully");
      } else {
        handleUpdateEventErrorResponse(response.statusCode, responseBody);
      }
    } catch (e) {
      log("Error during event update: $e");
      FirebaseUtils.showError("Error during event update: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void handleUpdateEventErrorResponse(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    if (statusCode == 403) {
      // Handle unauthorized errors
      FirebaseUtils.showError("Unauthorized: ${data['message']}");
    } else if (statusCode == 404) {
      // Handle event not found errors
      FirebaseUtils.showError("Event not found: ${data['message']}");
    } else if (statusCode == 500) {
      // Handle server errors
      FirebaseUtils.showError("Internal Server Error: ${data['message']}");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }
  String formatTime(String timeString) {
    // Check if the timeString contains AM/PM
    bool isPM = timeString.toLowerCase().contains("pm");
    bool isAM = timeString.toLowerCase().contains("am");

    // Remove AM/PM from the time string
    timeString = timeString.replaceAll(RegExp(r'[a-zA-Z]'), '').trim();

    // Split the time string into components
    final timeParts = timeString.split(":");

    // Ensure we have hour and minute parts
    if (timeParts.length < 2) {
      throw FormatException("Invalid time format");
    }

    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    // Convert 12-hour format to 24-hour format
    if (isPM && hour != 12) {
      hour += 12;
    } else if (isAM && hour == 12) {
      hour = 0;
    }

    final formattedHour = hour.toString().padLeft(2, '0');
    final formattedMinute = minute.toString().padLeft(2, '0');
    final second = timeParts.length > 2 ? int.parse(timeParts[2]).toString().padLeft(2, '0') : '00';

    return '$formattedHour:$formattedMinute:$second';
  }

  Future<void> deleteEvent({
    required int eventId,
  }) async {
    isLoading.value = true;
    String? token = await ControllerLogin.getToken();

    final request = http.Request(
      'DELETE',
      Uri.parse('${APiEndPoint.deleteEvent}/$eventId'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      log("Response status code: ${response.statusCode}");
      log("Response body: $responseBody");

      if (response.statusCode == 200) {
        // Success
        final data = jsonDecode(responseBody);
        FirebaseUtils.showSuccess("Event deleted successfully");
      } else {
        handleDeleteEventErrorResponse(response.statusCode, responseBody);
      }
    } catch (e) {
      log("Error during event deletion: $e");
      FirebaseUtils.showError("Error during event deletion: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void handleDeleteEventErrorResponse(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    if (statusCode == 403) {
      // Handle unauthorized errors
      FirebaseUtils.showError("Unauthorized: ${data['message']}");
    } else if (statusCode == 404) {
      // Handle event not found errors
      FirebaseUtils.showError("Event not found: ${data['message']}");
    } else if (statusCode == 500) {
      // Handle server errors
      FirebaseUtils.showError("Internal Server Error: ${data['message']}");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }

}
