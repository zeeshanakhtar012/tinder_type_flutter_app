import 'dart:developer';
import 'dart:io';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/views/screens/screen_match_person_profile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/firebase_utils.dart';
import '../models/match_response.dart';
import 'authentication_controllers/controller_sign_in_.dart';// Import your login controller to get the token

class UserController extends GetxController {
  var isLoading = false.obs;
  var isEmailLoading = false.obs;
  var isNumberLoading = false.obs;

  Future<void> deleteUser(int userId) async {
    String? token = await ControllerLogin.getToken();

    if (token == null) {
      FirebaseUtils.showError("Authentication token is missing.");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.delete(
        Uri.parse('${APiEndPoint.baseUrl}/user/delete-account/$userId'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        // Successfully deleted the account
        final data = jsonDecode(response.body);
        FirebaseUtils.showSuccess(data['message'] ?? "Account deleted successfully.");
        // Optionally, you can navigate to another screen or perform additional actions
      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        FirebaseUtils.showError(data['message'] ?? "User not found.");
      } else if (response.statusCode == 500) {
        final data = jsonDecode(response.body);
        FirebaseUtils.showError(data['message'] ?? "An internal server error occurred.");
      } else {
        FirebaseUtils.showError("An unexpected error occurred.");
        log("Unexpected status code: ${response.statusCode}");
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log("Error deleting user: $e");
      FirebaseUtils.showError("An error occurred while deleting the user.");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> deleteClubDetails(int clubId) async {
    isLoading.value = true;

    // Get the authentication token
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      log('Token is null. Cannot delete club details.');
      isLoading.value = false;
      return;
    }

    try {
      // Create the DELETE request
      final request = http.Request(
        'DELETE',
        Uri.parse('https://blaxity.codergize.com/api/club-detail/delete/$clubId'),
      );

      // Add the authorization header
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Handle the response
      if (response.statusCode == 200) {
        // Handle success response
        log('Club details deleted successfully.');
        FirebaseUtils.showSuccess("Club details deleted successfully.");
      } else {
        // Handle error responses
        handleDeleteErrorResponse(response.statusCode, responseBody);
      }
    } catch (e) {
      log("Error deleting club details: $e");
      FirebaseUtils.showError("Error deleting club details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Method to handle error responses
  void handleDeleteErrorResponse(int statusCode, String responseBody) {
    if (statusCode == 403) {
      // Handle forbidden error
      FirebaseUtils.showError("Access forbidden: User is not an event organizer.");
    } else if (statusCode == 500) {
      // Handle server error
      FirebaseUtils.showError("Internal server error: $responseBody");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: $responseBody");
    }
  }

  Future<void> connect(String username) async {
    isLoading.value = true;
    String? token = await ControllerLogin.getToken(); // Fetch the authorization token

    if (token == null) {
      isLoading.value = false;
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    String url = '${APiEndPoint.baseUrl}/connect'; // Replace {{local}} with the actual base URL
    log('Connect URL: $url'); // Debugging

    // Request body with the username
    Map<String, String> requestBody = {
      'username': username,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Authorization header
          'Content-Type': 'application/json', // JSON content type
        },
        body: json.encode(requestBody), // Encode the body as JSON
      );

      log('Response: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        MatchResponse matchResponse = MatchResponse.fromJson(data);
        Get.to(ScreenMatchPersonProfile(matchResponse:matchResponse));
        FirebaseUtils.showSuccess(data['message'] ?? 'Connected successfully');
      } else if (response.statusCode == 404) {
        log('Error: ${response.body}');
        isLoading.value = false;
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Connection failed');
      } else if (response.statusCode == 403) {
        log('Error: ${response.body}');
        isLoading.value = false;
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Unauthorized');
      } else {
        log('Error: ${response.body}');
        isLoading.value = false;
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Failed to connect');
      }
    } catch (e) {
      log('Error: $e');
      isLoading.value = false;
      FirebaseUtils.showError('An error occurred: $e');
      log('Error: $e');
    }
    finally {
      isLoading.value = false;
    }
  }
  Future<void> sendWhatsAppMessage(String? number, String url,String? email) async {
    String? token = await ControllerLogin.getToken(); // Fetch the authorization token

    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }
 isLoading.value = true;
    String apiUrl = '${APiEndPoint.baseUrl}/send-whatsapp'; // Replace {{local}} with the actual base URL
    log('Send WhatsApp URL: $apiUrl'); // Debugging

    // Request body with the number and URL  ..
    Map<String, dynamic> requestBody = {
      // 'number': number,
      'url': url,
    };
if (email==null) {
  requestBody['number'] = number;
}
if (number==null) {
  requestBody['email'] = email;
}
log(requestBody.toString());

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Authorization header
          'Content-Type': 'application/json', // JSON content type
        },
        body: json.encode(requestBody), // Encode the body as JSON
      );

      log('Response: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        FirebaseUtils.showSuccess(data['message'] ?? 'WhatsApp message sent successfully');
      } else if (response.statusCode == 404) {
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Recipient not found');
      } else if (response.statusCode == 500) {
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Internal Server Error');
      } else {
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Failed to send message');
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred: $e');
      log('Error: $e');
    }
    finally{
      isLoading.value = false;
    }
  }
  Future<void> swipeAction() async {
    String? token = await ControllerLogin.getToken(); // Get token for authorization
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true); // Start loading

    // API URL (replace {{local}} with actual base URL)
    String url = '${APiEndPoint.baseUrl}/user/swipe';

    // Request body


    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Bearer token for authentication
          'Content-Type': 'application/json',
        },
        // Encode body as JSON
      );

