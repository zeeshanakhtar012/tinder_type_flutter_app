import 'dart:convert';
import 'dart:developer';
import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/views/screens/screen_clubs_home.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../constants/firebase_utils.dart';
import '../models/subscription.dart';
import '../models/user.dart';
import '../views/home_page/home_page.dart';
import 'authentication_controllers/controller_sign_in_.dart';
import 'controller_home.dart'; // Assuming this contains the login-related methods

class SubscriptionController extends GetxController {
  // ControllerHome controllerHome = Get.put(Con);
  RxList<Subscription> subscriptions = <Subscription>[].obs; // List of subscriptions
  RxBool isLoading = false.obs; // Loading state

  // Fetch subscriptions from the API
  Future<void> fetchSubscriptions() async {
    String? token = await ControllerLogin.getToken(); // Get the token from login controller

    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true); // Start the loading indicator

    try {
      var response = await http.get(
        Uri.parse('${APiEndPoint.baseUrl}/subscriptions'), // Replace {{local}} with the actual API base URL
        headers: {
          'Authorization': 'Bearer $token', // Bearer token for authentication
        },
      );
      log("response: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          var subscriptionsList = jsonData['subscription'] as List;
          subscriptions.assignAll(
            subscriptionsList.map((subJson) => Subscription.fromJson(subJson)).toList(),
          );
        } else {
          FirebaseUtils.showError('Failed to load subscriptions');
        }
      } else {
        FirebaseUtils.showError('Failed to load subscriptions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred: $e');
    } finally {
      isLoading(false); // Stop the loading indicator
    }

  }
  RxBool isProcessing = false.obs; // Observable to track the loading state

  // Method to create payment
  Future<void> createPayment(String userId, String packageName, String paymentMethodId) async {
    String? token = await ControllerLogin.getToken(); // Get the token from login controller

    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isProcessing(true); // Start loading

    // API URL (replace {{local}} with the actual base URL)
    String url = '${APiEndPoint.baseUrl}/payment/create';
    int id=await ControllerLogin.getUid()?? 0;

    // Request body
    Map<String, dynamic> body = {
      'user_id':id,
      'package_name': packageName,
      'payment_method_id': "pm_card_mastercard",
    };
    log(body.toString());

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Bearer token for authentication
          'Content-Type': 'application/json', // Set content type as JSON
        },
        body: jsonEncode(body), // Encode the body as JSON
      );
      log("response: ${response.body}");
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        FirebaseUtils.showSuccess(jsonResponse['message'] ?? 'Payment created successfully');
        String? userType=await ControllerLogin.getUserType();
        if (userType=="couple") {

          UserResponse userResponse = await Get.find<ControllerHome>().fetchUserProfile();
          if (userResponse.has_couple == "1") {
            Get.offAll(HomeScreen());
          }
          else{
            FirebaseUtils.showError( "Please wait for your partner to add you to their profile.");
          }


        }
        else if (userType=="single") {
          Get.offAll(HomeScreen());
          Get.find<ControllerHome>().fetchUserInfo();
        }
        else{
          Get.find<ControllerHome>().fetchUserInfo();

          Get.offAll(ScreenClubsHome());
        }
        // Get.snackbar('Success', jsonResponse['message'] ?? 'Payment created successfully');
      } else {
        var jsonResponse = json.decode(response.body);
        FirebaseUtils.showError(jsonResponse['message'] ?? 'Failed to create payment');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred: $e');
    } finally {
      isProcessing(false); // Stop loading
    }
  }
}
