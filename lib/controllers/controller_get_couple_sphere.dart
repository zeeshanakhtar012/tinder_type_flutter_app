import 'package:blaxity/models/user.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../models/sphere.dart';
import 'authentication_controllers/controller_sign_in_.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class ControllerGetCouplesSphere extends GetxController {
  // Reactive state management variables
  var isLoading = false.obs;

  RxString likeCount = "0".obs;
  RxString viewCount = "0".obs;
  RxString networkCount = "0".obs;
  RxList<User> singles = <User>[].obs;
  RxList<User> combinedList = <User>[].obs;
  RxList<User> couples = <User>[].obs;

  Future<void> getCoupleSphere({String? filter}) async {
    isLoading.value = true; // Set loading to true
    try {
      // Include filter as a query parameter in the URL
      String apiUrl = 'https://blaxity.codergize.com/api/user/sphere?filter=$filter';
      String? token = await ControllerLogin.getToken();

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log("body:$filter");
      log(response.body);
      if (response.statusCode == 200) {
        // Parse and store the response data
        var data = json.decode(response.body);

        likeCount.value = data['likes_count'].toString();
        viewCount.value = data['views_count'].toString();
        networkCount.value = data['networks_count'].toString();
           combinedList.value=data["sphere_user"].map<User>((user) => User.fromJson(user as Map<String, dynamic>)).toList();
        // Ensure `sphere_user` exists and is a map
        // singles.value=[];
        // couples.value=[];
        // singles.value = data['sphere_user']['singles'].map<User>((user) => User.fromJson(user as Map<String, dynamic>)).toList();
        // couples.value = data['sphere_user']['couples'].map<User>((user) => User.fromJson(user as Map<String, dynamic>)).toList();
        // if (singles.isNotEmpty||couples.isNotEmpty) {
        //   combinedList.value = singles + couples;
        // }  else{
        //   combinedList.value = [];
        // }


        log(likeCount.value);
        log(viewCount.value);
        log(networkCount.value);
      } else {
        combinedList.value = [];
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }
}
