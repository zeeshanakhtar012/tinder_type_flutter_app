import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../controllers/authentication_controllers/controller_sign_in_.dart';
import '../controllers/authentication_controllers/controller_sign_in_.dart';
import '../models/group.dart';

class GroupController extends GetxController {
  var groups = <Group>[].obs;
  Rx<Group?> selectedGroup = Rx<Group?>(null);

  var joinRequests = <JoinRequest>[].obs;
  var isLoading = true.obs;
  var isAccepting = false.obs;  // Loading state for accepting a request
  var isRejecting = false.obs;

  @override
  void onInit() {
    fetchGroups();
    super.onInit();
  }
  Future<void> fetchGroup(int groupId) async {
    try {
      isLoading(true); // Start loading indicator

      String? token = await ControllerLogin.getToken(); // Fetch token
      if (token == null) {
        FirebaseUtils.showError("Authentication token is missing");
        return;
      }

      final response = await http.get(
        Uri.parse('${APiEndPoint.baseUrl}/groups/$groupId'), // Construct the endpoint dynamically
        headers: {
          'Authorization': 'Bearer $token', // Authorization header
        },
      );

      log(response.body); // Log the response for debugging

      if (response.statusCode == 200) {
        // Parse the response body to extract group data
        Map<String, dynamic> responseData = json.decode(response.body);
        Group group = Group.fromJson(responseData['group']); // Convert JSON to Group object

        // Update your state with the fetched group
        selectedGroup.value = group;
        log("Fetched Group: ${group.title}");
      } else {
        handleFetchGroupError(response.statusCode, response.body);
      }
    } catch (e) {
      log("Error: $e"); // Print the error for debugging
      FirebaseUtils.showError("An error occurred while fetching the group");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  void handleFetchGroupError(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    switch (statusCode) {
      case 404:
        FirebaseUtils.showError("Group not found");
        break;
      case 500:
        FirebaseUtils.showError("Internal Server Error: ${data['message']}");
        break;
      default:
        FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }


  Future<void> fetchGroups({String? search}) async {
    isLoading.value = true; // Start loading indicator

    try {
      String apiUrl = APiEndPoint.getAllGroups;
      String? token = await ControllerLogin.getToken(); // Retrieve token

      if (token == null) {
        Get.snackbar('Error', 'Authentication token is missing');
        isLoading.value = false; // Stop loading
        return;
      }

      // Create the query parameters
      Map<String, String> queryParams = {};
      if (search != null) queryParams['search'] = search;

      // Construct the URI with query parameters
      var uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

      // Create the request
      var request = http.Request('GET', uri)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });

      // Send the request using http.Client
      var client = http.Client();
      var streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);

      log("Groups response: ${response.body}");

      if (response.statusCode == 200) {
        // Parse the response body to extract the list of groups
        Map<String, dynamic> responseData = json.decode(response.body);
           groups.value = (responseData['groups'] as List).map((groupData) => Group.fromJson(groupData)).toList();

        log("Group List Length: ${groups.length}"); // Log the length of the group list
        print("Groups fetched successfully.");
      } else {
        log("Error${response.body}");
        // Handle error responses
        handleFetchGroupsError(response.statusCode, response.body);
      }
    } catch (e) {
      log(e.toString());
      FirebaseUtils.showError("An error occurred while fetching groups: ${e.toString()}");
    } finally {
      isLoading.value = false; // Stop loading indicator
    }
  }

