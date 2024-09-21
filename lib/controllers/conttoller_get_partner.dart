import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'authentication_controllers/controller_sign_in_.dart'; // Assuming token retrieval

class ControllerGetPartner extends GetxController {
  var isLoading = false.obs; // Observable for loading state
  var partnerData = {}.obs;
  var errorMessage = ''.obs;
  Rx<User?> user = Rx<User?>(null);
  Future<void> getPartner(String referral_shared_link) async {
    isLoading.value = true; // Start loading
    try {
      String apiUrl = 'https://blaxity.codergize.com/api/partner';
      String? token = await ControllerLogin.getToken(); // Retrieve token
      var request = http.Request('GET', Uri.parse(apiUrl))
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        })
        ..body = json.encode({
          "referral_shared_link": "${referral_shared_link}"
        }); // Attach the body to the request

      // Send the request using http.Client
      var client = http.Client();
      var streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);
      log(response.body);
      log(request.body);
      log(referral_shared_link.toString());
      if (response.statusCode == 200) {
        // Parse the response body
        var data = json.decode(response.body);

        // Assuming the API returns a JSON object
        partnerData.value = data;
        user.value=User.fromJson(partnerData['user']);
        log(user.value!.id!.toString());
        print("Partner data fetched successfully: ${partnerData.value}");
      } else {
        // Handle error response
        errorMessage.value = "Failed to fetch data: ${response.statusCode}";
        print(errorMessage.value);
      }
    } catch (e) {
      // Handle any other exceptions
      errorMessage.value = "Error: $e";
      print(errorMessage.value);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
