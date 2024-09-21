// controllers/posts_controller.dart

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Post.dart';

class PostsController extends GetxController {
  var postsList = <Post>[].obs;
  var isLoading = false.obs;

  void getAllPosts() async {
    String? token=await ControllerLogin.getToken();
    isLoading.value = true;
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('GET', Uri.parse(APiEndPoint.retrieveAllPost));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var decodedData = jsonDecode(responseData);

      if (decodedData['status'] == 'success') {
        var posts = List<Post>.from(decodedData['data'].map((post) => Post.fromJson(post)));
        postsList.assignAll(posts);
      } else {
        print(decodedData['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
    isLoading.value = false;
  }
}
