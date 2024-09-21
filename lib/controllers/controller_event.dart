import 'dart:developer';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/event.dart'; // Ensure you have an Event model
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:blaxity/constants/ApiEndPoint.dart';
import '../constants/firebase_utils.dart';
import '../models/event_request.dart';
import 'authentication_controllers/controller_sign_in_.dart';

class EventController extends GetxController {
  var events = <Event>[].obs;
  var myEvents = <Event>[].obs;
  var isLoading = false.obs;
  var eventRequests = <EventRequest>[].obs;
  var isAccepting = false.obs; // Loading state for accepting a request
  var isRejecting = false.obs; // Loading state for rejecting a request

  // Future<void> fetchEvents() async {
  //   String? token = await ControllerLogin.getToken();
  //   if (token == null) {
  //     Get.snackbar('Error', 'Authentication token is missing');
  //     return;
  //   }
  //
  //   isLoading(true);
  //   try {
  //     var response = await http.get(
  //       Uri.parse(APiEndPoint.allEvents),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //     // log("other events${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);
  //
  //       // Assuming the API returns a JSON object with a 'data' key that contains a list of events
  //       if (jsonData['data'] != null && jsonData['data'] is List) {
  //         // Correctly map the JSON data to a list of Event objects
  //         List<Event> eventsList = (jsonData['data'] as List)
  //             .map((eventJson) => Event.fromJson(eventJson))
  //             .toList();
  //
  //         // Update the observable list
  //         events.value = eventsList;
  //       }
  //       else {
  //         Get.snackbar('Error', 'Unexpected data format received');
  //       }
  //     }
  //     else {
  //       Get.snackbar('Error', 'Failed to fetch events. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     log('Error fetching events: $e');
  //     Get.snackbar('Error', 'An error occurred while fetching events');
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  Future<void> fetchEvents({
    String? search,
    String? day,
    String? time,
    String? typeOfParty,
    String? privacy,
    String? pricing,
    bool? capacityLimited,
    String? location,
    String? eventType,
    String? languages,
    int? club,
    int? organization,
    int? upcoming,
    int? completed,
    String? sortBy,
  })
  async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      Get.snackbar('Error', 'Authentication token is missing');
      return;
    }

    isLoading(true);
    String url = APiEndPoint.allEvents;

    // Create the body of the request with optional parameters
    Map<String, dynamic> body = {};

    if (search != null) body['search'] = search;
    if (day != null) body['day'] = day;
    if (time != null) body['time'] = time;
    if (typeOfParty != null) body['type_of_party'] = typeOfParty;
    if (privacy != null) body['privacy'] = privacy;
    if (pricing != null) body['pricing'] = pricing;
    if (capacityLimited != null) body['capacity_limited'] = capacityLimited;
    if (location != null) body['location'] = location;
    if (eventType != null) body['event_type'] = eventType;
    if (languages != null) body['languages'] = languages;
    if (club != null) body['club'] = club;
    if (organization != null) body['organization'] = organization;
    if (upcoming != null) body['upcoming'] = upcoming;
    if (completed != null) body['completed'] = completed;
    if (sortBy != null) body['sort_by'] = sortBy;

    log('Request body: ${json.encode(body)}');

    try {
      // Create a new http.Request object
      var request = http.Request('GET', Uri.parse(url))
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        })
        ..body = json.encode(body); // Attach the body to the request

      // Send the request using http.Client
      var client = http.Client();
      var streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);

      log("Events response: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Check if the data exists and is a list
        if (jsonData['data'] != null && jsonData['data'] is List) {
          // Map the JSON data to a list of Event objects
          List<Event> eventsList = (jsonData['data'] as List)
              .map((eventJson) => Event.fromJson(eventJson))
              .toList();

          // Update the observable list
          events.value = eventsList;
          // FirebaseUtils.showSuccess("Events fetched successfully");
        } else {
          FirebaseUtils.showError("Unexpected data format received");
        }
      } else {
        handleFetchEventsErrorResponse(response.statusCode, response.body);
      }
    } catch (e) {
      log('Error fetching events: $e');
      FirebaseUtils.showError("An error occurred while fetching events");
    } finally {
      isLoading(false);
    }
  }

  void handleFetchEventsErrorResponse(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    if (statusCode == 500) {
      // Handle internal server errors
      FirebaseUtils.showError("Internal Server Error: ${data['message']}");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }
  Rx<Event> eventDetails = Event().obs;

  Future<void> fetchMyEvents({
    String? search,
    int? club,
    int? organization,
    int? upcoming,
    int? completed,
  }) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError("Authentication token is missing");
      return;
    }

    isLoading(true);
    String url = APiEndPoint.ownerEvent;

    // Create query parameters
    final queryParameters = <String, String>{};
    if (search != null) queryParameters['search'] = search;
    if (club != null) queryParameters['club'] = club.toString();
    if (organization != null) queryParameters['organization'] = organization.toString();
    if (upcoming != null) queryParameters['upcoming'] = upcoming.toString();
    if (completed != null) queryParameters['completed'] = completed.toString();

    // Build the complete URL with query parameters
    final uri = Uri.parse(url).replace(queryParameters: queryParameters);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log("My Events Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Assuming the API returns a JSON object with a 'data' key that contains a list of events
        if (jsonData['data'] != null && jsonData['data'] is List) {
          // Map the JSON data to a list of Event objects
          List<Event> eventsList = (jsonData['data'] as List)
              .map((eventJson) => Event.fromJson(eventJson))
              .toList();
          myEvents.value = eventsList; // Update the observable list
        } else {
          FirebaseUtils.showError("Unexpected data format received");
        }
      } else {
        handleFetchMyEventsErrorResponse(response.statusCode, response.body);
      }
    } catch (e) {
      log('Error fetching events: $e');
      FirebaseUtils.showError("An error occurred while fetching events");
    } finally {
      isLoading(false);
    }
  }


  void handleFetchMyEventsErrorResponse(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    if (statusCode == 500) {
      // Handle internal server errors
      FirebaseUtils.showError("Internal Server Error: ${data['message']}");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }


  @override
  void onInit() {
    fetchEvents();
    fetchMyEvents();
    super.onInit();
  }

  RxBool attending = false.obs;

  Future<void> attendEvent(int eventId) async {
    isLoading.value = true;
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError("Authentication token is missing");
      return;
    }
    var body = {'action': 'attend'};
    String url = '${APiEndPoint.baseUrl}/events/interact/$eventId';
    log(url);

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // fetchEvents();
        await fetchEvents();


        FirebaseUtils.showSuccess(
            "You have successfully requested to attend the event.");
      } else {
        var data=jsonDecode(response.body);
        log('Failed to attend event: ${response.body}');
        FirebaseUtils.showError(
            '${data['message']}');
      }
    } catch (e) {
      log('Error attending event: $e');
      FirebaseUtils.showError( '$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEventRequests(int eventId) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true);
    String url = '${APiEndPoint.baseUrl}/events/requests/$eventId';
    log(url);

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log("Event Requests: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Assuming the API returns a JSON object with a 'requests' key that contains a list of event requests
        if (jsonData['requests'] != null && jsonData['requests'] is List) {
          // Map the JSON data to a list of EventRequest objects
          List<EventRequest> requestsList = (jsonData['requests'] as List)
              .map((requestJson) => EventRequest.fromJson(requestJson))
              .toList();

          // Update the observable list
          eventRequests.value = requestsList;
        } else {
          FirebaseUtils.showError('Unexpected data format received');
        }
      } else {
        FirebaseUtils.showError(
            'Failed to fetch event requests. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching event requests: $e');
      FirebaseUtils.showError('An error occurred while fetching event requests.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> acceptEventRequest(int eventId, int requestId) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      Get.snackbar('Error', 'Authentication token is missing');
      return;
    }

    isAccepting(true);
    String url =
        '${APiEndPoint.baseUrl}/events/$eventId/requests/$requestId/accept';
    log('Accept Request URL: $url');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('Accept Request Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Request has been accepted successfully.');
        fetchEventRequests(eventId); // Refresh the event requests list
      } else {
        FirebaseUtils.showError(
            'Failed to accept the request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error accepting request: $e');
      FirebaseUtils.showError( 'An error occurred while accepting the request.');
    } finally {
      isAccepting(false);
    }
  }

  Future<void> rejectEventRequest(int eventId, int requestId) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isRejecting(true);
    String url =
        '${APiEndPoint.baseUrl}/events/$eventId/requests/$requestId/reject';
    log('Reject Request URL: $url');

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('Reject Request Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        FirebaseUtils.showSuccess('Request has been rejected successfully.');
        fetchEventRequests(eventId); // Refresh the event requests list
      } else {
        FirebaseUtils.showError(
            'Failed to reject the request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error rejecting request: $e');
      FirebaseUtils.showError( 'An error occurred while rejecting the request.');
    } finally {
      isRejecting(false);
    }
  }
  Future<void> fetchEventDetails(int id) async {
    String? token = await ControllerLogin.getToken();
    if (token == null) {
      Get.snackbar('Error', 'Authentication token is missing');
      return;
    }

    isLoading(true);
    String url = '${APiEndPoint.getEvent}$id';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );


      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        Event event = Event.fromJson(jsonData['data']['event']);
        eventDetails.value = event;
      } else {
        handleFetchEventDetailsErrorResponse(response.statusCode, response.body);
      }
    } catch (e) {
      log('Error fetching event details: $e');
      FirebaseUtils.showError("An error occurred while fetching event details");
    } finally {
      isLoading(false);
    }
  }

  void handleFetchEventDetailsErrorResponse(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    if (statusCode == 404) {
      // Handle event not found error
      FirebaseUtils.showError(data['message']);
    } else if (statusCode == 500) {
      // Handle internal server errors
      FirebaseUtils.showError("Internal Server Error: ${data['message']}");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }

}
