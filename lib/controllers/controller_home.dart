import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/views/screens/screen_match_person_profile.dart';
import 'package:blaxity/views/screens/screen_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/ApiEndPoint.dart';
import '../constants/fcm.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'authentication_controllers/controller_sign_in_.dart';

class ControllerHome extends GetxController {
  RxBool isFirstTime = true.obs;



  Future<void> _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOverlay = prefs.getBool('hasSeenOverlay') ?? false;
    isFirstTime.value = !hasSeenOverlay;
  }

  Future<void> setHasSeenOverlay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOverlay', true);
    isFirstTime.value = false;
    _checkIfFirstTime();
  }
  Future<void> updateToken() async {
    var token = (await FCM.generateToken()) ?? "";
    log(token);
    String? accessToken = await ControllerLogin.getToken();
    log(accessToken.toString());

    if (token.isEmpty || accessToken == null) {
      log('Error: Token or AccessToken is null or empty');
      return;
    }

    // API endpoint
    String endpoint = "${APiEndPoint.baseUrl}/update-device-token";

    // Create the payload
    Map<String, String> payload = {
      'device_token': token,
    };

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(payload),
      );
      log(response.body);
      if (response.statusCode == 200) {
        log('Token updated successfully');
      } else {
        log('Failed to update token: ${response.statusCode}');
      }
    } catch (e) {
      log('Error updating token: $e');
    }
  }

  RxBool isLoading = false.obs;

  Future<UserResponse> fetchUserProfile() async {
    int id = await ControllerLogin.getUid() ?? 0;
    String token = await ControllerLogin.getToken() ?? "";
    log("Id $id");
    log("Token $token");

    final response = await http.get(
      Uri.parse('${APiEndPoint.baseUrl}/user/all-data/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    log(response.body);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return UserResponse.fromJson(data);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<UserResponse> fetchUserByIdProfile(int id) async {
    String token = await ControllerLogin.getToken() ?? "";
    log("Id $id");
    log("Token $token");

    final response = await http.get(
      Uri.parse('${APiEndPoint.baseUrl}/user/all-data/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    log(response.body);

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Rx<UserResponse?> user = Rx<UserResponse?>(null);

  Future<void> fetchUserInfo() async {
    await updateToken();
    try {
      isLoading.value = true; // Set loading to true before starting the fetch
      user.value = await fetchUserProfile();
    } catch (e) {
      FirebaseUtils.showError(e.toString());
    } finally {
      isLoading.value = false; // Set loading to false after fetch is complete
    }
  }

  @override
  void onInit() {
    fetchUserInfo();
    _checkIfFirstTime();

    _startLocationUpdates();
    // TODO: implement onInit
    super.onInit();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.remove('usertype');
    prefs.remove('id');
    Get.offAll(ScreenSplash());
  }

  Future<void> blockUser({
    required String blockedUserId,
  }) async {
    String? token = await ControllerLogin.getToken();

    if (token == null) {
      FirebaseUtils.showError("Authentication token is missing.");
      return;
    }

    isLoading.value = true;

    // Build the request body
    Map<String, dynamic> body = {
      'blocked_user_id': blockedUserId,
    };

    try {
      final response = await http.post(
        Uri.parse('https://blaxity.codergize.com/api/profile/block-user'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      log('Response: ${response.body}');
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Handle success response
        FirebaseUtils.showSuccess("User blocked successfully.");
        log("User blocked successfully.");
      } else if (response.statusCode == 422) {
        // Handle validation errors
        if (data['blocked_user_id'] != null) {
          FirebaseUtils.showError(
              "Blocked user ID: ${data['blocked_user_id'].join(', ')}");
        }
        log("Validation error: ${response.body}");
      } else if (response.statusCode == 500) {
        // Handle server error
        FirebaseUtils.showError("Internal server error: ${data['message']}");
        log("Server error: ${response.body}");
      } else {
        FirebaseUtils.showError("Failed to block user. Unexpected error.");
        log("Unexpected status code: ${response.statusCode}");
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log("Error blocking user: $e");
      FirebaseUtils.showError("An error occurred while blocking the user.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reportUser({
    required String reason,
    required String reportedUserId,
  }) async {
    String? token = await ControllerLogin.getToken();

    if (token == null) {
      FirebaseUtils.showError("Authentication token is missing.");
      return;
    }

    isLoading.value = true;

    // Build the request body
    Map<String, dynamic> body = {
      'reason': reason,
      'reported_user_id': reportedUserId,
    };

    try {
      final response = await http.post(
        Uri.parse('https://blaxity.codergize.com/api/profile/report-user'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      log('Response: ${response.body}');
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Handle success response
        FirebaseUtils.showSuccess("User reported successfully.");
        log("User reported successfully.");
      } else if (response.statusCode == 422) {
        // Handle validation errors
        if (data['reported_user_id'] != null) {
          FirebaseUtils.showError(
              "Reported user ID: ${data['reported_user_id'].join(', ')}");
        }
        if (data['reason'] != null) {
          FirebaseUtils.showError("Reason: ${data['reason'].join(', ')}");
        }
        log("Validation error: ${response.body}");
      } else if (response.statusCode == 500) {
        // Handle server error
        FirebaseUtils.showError("Internal server error: ${data['message']}");
        log("Server error: ${response.body}");
      } else {
        FirebaseUtils.showError("Failed to report user. Unexpected error.");
        log("Unexpected status code: ${response.statusCode}");
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log("Error reporting user: $e");
      FirebaseUtils.showError("An error occurred while reporting the user.");
    } finally {
      isLoading.value = false;
    }
  }

  Rx<Position?> currentPosition =
      Rx<Position?>(null); // Rx variable for position
  void _startLocationUpdates() async {
    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      log('Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // Start listening to location updates
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update location every 10 meters
      ),
    ).listen((Position position) {
      currentPosition.value = position; // Update Rx variable with new location
      log('Current Position: ${position.latitude}, ${position.longitude}');
    });
  }
  Future<void> viewUserCount(int userId) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true);
    String url = '${APiEndPoint.baseUrl}/user/view/$userId';
    log('View User URL: $url');

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // log('View User Response: ${response.body}');

      if (response.statusCode == 200) {
        // Handle success response
        var data = json.decode(response.body);
        // FirebaseUtils.showSuccess('User details fetched successfully');
        // Update your UI or state with the user details
        // log('User Details: $data');
      } else if (response.statusCode == 404) {
        // Handle user not found error
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'User not found');
        log('Error 404: ${data['message']}');
      } else if (response.statusCode == 403) {
        // Handle unauthorized error
        var data = json.decode(response.body);
        FirebaseUtils.showError(data['message'] ?? 'Unauthorized');
        log('Error 403: ${data['message']}');
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
      // Handle any other errors that might occur
      FirebaseUtils.showError('An error occurred while fetching user details.');
      log('Exception: $e');
    } finally {
      isLoading(false);
    }
  }
  RxBool fetchingUsers = false.obs;
  Future<List<User>> fetchUsersByIds(List<int> ids) async {
    String? token = await ControllerLogin.getToken(); // Fetch authentication token
  fetchingUsers(true);
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      fetchingUsers(false);
      return List.empty();
    }

    // Ensure the IDs are always wrapped in an array
    if (ids.isEmpty) {
      FirebaseUtils.showError('No IDs provided.');
      fetchingUsers(false);
      return List.empty();
    }

    String apiUrl = '${APiEndPoint.baseUrl}/users/byids';

    // Convert the list of IDs into a query string parameter
    String queryParams = ids.map((id) => 'ids[]=$id').join('&');
    String url = '$apiUrl?$queryParams'; // Append the query parameters to the URL
    log('Request URL: $url'); // Debug log for the URL

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      log('Response: ${response.body}');
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Handle successful response
        List<User> users=data["users"].map<User>((json) => User.fromJson(json)).toList();
        return users;
        FirebaseUtils.showSuccess('Users fetched successfully.');
        // You can process the data or update your state here
      } else if (response.statusCode == 404) {
        // Handle user not found error
        FirebaseUtils.showError(data['message'] ?? 'User not found');
        return List.empty();

      } else {

        FirebaseUtils.showError('Failed to fetch users: ${data['message']}');
        return List.empty();
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred: $e');
      log('Error: $e');
      return List.empty();

    }
    finally{
      fetchingUsers(false);
    }
  }
//   Future<void> sendUserLink(int userId, String userLink) async {
//     String? token = await ControllerLogin.getToken(); // Get the token from login controller
//
//     if (token == null) {
//       FirebaseUtils.showError('Authentication token is missing');
//       return;
//     }
//
//     isLoading(true); // Start loading
//
//     // API URL (replace {{local}} with the actual base URL)
//     String url = '${APiEndPoint.baseUrl}/link';
//
//     log('api end point: $url');
//
//     // Request body
//     Map<String, dynamic> body = {
//       'userId': userId,
//       'user_link': userLink,
//     };
// log(body.toString());
//     try {
//       var response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token', // Bearer token for authentication
//           'Content-Type': 'application/json', // Setting content type as JSON
//         },
//         body: jsonEncode(body), // Encode the body as JSON
//       );
//       log(response.body.toString());
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Get.to(ScreenMatchPersonProfile());
//         var jsonResponse = json.decode(response.body);
//         Get.snackbar('Success', jsonResponse['message'] ?? 'Link sent successfully');
//       } else {
//         log(response.body.toString());
//         var jsonResponse = json.decode(response.body);
//         FirebaseUtils.showError(jsonResponse['message'] ?? 'Failed to send link');
//       }
//     } catch (e) {
//       log(e.toString());
//       FirebaseUtils.showError('An error occurred: $e');
//     } finally {
//       isLoading(false); // Stop loading
//     }
//   }
}

