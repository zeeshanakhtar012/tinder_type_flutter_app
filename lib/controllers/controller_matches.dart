import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:get/get.dart';

import '../constants/firebase_utils.dart';
import 'authentication_controllers/controller_sign_in_.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControllerMatches extends GetxController {
  var isLoading = false.obs;
  // var matches = <Matches>[].obs;
  Future<void> fetchMatches() async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError( 'Authentication token is missing');
      return;
    }
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse(APiEndPoint.getMatches),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // log("other events${response.body}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Assuming the API returns a JSON object with a 'data' key that contains a list of events
        if (jsonData['data'] != null && jsonData['data'] is List) {
          // Correctly map the JSON data to a list of Event objects
          // List<Matches> matchesList = (jsonData['data'] as List)
          //     .map((eventJson) => Matches.fromJson(eventJson))
          //     .toList();
          //
          // Update the observable list
          // matches.value = matchesList;
        }
        else {
          FirebaseUtils.showError( 'Unexpected data format received');
        }
      }
      else {
        FirebaseUtils.showError( 'Failed to fetch events. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching events: $e');
      FirebaseUtils.showError( 'An error occurred while fetching events');
    } finally {
      isLoading(false);
    }
  }
}