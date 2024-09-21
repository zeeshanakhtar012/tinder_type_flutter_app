import 'dart:developer';

import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/firebase_utils.dart';
import '../models/blog.dart';

class BlogsController extends GetxController {
  var blogsList = <Blog>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBlogs();
    super.onInit();
  }

  void fetchBlogs({String? search}) async {
    try {
      isLoading(true);
      String? token = await ControllerLogin.getToken();

      if (token == null) {
        FirebaseUtils.showError("Authentication token is missing");
        return;
      }

      // Build the URL with optional search query
      String url = 'https://blaxity.codergize.com/api/blogs';
      if (search != null && search.isNotEmpty) {
        url += '?search=${Uri.encodeComponent(search)}';
      }

      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      log(response.body);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var blogs = jsonData['blogs'] as List;
        blogsList.value = blogs.map((blog) => Blog.fromJson(blog)).toList();
      } else {
        FirebaseUtils.showError("Failed to load blogs: ${response.body}");
      }
    } catch (e) {
      // FirebaseUtils.showError("Error fetching blogs: $e");} finally {
      isLoading(false);
    }
    finally{
      isLoading(false);
    }
  }
}
