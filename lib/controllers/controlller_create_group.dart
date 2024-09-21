import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/controller_get_groups.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import '../constants/chat_constant.dart';
import '../constants/firebase_utils.dart';
import '../models/chat_group.dart';
import '../views/home_page/home_page.dart';

class ControllerCreateGroup extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxBool isPrivate = false.obs;
  RxBool capacityLimited = false.obs;
  RxInt attendeeLimit = 0.obs;
  RxBool timeSensitive = false.obs;
  var isLoading = false.obs;
  Rx<XFile> imgFile = XFile('').obs;
  void increment() {
    attendeeLimit.value++;
  }

  void decrement() {
    if (attendeeLimit.value > 0) {
      attendeeLimit.value--;
    }
  }
  Future<void> createGroup() async {
    try {
      isLoading.value = true;
      String? token = await ControllerLogin.getToken();
      String apiUrl = '${APiEndPoint.createGroup}';

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['title'] = titleController.text
        ..fields['description'] = descriptionController.text
        ..fields['is_private'] = isPrivate.value ? '1' : '0'
        ..fields['time_sensitive'] = timeSensitive.value ? '1' : '0'
        ..fields['capacity_limited'] = capacityLimited.value ? '1' : '0';

      if (capacityLimited.value) {
        request.fields['attendee_limit'] = attendeeLimit.value.toString();
      }

      if (imgFile.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', imgFile.value.path));
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      log(responseData.body.toString());
      log(response.statusCode.toString());

      if (response.statusCode == 201||response.statusCode == 200) {
        FirebaseUtils.showSuccess('Group created successfully.');
        log('Group created successfully: ${responseData.body}');
        final jsonResponse = jsonDecode(responseData.body);
        var groupId = jsonResponse['group']["id"].toString();

        // Create chat group in Firebase (or other backend)
        List<String> memberIds = [FirebaseUtils.myId];
        ChatGroup chatGroup = ChatGroup(
          id: groupId,
          eventId: groupId,
          memberIds: memberIds,
          messageCounters: {for (var memberId in memberIds) memberId: 0},
        );

        await chatGroupRef.child(groupId).set(chatGroup.toMap()).then((value) {
          print("Successfully added message Group");
          FirebaseUtils.showSuccess("Group created successfully");
          Navigator.pop(Get.context!);
          Get.find<GroupController>().fetchGroups();
        }).catchError((error) {
          print('Error adding message Group: $error');
        });
      } else {
        handleGroupError(response.statusCode, responseData.body);
      }
    } catch (error) {
      print('Error creating group: $error');
      FirebaseUtils.showError("An error occurred while creating the group");
    } finally {
      isLoading.value = false;
    }
  }

  void handleGroupError(int statusCode, String responseBody) {
    final data = jsonDecode(responseBody);

    switch (statusCode) {
      case 404:
        FirebaseUtils.showError("Group not found");
        break;
      case 403:
        FirebaseUtils.showError("Unauthorized");
        break;
      case 422:
        FirebaseUtils.showError("Validation error: ${data['message']}");
        break;
      case 500:
        FirebaseUtils.showError("Internal Server Error: ${data['message']}");
        break;
      default:
        FirebaseUtils.showError("Unexpected error: ${data['message']}");
    }
  }
  Future<void> updateGroup(int groupId) async {
    try {
      isLoading.value = true;
      String? token = await ControllerLogin.getToken();
      var request = http.MultipartRequest('POST', Uri.parse('${APiEndPoint.updateGroup}/$groupId'))
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['title'] = titleController.text
        ..fields['description'] = descriptionController.text
        ..fields['is_private'] = isPrivate.value ? '1' : '0'
        ..fields['time_sensitive'] = timeSensitive.value ? '1' : '0'
        ..fields['capacity_limited'] = capacityLimited.value ? '1' : '0';

      if (capacityLimited.value) {
        request.fields['attendee_limit'] = attendeeLimit.value.toString();
      }

      if (imgFile.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', imgFile.value.path));
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        FirebaseUtils.showSuccess("Group updated successfully.");
      } else {
        handleGroupError(response.statusCode, responseData.body);
      }
    } catch (error) {
      print('Error updating group: $error');
      FirebaseUtils.showError("An error occurred while updating the group");
    } finally {
      isLoading.value = false;
    }
  }

}
