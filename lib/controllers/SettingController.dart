import 'dart:convert';
import 'dart:developer';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool isShowEvent = false.obs;
  RxBool isShowClub = false.obs;
  RxBool isLoading = false.obs;

  // Method to get settings
  Future<void> fetchSettings() async {
    isLoading(true); // Show loading

    try {
      // API endpoint
      String url = 'https://blaxity.codergize.com/api/setting';

      // Send GET request
      var response = await http.get(Uri.parse(url));

      // Handle the response
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        isShowClub.value = jsonResponse['show_club'] == 0 ? true : false;
        log(isShowClub.value.toString());
        isShowEvent.value = jsonResponse['show_event'] == 0 ? true : false;
        // Do something with the response
        // Get.snackbar('Success', 'Settings fetched successfully.');
        print(jsonResponse); // Print or process the settings data
      } else {
        var jsonResponse = jsonDecode(response.body);
        // Get.snackbar('Error', jsonResponse['message'] ?? 'Failed to fetch settings.');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false); // Hide loading
    }
  }
  @override
  void onInit() {
    fetchSettings();
    // TODO: implement onInit
    super.onInit();
  }
}