      log('Swipe Response: ${response.body}');


      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // // Extract swipe count and golden membership status
        // int remainingSwipes = jsonResponse['remaining_swipes'] ?? 0;
        // bool isGoldenMember = jsonResponse['is_golden_member'] ?? false;
        //
        // if (!isGoldenMember) {
        //   // Case: User is not a golden member and has 5 or fewer swipes left
        //   if (remainingSwipes > 0 && remainingSwipes <= 5) {
        //     Get.snackbar('Swipes Left', 'You have $remainingSwipes swipes left. Buy more swipes or become a golden member for unlimited swipes!');
        //     FirebaseUtils.showError('You have $remainingSwipes swipes left. Buy more swipes or become a golden member for unlimited swipes!');
        //   } else if (remainingSwipes == 0) {
        //     // Case: User has no swipes left
        //     Get.snackbar('No Swipes Left', 'You have no swipes left. Please buy more swipes or become a golden member for unlimited swipes!');
        //     FirebaseUtils.showError('You have no swipes left. Please buy more swipes or become a golden member for unlimited swipes!');
        //   }
        // } else {
        //   Get.snackbar('Success', 'Swipe successful. You are a golden member with unlimited swipes.');
        // }
      } else {
        // Handle error response
        var jsonResponse = json.decode(response.body);
        FirebaseUtils.showError(jsonResponse['message'] ?? 'Failed to process swipe.');
      }
    } catch (e) {
      // Error in the request
      FirebaseUtils.showError('An error occurred: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }

RxBool isSelfieUploaded = false.obs;
  Future<void> uploadSelfie(File selfie,String description) async {
    isSelfieUploaded.value = true;
    var request = http.MultipartRequest(
        'POST',
        Uri.parse('${APiEndPoint.baseUrl}/verification/${FirebaseUtils.myId}')
    );

    // Attach the selfie image file to the request
    request.files.add(
        await http.MultipartFile.fromPath('selfie', selfie.path)
    );
    request.headers['Authorization'] = 'Bearer ${await ControllerLogin.getToken()}';
    request.fields['description'] = description;

    // Send the request
    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    // Get response data
    log('Selfie upload response: ${responseData}');
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);
      isSelfieUploaded.value = false;
      FirebaseUtils.showSuccess(jsonResponse['message'] ?? 'Selfie uploaded successfully');
      print('Selfie uploaded successfully: $responseData');
    } else {
      isSelfieUploaded.value = false;
      var jsonResponse = json.decode(responseData);
      FirebaseUtils.showError(jsonResponse['message'] ?? 'Failed to upload selfie');
      print('Failed to upload selfie. Status code: ${response.statusCode}');
    }
  }

}