  void handleFetchGroupsError(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    switch (statusCode) {
      case 500:
        FirebaseUtils.showError("Internal Server Error: ${data['message']}");
        break;
      default:
        FirebaseUtils.showError("Unexpected error: ${data['message'] ?? 'Unknown error'}");
    }
  }
  Future<void> joinGroup(int groupId) async {
    String? token = await ControllerLogin.getToken();

    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    final url = Uri.parse('${APiEndPoint.joinGroup}$groupId');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(url, headers: headers);
      log("Join Group Response: ${response.body}");

      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
        // Successfully joined group
          fetchGroups(); // Refresh groups list
          fetchGroup(groupId); // Refresh details of the joined group
          FirebaseUtils.showSuccess(data['message']);
          print('Success: ${data['message']}');
          break;

        case 404:
        // Group not found
          FirebaseUtils.showError(data['message']);
          print('Error: ${data['message']}');
          break;

        case 400:
        // Bad request, possibly due to attendee limit or pending request
          FirebaseUtils.showError(data['message']);
          print('Error: ${data['message']}');
          break;

        case 500:
        // Internal server error
          FirebaseUtils.showError(data['message']);
          print('Error: ${data['message']}');
          break;

        default:
        // Unexpected status code
          FirebaseUtils.showError('Unexpected error occurred');
          print('Unexpected error: ${response.statusCode}');
          break;
      }
    } catch (e) {
      // Handle exceptions
      FirebaseUtils.showError('Failed to join group: ${e.toString()}');
      print('Exception: $e');
    }
  }
  Future<void> fetchGroupRequests(int groupId) async {
    String? token = await ControllerLogin.getToken();

    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true);
    final url = Uri.parse('${APiEndPoint.baseUrl}/groups/join-requests/$groupId');
    log('Fetching Group Requests from: $url');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('Group Requests Response: ${response.body}');

      switch (response.statusCode) {
        case 200:
          final jsonData = jsonDecode(response.body);
          if (jsonData['status'] == 'success') {
            final requestsList = jsonData['join_requests'] as List;
            joinRequests.assignAll(
              requestsList.map((requestJson) => JoinRequest.fromJson(requestJson)).toList(),
            );
            log('Group Requests Details: ${joinRequests.length} requests fetched');
          } else {
            FirebaseUtils.showError('Unexpected data format received');
            log('Unexpected data format');
          }
          break;

        case 404:
          FirebaseUtils.showError('Group not found');
          log('Error 404: Group not found');
          break;

        case 403:
          FirebaseUtils.showError('Unauthorized to view join requests');
          log('Error 403: Unauthorized');
          break;

        case 500:
          final errorData = jsonDecode(response.body);
          FirebaseUtils.showError(errorData['message'] ?? 'Internal server error');
          log('Error 500: ${errorData['message']}');
          break;

        default:
          FirebaseUtils.showError('Unexpected status code: ${response.statusCode}');
          log('Unexpected status code: ${response.statusCode}');
          break;
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred while fetching group requests.');
      log('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptGroupRequest(int groupId, int requestId) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isAccepting(true);
    String url = '${APiEndPoint.baseUrl}/groups/accept-join-request/$groupId';
    log('Accept Request URL: $url');

    try {
      var body = {
        'user_id': "$requestId"
      };
      var response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json', // Ensure the content type is set to JSON
            'Authorization': 'Bearer $token',
          },
          body: json.encode(body) // Encode the body as JSON
      );

      log('Accept Request Response: ${response.body}');

      switch (response.statusCode) {
        case 200:
          fetchGroupRequests(groupId);
          FirebaseUtils.showSuccess('Request has been accepted successfully.');
          // Optionally, refresh the list of group requests
          break;

        case 404:
          FirebaseUtils.showError('Group not found');
          log('Error 404: Group not found');
          break;

        case 403:
          FirebaseUtils.showError('Unauthorized to accept join requests');
          log('Error 403: Unauthorized');
          break;

        case 422:
          final errorData = json.decode(response.body);
          FirebaseUtils.showError(errorData['user_id']?.join(', ') ?? 'User ID is required');
          log('Error 422: ${errorData['user_id']}');
          break;

        case 500:
          final errorData = json.decode(response.body);
          FirebaseUtils.showError(errorData['message'] ?? 'Internal server error');
          log('Error 500: ${errorData['message']}');
          break;

        default:
          FirebaseUtils.showError('Unexpected status code: ${response.statusCode}');
          log('Unexpected status code: ${response.statusCode}');
          break;
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred while accepting the request.');
      log('Exception: $e');
    } finally {
      isAccepting(false);
    }
  }

  Future<void> deleteGroup(int groupId) async {
    try {
      isLoading.value = true; // Set loading state to true

      String? token = await ControllerLogin.getToken();
      if (token == null) {
        FirebaseUtils.showError("Authentication token is missing");
        return;
      }

      // Define the URL for the delete request
      String url = '${APiEndPoint.DeleteGroup}${groupId}';

      // Create the DELETE request
      var request = http.Request('DELETE', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token';

      // Send the request using http.Client
      var client = http.Client();
      var streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);

      // Handle response
      if (response.statusCode == 200) {
        FirebaseUtils.showSuccess("Group deleted successfully");
        log('Group deleted successfully: ${response.body}');
      } else {
        handleDeleteGroupError(response.statusCode, response.body);
      }
    } catch (error) {
      log('Error deleting group: $error');
      FirebaseUtils.showError("An error occurred while deleting the group");
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

  void handleDeleteGroupError(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    switch (statusCode) {
      case 404:
        FirebaseUtils.showError("Group not found");
        break;
      case 403:
        FirebaseUtils.showError("Unauthorized");
        break;
      case 500:
        FirebaseUtils.showError("Internal Server Error: ${data['message']}");
        break;
      default:
        FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }

// Future<void> rejectGroupRequest(int eventId, int requestId) async {
  //   String? token = await ControllerLogin.getToken();
  //   if (token == null) {
  //     Get.snackbar('Error', 'Authentication token is missing');
  //     return;
  //   }
  //
  //   isRejecting(true);
  //   String url = '${APiEndPoint.baseUrl}/events/$eventId/requests/$requestId/reject';
  //   log('Reject Request URL: $url');
  //
  //   try {
  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     log('Reject Request Response: ${response.body}');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Get.snackbar('Success', 'Request has been rejected successfully.');
  //       fetchEventRequests(eventId); // Refresh the event requests list
  //     } else {
  //       Get.snackbar('Error', 'Failed to reject the request. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     log('Error rejecting request: $e');
  //     Get.snackbar('Error', 'An error occurred while rejecting the request.');
  //   } finally {
  //     isRejecting(false);
  //   }
  // }

  Future<void> promoteMemberToAdmin(int groupId, int memberId) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true);
    String url = '${APiEndPoint.baseUrl}/groups/$groupId/members/$memberId/promote';
    log('Promote Member URL: $url');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      log('Promote Member Response: ${response.body}');

      switch (response.statusCode) {
        case 200:
          FirebaseUtils.showSuccess('Member promoted to admin successfully');
          break;

        case 404:
          final data = json.decode(response.body);
          FirebaseUtils.showError(data['message'] ?? 'Group or Member not found');
          log('Error 404: ${data['message']}');
          break;

        case 403:
          final data = json.decode(response.body);
          FirebaseUtils.showError(data['message'] ?? 'Unauthorized');
          log('Error 403: ${data['message']}');
          break;

        case 500:
          final data = json.decode(response.body);
          FirebaseUtils.showError(data['message'] ?? 'Internal server error');
          log('Error 500: ${data['message']}');
          break;

        default:
          FirebaseUtils.showError('Unexpected status code: ${response.statusCode}');
          log('Unexpected status code: ${response.statusCode}');
          break;
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred while promoting the member.');
      log('Exception: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> removeMember(int groupId, int memberId) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true);
    String url = '${APiEndPoint.baseUrl}/groups/$groupId/members/$memberId';
    log('Remove Member URL: $url');

    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      log('Remove Member Response: ${response.body}');

      switch (response.statusCode) {
        case 200:
          FirebaseUtils.showSuccess('Member removed successfully');
          break;

        case 404:
          final data = json.decode(response.body);
          FirebaseUtils.showError(data['message'] ?? 'Group or Member not found');
          log('Error 404: ${data['message']}');
          break;

        case 403:
          final data = json.decode(response.body);
          FirebaseUtils.showError(data['message'] ?? 'Unauthorized');
          log('Error 403: ${data['message']}');
          break;

        case 500:
          final data = json.decode(response.body);
          FirebaseUtils.showError(data['message'] ?? 'Internal server error');
          log('Error 500: ${data['message']}');
          break;

        default:
          FirebaseUtils.showError('Unexpected status code: ${response.statusCode}');
          log('Unexpected status code: ${response.statusCode}');
          break;
      }
    } catch (e) {
      FirebaseUtils.showError('An error occurred while removing the member.');
      log('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

}
