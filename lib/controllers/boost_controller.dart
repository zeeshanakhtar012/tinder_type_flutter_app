import 'dart:convert';
import 'dart:developer';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../constants/ApiEndPoint.dart';
import '../constants/firebase_utils.dart';
import '../models/boost.dart';
import 'authentication_controllers/controller_sign_in_.dart';
// Assuming this contains the login-related methods

class BoostController extends GetxController {
  RxList<Boost> boosts = <Boost>[].obs; // List of boosts
  RxBool isLoading = false.obs; // Loading state

  // Fetch boosts from the API
  Future<void> fetchBoosts() async {
    String? token = await ControllerLogin.getToken(); // Get the token from login controller

    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true); // Start the loading indicator

    try {
      var response = await http.get(
        Uri.parse('${APiEndPoint.baseUrl}/boosts'), // Replace {{local}} with the actual API base URL
        headers: {
          'Authorization': 'Bearer $token', // Bearer token for authentication
        },
      );
        log("response: ${response.body}");
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          var boostsList = jsonData['boosts'] as List;
          boosts.assignAll(
            boostsList.map((boostJson) => Boost.fromJson(boostJson)).toList(),
          );
        } else {
          FirebaseUtils.showError('Failed to load boosts');
        }
      } else {
        FirebaseUtils.showError('Failed to load boosts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred: $e');
    } finally {
      isLoading(false); // Stop the loading indicator
    }
  }
  @override
  void onInit() {
    fetchBoosts();
    // TODO: implement onInit
    super.onInit();
  }
  RxBool isProcessing = false.obs; // Observable to track payment processing state

  // Method to process payment boost
  Future<void> createBoostPayment(String userId, String packageName, String paymentMethodId) async {
    String? token = await ControllerLogin.getToken(); // Get the token from login controller

    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isProcessing(true); // Start processing

    // API URL (replace {{local}} with the actual base URL)
    String url = '${APiEndPoint.baseUrl}/payment/boost/create';

    // Request body
    Map<String, dynamic> body = {
      'user_id':int.parse( Get.find<ControllerHome>().user.value!.user.id!),
      'package_name': packageName,
      'payment_method_id': "pm_card_mastercard",
    };
    log(body.toString());

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Bearer token for authentication
          'Content-Type': 'application/json', // Setting content type as JSON
        },
        body: jsonEncode(body), // Encode the body as JSON
      );
      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        Navigator.pop(Get.context!);
        Get.find<ControllerHome>().fetchUserInfo();
        FirebaseUtils.showSuccess(jsonResponse['message'] ?? 'Payment processed successfully');
        // Get.snackbar('Success', jsonResponse['message'] ?? 'Payment processed successfully');
      } else {
        log(response.body);
        var jsonResponse = json.decode(response.body);
        FirebaseUtils.showError(jsonResponse['message'] ?? 'Failed to process payment');
      }
    } catch (e) {
      log(e.toString());
      FirebaseUtils.showError('An error occurred: $e');
    } finally {
      isProcessing(false); // Stop processing
    }
  }
  Future<void> activateBoost() async {
    isLoading(true); // Show loading

    try {
      // Get the auth token
     String? token = await ControllerLogin.getToken();

      if (token == null) {
        Get.snackbar('Error', 'Authentication token is missing');
        return;
      }

      // API endpoint
      String url = 'https://blaxity.codergize.com/api/boost/activate';

      // Request body


      // Send POST request
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },

      );
      log(response.body);

      // Handle the response
      if (response.statusCode == 200|| response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        Get.find<ControllerHome>().fetchUserInfo();
        Get.snackbar('Success', jsonResponse['message'] ?? 'Boost activated successfully.');
      } else {
        log(response.body);
        var jsonResponse = jsonDecode(response.body);
        Get.snackbar('Error', jsonResponse['message'] ?? 'Failed to activate boost.');
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false); // Hide loading
    }
  }
}
