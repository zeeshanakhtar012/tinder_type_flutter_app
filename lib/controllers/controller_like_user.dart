import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/match_response.dart';
import '../views/screens/screen_match_person_profile.dart';
import 'authentication_controllers/controller_sign_in_.dart';

class LikeController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isLiked = false.obs; // This will store whether the like action was successful or not.

  Future<void> likeEntity({int? likedCoupleId, int? likedUserId}) async {
    // Ensure only one ID is provided
    assert((likedCoupleId == null && likedUserId != null) || (likedCoupleId != null && likedUserId == null),
    "Only one of likedCoupleId or likedUserId must be provided.");

    String? token = await ControllerLogin.getToken();
    isLoading.value = true;
    errorMessage.value = ''; // Reset error message

    // Create the request payload
    LikeRequest likeRequest = LikeRequest(
      likedCoupleId: likedCoupleId,
      likedUserId: likedUserId,
    );

    try {
      final response = await http.post(
        Uri.parse('${APiEndPoint.baseUrl}/user/like'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(likeRequest.toJson()),
      );
      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200||response.statusCode == 201) {
        var responseData= jsonDecode(response.body);
        isLiked.value = true;
        log('Liked entity response: $responseData');

        if (responseData["is_show"]!=null) {
          MatchResponse matchResponse = MatchResponse.fromJson(responseData);
          Get.to(ScreenMatchPersonProfile(matchResponse:matchResponse ,));
        }  
        errorMessage.value = ''; // Clear any previous error
      } else {
        errorMessage.value = 'Failed to like entity: ${response.body}';
        isLiked.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Error occurred: $e';
      isLiked.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
class LikeRequest {
  final int? likedCoupleId;
  final int? likedUserId;

  LikeRequest({this.likedCoupleId, this.likedUserId});

  Map<String, dynamic> toJson() {
    return {
      'liked_couple_id': likedCoupleId,
      'liked_user_id': likedUserId,
    };
  }
}
