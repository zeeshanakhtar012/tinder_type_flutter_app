import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_country_page2.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_height_page6.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_photos_page5.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_describe_page8.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_email_otp_page10.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_permission_page11.dart';
import 'package:blaxity/views/screens/screen_add_user_link.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_wait_list_club.dart';
import 'package:blaxity/views/screens/screen_exploring_together.dart';
import 'package:blaxity/views/screens/screen_individual/screen_upload_profile_individual.dart';
import 'package:blaxity/views/screens/screen_splash.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_selfie_verification_05.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_wait_list_sinlge_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/screens/personal_information_screens_couple/screen_about_details_page7.dart';
import '../../views/screens/personal_information_screens_couple/screen_choose_passion_page9.dart';
import '../../views/screens/screen_individual/screen_create_event.dart';
import '../../views/screens/screen_welcome.dart';
import '../../views/screens/single_user_screens/screen_identity_verification.dart';
import '../../views/screens/single_user_screens/screen_stay_connected_single_user_09.dart';
import 'controller_sign_in_.dart';

class ControllerRegistration extends GetxController {
  /// User Registration
  RxString userType = "".obs;
  var isLoading = false.obs;
  Rx<DateTime> dateTime = Rx(DateTime.now());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController cityController = TextEditingController();

  // var city = ''.obs;
  var country = ''.obs;
  RxString selectGender = "Male".obs;

  /// Couple Registration

  var partnerOneGender = 'Male'.obs;
  var partnerTwoGender = 'Female'.obs;
  TextEditingController firstPartnerAge = TextEditingController();
  TextEditingController firstPartnerName = TextEditingController();
  TextEditingController secondPartnerName = TextEditingController();
  TextEditingController secondPartnerAge = TextEditingController();
  var birthDate = (DateTime.now()).obs;
  RxInt age = 0.obs;

// Your user registration function with proper error handling
  Future<void> userRegistration() async {
    // Extract input values
    String partnerOneName = firstPartnerName.text;
    String partnerTwoName = secondPartnerName.text;
    String partnerOneGender = this.partnerOneGender.value;
    String partnerTwoGender = this.partnerTwoGender.value;
    String city = cityController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String passwordConfirmation = passwordConfirmationController.text;
    String partnerOneAge = firstPartnerAge.text;
    String partnerTwoAge = secondPartnerAge.text;

    // Prepare request body
    var body = jsonEncode({
      "Partner_1_name": partnerOneName,
      "Partner_2_name": partnerTwoName,
      "Partner_1_sex": partnerOneGender,
      "Partner_2_sex": partnerTwoGender,
      "partner_2_age": partnerTwoAge,
      "partner_1_age": partnerOneAge,
      "birth_date": birthDate.value.toIso8601String(),
      "city": city,
      "age": age.value,
      "country": country.value,
      "email": email,
      "password_confirmation": passwordConfirmation,
      "password": password,
      "user_type": userType.value,
      'latitude': latitude.value,
      'longitude': longitude.value,
      'location': address.value,
    });

    // Log the request body for debugging
    log(body);

    // Set request headers
    final headers = {
      'Content-Type': 'application/json',
    };

    // Define the API endpoint URL
    final Uri url = Uri.parse('${APiEndPoint.register}');

    try {
      // Set loading state to true
      isLoading.value = true;

      // Make the HTTP POST request
      final response = await http.post(url, headers: headers, body: body);

      // Log the raw response body for debugging
      log(response.body);

      // Parse the response body
      final responseBody = jsonDecode(response.body);

      // Handle the response based on the status code
      if (response.statusCode == 200) {
        // Registration successful
        isLoading.value = false;
        FirebaseUtils.showSuccess(responseBody['message']);
        log("User registration successful: ${responseBody.toString()}");

        // Navigate to the OTP screen
        Get.to(ScreenEmailOTP(
          email: email,
          step: '5 of 11',
        ));
      } else if (response.statusCode == 422) {
        // Handle validation errors
        isLoading.value = false;
        final errors = responseBody as Map<String, dynamic>;
        errors.forEach((field, messages) {
          for (String message in messages) {
            FirebaseUtils.showError(message);
          }
        });
        log("Validation error: ${responseBody.toString()}");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        isLoading.value = false;
        FirebaseUtils.showError(
            responseBody['message'] ?? "Internal Server Error");
        log("Internal server error: ${responseBody.toString()}");
      } else {
        // Handle other errors
        isLoading.value = false;
        FirebaseUtils.showError(
            responseBody['message'] ?? "Unexpected error occurred.");
        log("Unexpected error: ${responseBody.toString()}");
      }
    } catch (e) {
      // Handle network errors or exceptions
      isLoading.value = false;
      FirebaseUtils.showError(e.toString());
      log("Error during user registration: $e");
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

// Your partnerTwoRegistration function with proper error handling
  Future<void> partnerTwoRegistration(String link, String id) async {
    // Extract input values
    String partnerOneName = firstPartnerName.text;
    String partnerTwoName = secondPartnerName.text;
    String partnerOneGender = this.partnerOneGender.value;
    String partnerTwoGender = this.partnerTwoGender.value;
    String city = cityController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String passwordConfirmation = passwordConfirmationController.text;
    String partnerOneAge = firstPartnerAge.text;
    String partnerTwoAge = secondPartnerAge.text;

    // Prepare request body
    var body = jsonEncode({
      "Partner_1_name": partnerOneName,
      "Partner_2_name": partnerTwoName,
      "Partner_1_sex": partnerOneGender,
      "Partner_2_sex": partnerTwoGender,
      "partner_2_age": partnerTwoAge,
      "partner_1_age": partnerOneAge,
      "birth_date": birthDate.value.toIso8601String(),
      "age": age.value,
      "email": email,
      "password_confirmation": passwordConfirmation,
      "password": password,
      "user_type": userType.value,
      "referral_shared_link": link,
      'latitude': latitude.value,
      'longitude': longitude.value,
      'location': address.value,
      "share_link": link
    });

    // Log the request body for debugging
    log(body);

    // Set request headers
    final headers = {
      'Content-Type': 'application/json',
    };

    // Define the API endpoint URL
    final Uri url = Uri.parse('${APiEndPoint.register}');

    try {
      // Set loading state to true
      isLoading.value = true;

      // Make the HTTP POST request
      final response = await http.post(url, headers: headers, body: body);

      // Log the raw response body for debugging
      log(response.body);

      // Parse the response body
      final responseBody = jsonDecode(response.body);
      log(responseBody.toString());

      // Handle the response based on the status code
      if (response.statusCode == 200) {
        // Registration successful
        isLoading.value = false;
        FirebaseUtils.showSuccess(responseBody['message']);
        log("Partner registration successful: ${responseBody.toString()}");

        // Navigate to the OTP screen
        Get.to(ScreenEmailOTP(
          email: email,
          link: link,
          id: id,
          step: '5 of 11',
        ));
      } else if (response.statusCode == 422) {
        // Handle validation errors
        isLoading.value = false;
        final errors = responseBody as Map<String, dynamic>;
        errors.forEach((field, messages) {
          for (String message in messages) {
            FirebaseUtils.showError(message);
          }
        });
        log("Validation error: ${responseBody.toString()}");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        isLoading.value = false;
        FirebaseUtils.showError(
            responseBody['message'] ?? "Internal Server Error");
        log("Internal server error: ${responseBody.toString()}");
      } else {
        // Handle other errors
        isLoading.value = false;
        FirebaseUtils.showError(
            responseBody['message'] ?? "Unexpected error occurred.");
        log("Unexpected error: ${responseBody.toString()}");
      }
    } catch (e) {
      // Handle network errors or exceptions
      isLoading.value = false;
      FirebaseUtils.showError(e.toString());
      log("Error during partner registration: $e");
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

  ///Verification OTP
  TextEditingController otpController = TextEditingController();

// Your verifyOtp function with proper error handling
  Future<void> verifyOtp({
    required String email,
    required String id,
    required String link,
  }) async {
    // Extract OTP from the controller
    String otp = otpController.text;

    // Log OTP and email for debugging
    log('OTP: $otp');
    log('Email: $email');

    // Set loading state to true
    isLoading.value = true;

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(APiEndPoint.verifyOtp),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
      );

      // Log the raw response body for debugging
      log('Response: ${response.body}');
      var responseData = jsonDecode(response.body);

      // Handle the response based on status code
      if (response.statusCode == 200) {
        // OTP verification successful

        // Save data to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString("access_token", responseData['access_token']);
        await prefs.setInt("id", responseData['user']['id']);
        await prefs.setString("userType", responseData['user']['user_type']);
        log("Email verified successfully");

        // Parse user data
        User user = User.fromJson(responseData['user']);

        // Navigate based on user type
        switch (responseData['user']['user_type']) {
          case "couple":
            Get.offAll(ScreenChooseHeight(
              step: '6 of 11',
              user: user,
              id: id,
              link: link,
            ));
            break;
          case "single":
            Get.offAll(ScreenChooseCountry(
              step: '4 of 11',
              user: user,
            ));
            break;
          case "individual_event_organizer":
            Get.offAll(ScreenCreateEventIndividual(user: user));
            break;
          case "club_event_organizer":
            Get.offAll(ScreenCreateEventIndividual(user: user));
            break;
          default:
            log("Unknown user type: ${responseData['user']['user_type']}");
            break;
        }
      } else if (response.statusCode == 422) {
        // Handle validation errors (e.g., missing email or otp)
        Map<String, dynamic> errors = responseData;
        if (errors.containsKey('email')) {
          FirebaseUtils.showError("Email error: ${errors['email'].join(', ')}");
        }
        if (errors.containsKey('otp')) {
          FirebaseUtils.showError("OTP error: ${errors['otp'].join(', ')}");
        }
      } else if (response.statusCode == 400) {
        // Handle invalid OTP or email
        log("Failed to verify OTP: ${responseData['message']}");
        FirebaseUtils.showError("Invalid OTP or email.");
      } else if (response.statusCode == 500) {
        // Handle server errors
        log("Server error: ${responseData['message']}");
        FirebaseUtils.showError(
            "An internal server error occurred. Please try again later.");
      } else {
        // Handle other unexpected status codes
        log("Unexpected error: ${response.reasonPhrase}");
        FirebaseUtils.showError(
            "An unexpected error occurred. Please try again.");
      }
    } catch (e) {
      // Handle exceptions
      log("Error during OTP verification: $e");
      FirebaseUtils.showError("An error occurred: $e");
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

  /// Update Height
  var height = ''.obs;

  Future<void> updateHeight(User user, String id, String link) async {
    // Log user details for debugging
    log('Partner 1 Name: ${user.partner1Name}');
    log('Partner 2 Name: ${user.partner2Name}');
    log('Partner 1 Sex: ${user.partner1Sex}');
    log('Partner 2 Sex: ${user.partner2Sex}');
    log('Birth Date: ${user.birthDate}');
    log('User Type: ${user.userType}');

    // Retrieve height and token
    String height = this.height.value;
    String? token = await ControllerLogin.getToken();

    // Check if token is null and handle the error
    if (token == null) {
      FirebaseUtils.showError(
          'Authorization token is missing. Please log in again.');
      return;
    }

    // Set loading state to true
    isLoading.value = true;

    try {
      // Make HTTP POST request to update profile
      Map<String, dynamic> body = {
        'height': height, // Assuming 'height' is defined elsewhere
        'Partner_1_name': user.partner1Name,
        'Partner_2_name': user.partner2Name,
        'Partner_1_sex': user.partner1Sex,
        'Partner_2_sex': user.partner2Sex,
        'birth_date': user.birthDate,
        'city': user.commonCoupleData?.city ?? '',
        'country': user.commonCoupleData?.country ?? '',
        'user_type': user.userType,
        'age': user.age ?? 0,
        'latitude': user.reference?.latitude ?? '',
        'longitude': user.reference?.longitude ?? '',
        'location': user.reference?.location ?? '',
        "partner_2_age": user.partner_2_age ?? "",
        "partner_1_age": user.partner_1_age ?? "",
      };

      // Add the referral_shared_link only if it's not null
      if (user.reference?.shareLink != null) {
        body['referral_shared_link'] = user.reference!.shareLink;
        body['share_link'] = user.reference!.shareLink;
      }

      final response = await http.post(
        Uri.parse(APiEndPoint.updateProfile), // Replace with your endpoint
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      // Log the raw response body for debugging
      log('Response: ${response.body}');
      var responseData = jsonDecode(response.body);

      // Handle the response
      if (response.statusCode == 200) {
        User updatedUser = User.fromJson(responseData["user"]);
        log('Response Data: $responseData');

        // Hide loading state and navigate to the next screen
        isLoading.value = false;
        print("Height updated successfully.");
        Get.offAll(ScreenAboutDetails(
          step: '7 of 11',
          user: updatedUser,
          id: id,
          link: link,
        ));
      } else {
        // Log and show error if status code is not 200
        log('Failed to update height: ${response.body}');
        FirebaseUtils.showError(
            'Failed to update height: ${responseData["message"]}');
        isLoading.value = false; // Hide loading state on error
      }
    } catch (e) {
      // Handle any exceptions during the HTTP request
      log('Error updating height: $e');
      FirebaseUtils.showError(
          'An error occurred while updating height. Please try again.');
      isLoading.value = false; // Hide loading state on exception
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

  ///Update About Details
  TextEditingController eyeColorController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController languagesController = TextEditingController();
  RxString howOftenDrink = ''.obs;
  List<String> drinkingHabits = <String>[
    'Not for me',
    'Most nights',
    'Sober curious',
    // 'Socially,at the weeknd',
    'On special occasions'
  ];
  RxString howOftenSmoke = ''.obs;
  RxString selectBodyType = ''.obs;
  RxString selectSafetyMeasures = ''.obs;
  List<String> smokingHabits = <String>[
    'Non-smoker',
    'Smoker',
    'Social smoker',
    'Special Smoker',
    'Trying to quit'
  ];

  List<String> eyeColors = [
    'Amber',
    'Blue',
    'Brown',
    'Gray',
    'Green',
    'Hazel',
  ];
  List<String> ethnicities = [
    'Caucasian',
    'Native American',
    'Middle Eastern',
    'Latino',
    'Asian'
  ];
  List<String> educationLevels = [
    'High School Diploma',
    'Bachelor’s Degree',
    'Master’s Degree',
    'Doctorate Degree',
  ];
  List<String> selectLanguages = [
    'Arabic',
    'Mandarin',
    'French',
    'Spanish',
    'English'
  ];
  List<String> bodyTypes = [
    'Skinny',
    'Curvy',
    'Muscular',
    'Athletic',
    'Average',
    'Heavyset'
  ];
  List<String> safetyMeasures = ['Always', 'Sometimes', 'Never'].obs;

// Assuming you have a function to get user token
  Future<void> updateAboutDetails(User user, String id, String link) async {
    log('User Type: ${user.userType}'); // Log user type for debugging

    // Retrieve token for authorization
    String? token = await ControllerLogin.getToken();

    if (token == null) {
      FirebaseUtils.showError(
          'Authorization token is missing. Please log in again.');
      return;
    }

    // Prepare request body based on user type
    var singleBody = user.userType == "couple"
        ? {
            'height': user.reference!.height!,
            "Partner_1_name": user.partner1Name,
            "Partner_2_name": user.partner2Name,
            "Partner_1_sex": user.partner1Sex,
            "Partner_2_sex": user.partner2Sex,
            "partner_2_age": user.partner_2_age ?? "",
            "partner_1_age": user.partner_1_age ?? "",
            "birth_date": user.birthDate,
            "city": user.commonCoupleData?.city ?? "",
            "country": user.commonCoupleData?.country ?? "",
            "user_type": user.userType,
            'eye_color': eyeColorController.text,
            'ethnicity': ethnicityController.text,
            'education': educationController.text,
            'languages': languagesList.toList(),
            'drinking_habit': howOftenDrink.value,
            'smoking_habit': howOftenSmoke.value,
            'safety_practice': selectSafetyMeasures.value,
            'body_type': selectBodyType.value,
            'latitude': user.reference?.latitude ?? "",
            'longitude': user.reference?.longitude ?? "",
            'location': user.reference?.location ?? "",
          }
        : {
            'country': user.country ?? "",
            'city': user.city ?? "",
            "birth_date": user.birthDate,
            "age": user.age,
            'f_name': user.fName ?? "",
            'sexuality': user.reference == null
                ? selectGender.value
                : user.reference!.sexuality ?? "",
            "user_type": user.userType!,
            // "id_document": user.verification!.idDocument.toString(),
            // "utility_bill": user.verification!.utilityBill.toString(),
            "selfie": user.verification!.selfie.toString(),
            'description': user.reference!.description!,
            'eye_color': eyeColorController.text,
            'ethnicity': ethnicityController.text,
            'education': educationController.text,
            'languages': languagesList.toList(),
            'drinking_habit': howOftenDrink.value,
            'smoking_habit': howOftenSmoke.value,
            'safety_practice': selectSafetyMeasures.value,
            'body_type': selectBodyType.value,
            'latitude': user.reference?.latitude ?? "",
            'longitude': user.reference?.longitude ?? "",
            'location': user.reference?.location ?? "",
          };

    // Set loading state to true before making HTTP request
    isLoading.value = true;

    try {
      if (user.userType == "couple") {
        if (user.reference?.shareLink != null) {
          singleBody['referral_shared_link'] = user.reference!.shareLink;
          singleBody['share_link'] = user.reference!.shareLink;
        }
      }
      log(singleBody.toString()); // Log request body for debugging
      // Make HTTP POST request to update profile
      final response = await http.post(
        Uri.parse("https://blaxity.codergize.com/api/user/update-profile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(singleBody),
      );

      log('Response: ${response.body}'); // Log response body for debugging
      var responseData = jsonDecode(response.body);

      // Handle successful response
      if (response.statusCode == 200) {
        log('Response Data: $responseData');
        print("About details updated successfully.");
        UserResponse userResponse = UserResponse.fromJson(responseData);
        User updatedUser = User.fromJson(responseData["user"]);

        // Hide loading state and navigate based on user type
        isLoading.value = false;
        if (updatedUser.userType == "couple") {
          if (user.commonCoupleData!.description == null &&
              user.reference!.shareLink == null) {
            Get.offAll(ScreenDescribe(
              step: '8 of 11',
              user: updatedUser,
            ));
          } else {
            Get.offAll(ScreenPermissions(
              user: userResponse,
              id: id,
              link: link,
            ));
          }
        } else {
          Get.offAll(ScreenPassion(
            step: '10 of 10',
            user: updatedUser,
          ));
        }
      } else {
        // Handle error response and show error message
        log('Failed to update about details: ${responseData["message"]}');
        FirebaseUtils.showError(
            'Failed to update about details: ${response.body}');
        isLoading.value = false; // Reset loading state on error
      }
    } catch (e) {
      // Handle exceptions and show error message
      log('Error updating about details: $e');
      FirebaseUtils.showError('Error updating about details: $e');
      isLoading.value = false; // Reset loading state on exception
    } finally {
      isLoading.value = false;
    }
  }

  ///Update Describe Yourself
  TextEditingController describeYourselfController = TextEditingController();

  Future<void> updateDescribeYourself(User user) async {
    String? token = await ControllerLogin.getToken();
    isLoading.value = true;

    var singleBody = user.userType == "couple"
        ? {
            'height': user.reference?.height ?? '',
            "Partner_1_name": user.partner1Name,
            "Partner_2_name": user.partner2Name,
            "Partner_1_sex": user.partner1Sex,
            "Partner_2_sex": user.partner2Sex,
            "birth_date": user.birthDate,
            "partner_2_age": user.partner_2_age ?? "",
            "partner_1_age": user.partner_1_age ?? "",
            "age": user.age ?? 0,
            "city": user.commonCoupleData?.city ?? '',
            "country": user.commonCoupleData?.country ?? '',
            "user_type": user.userType,
            'eye_color': user.reference?.eyeColor ?? '',
            'ethnicity': user.reference?.ethnicity ?? '',
            'education': user.reference?.education ?? '',
            'languages': user.reference?.language?.toList() ?? [],
            'drinking_habit': user.additionalInfo?.drinkingHabit ?? '',
            'smoking_habit': user.additionalInfo?.smokingHabit ?? '',
            'safety_practice': user.additionalInfo?.safetyPractice ?? '',
            'body_type': user.additionalInfo?.bodyType ?? '',
            'description': describeYourselfController.text,
            'latitude': user.reference?.latitude ?? '',
            'longitude': user.reference?.longitude ?? '',
            'location': user.reference?.location ?? '',
          }
        : {
            'country': user.country ?? '',
            'city': user.city ?? '',
            'f_name': user.fName ?? '',
            'sexuality': user.reference?.sexuality ?? selectGender.value,
            "user_type": user.userType ?? '',
            "birth_date": user.birthDate,
            "age": user.age,
            // "id_document": user.verification?.idDocument.toString() ?? '',
            // "utility_bill": user.verification?.utilityBill.toString() ?? '',
            "selfie": user.verification?.selfie.toString() ?? '',
            'description': describeYourselfController.text,
            'latitude': user.reference?.latitude ?? '',
            'longitude': user.reference?.longitude ?? '',
            'location': user.reference?.location ?? '',
          };

    try {
      final response = await http.post(
        Uri.parse("https://blaxity.codergize.com/api/user/update-profile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(singleBody),
      );

      log(response.body.toString());
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log(responseData.toString());
        print("Message: About details updated successfully");
        User user = User.fromJson(responseData["user"]);
        var userType = await ControllerLogin.getUserType();
        log(userType.toString());
        if (user.userType == "couple") {
          Get.offAll(ScreenPassion(
            step: '9 of 11',
            user: user,
          ));
        } else {
          Get.offAll(ScreenAboutDetails(
            step: '9 of 10',
            user: user,
          ));
        }
      } else {
        print("Failed to update about details: ${responseData["message"]}");
        FirebaseUtils.showError("Failed to update details. Please try again.");
      }
    } catch (error) {
      print("Error occurred: $error");
      FirebaseUtils.showError(
          "An error occurred while updating details.$error");
    } finally {
      isLoading.value = false;
    }
  }

  ///Update Passion
  List<String> selectedLookingFor = [];
  List<String> selectedDesires = [];
  List<String> selectedHobbies = [];
  List<String> selectedParties = [];

  Future<void> updatePassion(User user) async {
    log("Selected looking for: $selectedLookingFor");
    log("Selected desires: $selectedDesires");
    log("Selected hobbies: $selectedHobbies");
    log("Selected parties: $selectedParties");

    String? token = await ControllerLogin.getToken();
    var singleBody = user.userType == "couple"
        ? {
            'height': user.reference?.height ?? '',
            "Partner_1_name": user.partner1Name,
            "Partner_2_name": user.partner2Name,
            "Partner_1_sex": user.partner1Sex,
            "Partner_2_sex": user.partner2Sex,
            "birth_date": user.birthDate,
            "partner_2_age": user.partner_2_age ?? "",
            "partner_1_age": user.partner_1_age ?? "",
            "age": user.age ?? 0,
            "city": user.commonCoupleData?.city ?? '',
            "country": user.commonCoupleData?.country ?? '',
            "user_type": user.userType,
            'eye_color': user.reference?.eyeColor ?? '',
            'ethnicity': user.reference?.ethnicity ?? '',
            'education': user.reference?.education ?? '',
            'languages': user.reference?.language?.toList() ?? [],
            'drinking_habit': user.additionalInfo?.drinkingHabit ?? '',
            'smoking_habit': user.additionalInfo?.smokingHabit ?? '',
            'safety_practice': user.additionalInfo?.safetyPractice ?? '',
            'body_type': user.additionalInfo?.bodyType ?? '',
            'description': user.commonCoupleData?.description ?? 'Test',
            'looking_fors': selectedLookingFor,
            'desires': selectedDesires,
            'hobbies': selectedHobbies,
            'party_titles': selectedParties,
            'latitude': user.reference?.latitude ?? '',
            'longitude': user.reference?.longitude ?? '',
            'location': user.reference?.location ?? '',
          }
        : {
            'country': user.country ?? '',
            'city': user.city ?? '',
            "birth_date": user.birthDate,
            "age": user.age,
            'f_name': user.fName ?? '',
            'sexuality': user.reference?.sexuality ?? selectGender.value,
            "user_type": user.userType ?? '',
            // "id_document": user.verification?.idDocument.toString() ?? '',
            // "utility_bill": user.verification?.utilityBill.toString() ?? '',
            "selfie": user.verification?.selfie.toString() ?? '',
            'description': user.reference?.description ?? '',
            'eye_color': user.reference?.eyeColor ?? '',
            'ethnicity': user.reference?.ethnicity ?? '',
            'education': user.reference?.education ?? '',
            'languages': user.reference?.language?.toList() ?? [],
            'drinking_habit': user.additionalInfo?.drinkingHabit ?? '',
            'smoking_habit': user.additionalInfo?.smokingHabit ?? '',
            'safety_practice': user.additionalInfo?.safetyPractice ?? '',
            'body_type': user.additionalInfo?.bodyType ?? '',
            'looking_fors': selectedLookingFor,
            'desires': selectedDesires,
            'hobbies': selectedHobbies,
            'party_titles': selectedParties,
            'latitude': user.reference?.latitude ?? '',
            'longitude': user.reference?.longitude ?? '',
            'location': user.reference?.location ?? '',
          };
    if (user.reference!.shareLink != null) {
      singleBody['referral_shared_link'] = user.reference!.shareLink;
      singleBody["share_link"] = user.reference!.shareLink;
    }
    log(singleBody.toString());

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("https://blaxity.codergize.com/api/user/update-profile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(singleBody),
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        log(responseData.toString());
        print("Message: Passion details updated successfully");
        User _user = User.fromJson(responseData["user"]);
        String? userType = await ControllerLogin.getUserType();
        if (userType == "couple") {
          Get.offAll(ScreenAddPhotos(
            step: '10 of 11',
            user: _user,
          ));
        } else {
          Get.offAll(ScreenStayConnectedSingleUser(
            step: '10 of 11',
            user: _user,
          ));
        }
      } else {
        log("Failed to update passion details: ${response.body}");
        FirebaseUtils.showError(
            "Failed to update passion details. Please try again.");
      }
    } catch (error) {
      print("Error occurred: $error");
      FirebaseUtils.showError(
          "An error occurred while updating passion details.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Add recent photos
  RxString privacy = '0'.obs;
  var recentImages = <String>[].obs;

  Future<void> updatePhotos(User user) async {
    String? token = await ControllerLogin.getToken();
    int? id = await ControllerLogin.getUid();
    isLoading.value = true;
    final url = Uri.parse(APiEndPoint.createImages);
    final request = http.MultipartRequest('POST', url);
    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    request.headers.addAll(headers);

    if (privacy.value.isNotEmpty) {
      request.fields['visibility_recent_images'] = privacy.value;
    }

    if (recentImages.isNotEmpty) {
      for (var image in recentImages) {
        request.files.add(
            await http.MultipartFile.fromPath('user_recent_images[]', image));
      }
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful response
        log(response.reasonPhrase.toString());
        print('Photos added successfully');
        print('Response: ${response.reasonPhrase}');

        // Fetch updated user profile
        var userProfile = await ControllerHome().fetchUserProfile();
        log(userProfile.toString());

        // Navigate to the appropriate screen based on user type
        if (userProfile.user.userType == "couple") {
          Get.offAll(ScreenPermissions(user: userProfile));
        } else if (userProfile.user.userType == "single") {
          Get.offAll(ScreenWelcome());
        } else if (userProfile.user.userType == "individual_event_organizer") {
          Get.to(ScreenWaitListClub(user: userProfile.user));
        }
      } else {
        // Handle failed response
        print('Failed to add photos: ${response.reasonPhrase}');
        FirebaseUtils.showError('Failed to add photos. Please try again.');
      }
    } catch (e) {
      // Handle any exceptions
      print('An error occurred: $e');
      FirebaseUtils.showError('An error occurred while adding photos.');
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

  Future<void> updateClubPhotos(User user) async {
    log(user.userType.toString());
    String? token = await ControllerLogin.getToken();
    int? id = await ControllerLogin.getUid();
    isLoading.value = true;
    final url = Uri.parse("${APiEndPoint.updateClubDetails}${user.id}");

    ///   update-recent-images/${id}
    final request = http.MultipartRequest('POST', url);

    final headers = {
      'Content-Type': 'multipart/form-data',
      // Set the correct content type for multipart request
      'Authorization': 'Bearer $token',
      // Add the token to the headers
    };

    request.headers.addAll(headers);

    if (privacy.value.isNotEmpty) {
      request.fields['visibility_recent_images'] = privacy.value;
    }

    if (recentImages.isNotEmpty) {
      for (var image in recentImages) {
        request.files
            .add(await http.MultipartFile.fromPath('recent_images[]', image));
      }
    }

    List<String> empty = [];
    Club club = user.clubs!.first;

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        log(response.reasonPhrase.toString());

        print('Photos added successfully');
        print('Response: ${response.reasonPhrase}');
        var user =
            await ControllerHome().fetchUserProfile().catchError((error) {
          log("Error$error");
        });
        String? userType = await ControllerLogin.getUserType();
        log("User type${user.user.userType.toString()}");

        if (user.user.userType == "club_event_organizer") {
          Get.to(ScreenCreateEventIndividual(
            user: user.user,
          ));
        }

        isLoading.value = false;
      } else {
        isLoading.value = false;
        print('Failed to add photos: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Update Location
  RxString latitude = '0'.obs;
  RxString longitude = '0'.obs;
  RxString address = ''.obs;

  Future<void> updateLocation(User user) async {
    String? token = await ControllerLogin.getToken();
    List<String> desireTitle =
        user.desires!.map((desire) => desire.title).toList();
    List<String> hobbyTitle =
        user.hobbies!.map((hobby) => hobby.hobbie).toList();
    isLoading.value = true;
    final response = await http.post(
      Uri.parse("https://blaxity.codergize.com/api/user/update-profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'height': user.reference!.height!,
        "Partner_1_name": user.partner1Name,
        "Partner_2_name": user.partner2Name,
        "Partner_1_sex": user.partner1Sex,
        "Partner_2_sex": user.partner2Sex,
        "partner_2_age": user.partner_2_age ?? "",
        "partner_1_age": user.partner_1_age ?? "",
        "birth_date": user.birthDate,
        "city": user.city,
        "country": user.country,
        "user_type": user.userType,
        'eye_color': user.reference!.eyeColor!,
        'ethnicity': user.reference!.ethnicity!,
        'education': user.reference!.education!,
        'languages': user.reference!.language!.toList(),
        // Ensure this is correctly populated with selected languages
        'drinking_habit': user.additionalInfo!.drinkingHabit ?? "",
        'smoking_habit': user.additionalInfo!.smokingHabit ?? "",
        'safety_practice': user.additionalInfo!.safetyPractice,
        'body_type': user.additionalInfo!.bodyType,
        'description': user.reference!.description,
        'looking_for': user.reference!.lookingFor ?? [],
        'desires': desireTitle,
        'hobbies': hobbyTitle,
        'party_titles': user.parties,
      }),
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      log(responseData.toString());
      print("message: About details updated successfully");
      Get.offAll(ScreenExploring(
        user: user,
      ));
      isLoading.value = false;
    } else {
      print("Failed to update about details: ${response.body}");
      isLoading.value = false;
    }
  }

  RxString link = "".obs;

  Future<String> createDynamicLink() async {
    int? id = await ControllerLogin.getUid();
    link.value = "https://blaxity.page.link/content?data=${id}";
    final dynamicLink = {
      "dynamicLinkInfo": {
        "domainUriPrefix": "https://blaxity.page.link",
        "link": link.value,
        "androidInfo": {"androidPackageName": "codergize.com.blaxity"},
        "iosInfo": {"iosBundleId": "codergize.com.blaxity"}
      },
      "suffix": {"option": "SHORT"}
    };

    final response = await http.post(
      Uri.parse(
          'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyCQfJi4kelyyF5MeyyQ43nDrzUKbneQ_Dg'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dynamicLink),
    );
    log(response.body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      log(responseData['shortLink']);
      return responseData['shortLink'];
    } else {
      throw Exception('Failed to create dynamic link');
    }
  }

  /// update qr code and share link
  Future<void> updateQrCodeAndShareLink() async {
    String? token = await ControllerLogin.getToken();
    isLoading.value = true;

    try {
      // Create a dynamic link
      var shareLink = await createDynamicLink();

      if (shareLink != null) {
        // Prepare request for saving QR code
        final response = await http.post(
          Uri.parse("https://blaxity.codergize.com/api/save_QR"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({'share_link': link.value}),
        );

        // Log and handle the response
        log(response.body.toString());

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          log(responseData.toString());
          UserResponse userResponse = UserResponse.fromJson(responseData);
          print("Message: QR code and share link updated successfully");

          // Share the link

          // Navigate to the welcome screen
          // Get.offAll(ScreenWelcome(userResponse:userResponse ,));
        } else {
          // Handle failed response
          print("Failed to update QR code and share link: ${response.body}");
          FirebaseUtils.showError(
              'Failed to update QR code. Please try again.');
        }
      } else {
        // Handle case where the share link could not be created
        FirebaseUtils.showError(
            'Failed to create share link. Please try again.');
      }
    } catch (e) {
      // Handle any exceptions
      print('An error occurred: $e');
      FirebaseUtils.showError(
          'An error occurred while updating QR code and share link.');
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

  ///Single Registration
  TextEditingController nameController = TextEditingController();

  Future<void> singleRegistration() async {
    // Extract input values
    String name = nameController.text;
    String gender = selectGender.value;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = passwordConfirmationController.text;

    // Set loading state to true
    isLoading.value = true;

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse("${APiEndPoint.register}"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'f_name': name,
          'sexuality': gender,
          'email': email,
          "birth_date": birthDate.value.toIso8601String(),
          "age": age.value,
          'password': password,
          "password_confirmation": confirmPassword,
          "user_type": userType.value,
        }),
      );

      // Log the raw response body for debugging
      log(response.body.toString());

      // Parse the response body
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Registration successful
        log("User registration successful: ${responseData.toString()}");
        FirebaseUtils.showSuccess("Registration successful!");

        // Navigate to the OTP screen
        Get.to(
          ScreenEmailOTP(
            email: email,
            step: '3 of 10',
          ),
        );
      } else if (response.statusCode == 422) {
        // Handle validation errors
        var errors = responseData as Map<String, dynamic>;
        errors.forEach((field, messages) {
          for (String message in messages) {
            FirebaseUtils.showError(message);
          }
        });
        log("Validation errors: ${responseData.toString()}");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        FirebaseUtils.showError(
            responseData['message'] ?? "Internal Server Error");
        log("Internal server error: ${responseData.toString()}");
      } else {
        // Handle other errors
        FirebaseUtils.showError(
            responseData['message'] ?? "Unexpected error occurred.");
        log("Unexpected error: ${responseData.toString()}");
      }
    } catch (error) {
      // Handle exceptions and show error using custom snackbar
      FirebaseUtils.showError("An error occurred: $error");
      log("Exception during registration: $error");
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

  /// Update country
  Future<void> updateCountry(User user) async {
    String? token = await ControllerLogin.getToken();
    String _country = country.value;
    String _city = cityController.text;
    isLoading.value = true; // Start loading

    try {
      final response = await http.post(
        Uri.parse("https://blaxity.codergize.com/api/user/update-profile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'country': _country,
          'city': _city,
          'f_name': user.fName,
          'sexuality': user.reference == null
              ? selectGender.value
              : user.reference!.sexuality,
          "user_type": user.userType,
          'latitude': latitude.value,
          "birth_date": user.birthDate,
          "age": user.age,
          'longitude': longitude.value,
          'location': address.value,
        }),
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        User updatedUser = User.fromJson(responseData['user']);
        log(responseData.toString());
        print("Message: About details updated successfully");

        // Navigate to the next screen
        Get.to(
          ScreenSelfieSingleUser(
            step: "5 of 11",
            user: updatedUser,
          ),
        );
      } else {
        // Handle error response
        var errorResponse = jsonDecode(response.body);
        if (errorResponse is Map && errorResponse.containsKey('message')) {
          // Show specific error message if available
          FirebaseUtils.showError("Error: ${errorResponse['message']}");
        } else {
          // Show generic error message
          FirebaseUtils.showError(
              "Failed to update about details: ${response.body}");
        }
      }
    } catch (error) {
      // Handle any exceptions
      FirebaseUtils.showError("An error occurred: $error");
    } finally {
      isLoading.value = false; // End loading
    }
  }

  /// identity verification
  File? idDocument;
  File? utilityBill;
  TextEditingController idDocumentController = TextEditingController();
  TextEditingController utilityBillController = TextEditingController();

  Future<void> pickDocument(bool isIdDocument) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isIdDocument) {
        idDocument = File(pickedFile.path);
        idDocumentController.text = pickedFile.name;
      } else {
        utilityBill = File(pickedFile.path);
        utilityBillController.text = pickedFile.name;
      }
      update();
    }
  }

  Future<void> updateDocument(User user) async {
    String? token = await ControllerLogin.getToken();
    isLoading.value = true; // Start loading

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://blaxity.codergize.com/api/user/update-profile'),
      );

      // Add headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Add files if they exist
      if (idDocument != null) {
        request.files.add(
            await http.MultipartFile.fromPath('id_document', idDocument!.path));
      }
      if (utilityBill != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'utility_bill', utilityBill!.path));
      }

      // Add fields
      request.fields.addAll({
        'country': user.country ?? '',
        'city': user.city ?? '',
        'f_name': user.fName ?? '',
        "birth_date": user.birthDate!,
        "age": "${user.age}",
        'sexuality': user.reference == null
            ? selectGender.value
            : user.reference!.sexuality ?? '',
        'user_type': user.userType ?? '',
        'latitude':
            user.reference == null ? "" : user.reference!.latitude ?? '',
        'longitude':
            user.reference == null ? "" : user.reference!.longitude ?? '',
        'location':
            user.reference == null ? "" : user.reference!.location ?? '',
      });

      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful response
        UserResponse user = await ControllerHome().fetchUserProfile();
        print("Message: About details updated successfully");

        // Navigate to the next screen
        Get.to(ScreenSelfieSingleUser(step: '6 of 11', user: user.user));
      } else {
        // Read response stream and handle error
        final errorBody = await response.stream.bytesToString();
        print("Failed to update about details: ${response.reasonPhrase}");

        // Parse the error response
        var errorResponse = jsonDecode(errorBody);
        if (errorResponse is Map && errorResponse.containsKey('message')) {
          FirebaseUtils.showError("Error: ${errorResponse['message']}");
        } else {
          FirebaseUtils.showError(
              "Failed to update about details: ${response.reasonPhrase}");
        }
      }
    } catch (error) {
      // Handle any exceptions
      FirebaseUtils.showError("An error occurred: $error");
    } finally {
      isLoading.value = false; // End loading
    }
  }

  /// update selfie
  File? selfie;

  Future<void> updateSelfie(User user) async {
    String? token = await ControllerLogin.getToken();
    isLoading.value = true; // Start loading

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://blaxity.codergize.com/api/user/update-profile'),
      );

      // Add headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Add selfie file if it exists
      if (selfie != null) {
        request.files
            .add(await http.MultipartFile.fromPath('selfie', selfie!.path));
      }

      // Add form fields
      request.fields.addAll({
        'country': user.country ?? '',
        'city': user.city ?? '',
        'f_name': user.fName ?? '',
        "birth_date": user.birthDate!,
        "age": "${user.age}",
        'sexuality': user.reference == null
            ? selectGender.value
            : user.reference!.sexuality ?? '',
        'user_type': user.userType ?? '',
        // 'id_document': user.verification?.idDocument?.toString() ?? '',
        // 'utility_bill': user.verification?.utilityBill?.toString() ?? '',
        'latitude':
            user.reference == null ? "" : user.reference!.latitude ?? '',
        'longitude':
            user.reference == null ? "" : user.reference!.longitude ?? '',
        'location':
            user.reference == null ? "" : user.reference!.location ?? '',
      });

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful response
        print("Message: About details updated successfully");
        UserResponse userResponse = await ControllerHome().fetchUserProfile();
        log(userResponse.user.toString());
        // Navigate to the next screen
        Get.to(ScreenDescribe(step: '8 of 10', user: userResponse.user));
      } else {
        // Read response stream and handle error
        final errorBody = await response.stream.bytesToString();
        print("Failed to update about details: ${response.statusCode}");

        // Parse the error response
        var errorResponse = jsonDecode(errorBody);
        if (errorResponse is Map && errorResponse.containsKey('message')) {
          FirebaseUtils.showError("Error: ${errorResponse['message']}");
        } else {
          FirebaseUtils.showError(
              "Failed to update about details: ${response.statusCode}");
        }
      }
    } catch (error) {
      // Handle any exceptions
      FirebaseUtils.showError("An error occurred: $error");
    } finally {
      isLoading.value = false; // End loading
    }
  }

  /// individual verification
  List<String> freeServices = <String>[
    "Catering",
    "Wi-Fi",
    "Coffee",
    "Parking",
    "Charging",
    "Restrooms",
    "On-Site Security",
    "Travel",
    "Dance",
    "Accessibility",
    "Drinks"
  ].obs;
  File? profileImage;
  List<String> selectedServices = <String>[].obs;

  Future<void> registerIndividualVerification() async {
    // Set loading state to true
    isLoading.value = true;

    // Extract input values
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = passwordConfirmationController.text;

    try {
      // Get authorization token
      String? token = await ControllerLogin.getToken();

      // Prepare the multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${APiEndPoint.register}'),
      );

      // Add headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Add profile image if available
      if (profileImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('image', profileImage!.path));
      }

      // Add selected services and other form fields
      selectedServices.forEach((service) {
        request.fields['free_services[]'] = service;
      });

      request.fields.addAll({
        'f_name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'user_type': userType.value,
        'club_location': address.value,
        'club_latitude': latitude.value,
        'club_longitude': longitude.value,
      });

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful registration
        print("Registration successful");
        Get.to(ScreenEmailOTP(
          email: email,
          step: '5 of 5',
        ));
      } else {
        // Handle errors
        final responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);
        FirebaseUtils.showError("${responseBody}");
      }
    } catch (e) {
      // Handle exceptions
      FirebaseUtils.showError("Error during registration: $e");
    } finally {
      // Reset loading state
      isLoading.value = false;
    }
  }

  /// Club Registration
  TextEditingController clubNameController = TextEditingController();
  TextEditingController clubPhoneController = TextEditingController();
  RxString countryCode = '+961'.obs;
  File? logoImage;
  var openingDay = ''.obs;
  var closingDay = ''.obs;
  var openingTime = 'Select Opening Time'.obs;
  var closingTime = 'Select Closing Time'.obs;

  Future<void> registerClub() async {
    // Set loading state to true
    isLoading.value = true;

    // Extract input values
    String name = clubNameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = passwordConfirmationController.text;

    try {
      // Create the multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${APiEndPoint.register}'),
      );

      // Add headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token', // Uncomment if token is needed
      });

      // Add club logo if available
      if (logoImage != null) {
        request.files
            .add(await http.MultipartFile.fromPath('logo', logoImage!.path));
      }
      log(request.toString());

      // Add recent images if available
      if (recentImages.isNotEmpty) {
        for (var image in recentImages) {
          request.files
              .add(await http.MultipartFile.fromPath('recent_images[]', image));
        }
      }
      log(request.files.toString());

      // Add other form fields
      request.fields.addAll({
        'f_name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'phone': countryCode.value + clubPhoneController.text,
        'user_type': userType.value,
        'club_location': address.value,
        'club_latitude': latitude.value,
        'club_longitude': longitude.value,
        'opening_date': openingDay.value,
        'opening_time': openingTime.value,
        'closing_day': closingDay.value,
        'closing_time': closingTime.value,
        'description': describeYourselfController.text,
        'free_services[]': selectedServices.join(","),
        'visibility_recent_images':
            privacy.value.isNotEmpty ? privacy.value : "public",
      });
      log(request.fields.toString());

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful registration
        print("Registration successful");
        Get.to(ScreenEmailOTP(
          email: email,
          step: '9 of 9',
        ));
      } else {
        // Handle errors
        final responseBody = await response.stream.bytesToString();
        print("Failed to register: ${response.reasonPhrase}");
        print("Response body: $responseBody");
        FirebaseUtils.showError("Failed to register: ${responseBody}");
      }
    } catch (e) {
      // Handle exceptions
      print("Error during registration: $e");
      FirebaseUtils.showError("Error during registration: $e");
    } finally {
      // Ensure loading state is reset
      isLoading.value = false;
    }
  }

  Future<void> updateClub({
    required Club club,
    required String f_name,
    required String descrption,
    required String phone,
    File? logo_image,
    String? location,
    String? latitude,
    String? longitude,
    String? openingDay,
    String? closingDay,
    String? openingTime,
    String? closingTime,
    String? describeYourself,
    List<String>? selectedServices,
  }) async {
    isLoading.value = true;

    // Assign default values if parameters are null
    String _location = location ?? club.location ?? "";
    String _latitude = latitude ?? club.latitude ?? "";
    String _longitude = longitude ?? club.longitude ?? "";
    String _openingDay = openingDay ?? club.openingDate ?? "";
    String _closingDay = closingDay ?? club.closingDay ?? "";
    String _openingTime = openingTime ?? club.openingTime ?? "";
    String _closingTime = closingTime ?? club.closingTime ?? "";
    String url = "${APiEndPoint.updateProfile}";
    // log()
    String? token = await ControllerLogin.getToken();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
        url,
      ),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (logo_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('Logo', logo_image.path));
    } else {
      request.fields.addAll({"logo": club.logo ?? ""});
    }

    List<String> empty = [];
    request.fields.addAll({
      'f_name': f_name,
      'phone': phone,
      'description': descrption,
      'club_location': _location,
      'club_latitude': _latitude,
      'club_longitude': _longitude,
      'opening_date': _openingDay,
      'opening_time': _openingTime,
      'closing_day': _closingDay,
      'closing_time': _closingTime,
      "free_services[]": club.freeService?.join(",") ?? empty.join(),
    });

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      log(responseBody.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(Get.context!);
        await Get.find<ControllerHome>().fetchUserInfo();
        FirebaseUtils.showSuccess("Club details updated successfully.");
      } else {
        log(responseBody.toString());

        handleErrorResponse(response.statusCode, responseBody);
      }
    } catch (e) {
      log(e.toString());
      FirebaseUtils.showError("Error updating club details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void handleErrorResponse(int statusCode, String responseBody) {
    if (statusCode == 422) {
      // Handle validation errors
      FirebaseUtils.showError("Validation error: $responseBody");
    } else if (statusCode == 403) {
      // Handle forbidden error
      FirebaseUtils.showError(
          "Access forbidden: User is not an event organizer.");
    } else if (statusCode == 500) {
      // Handle server error
      FirebaseUtils.showError("Internal server error: $responseBody");
    } else {
      // Handle unexpected errors
      FirebaseUtils.showError("Unexpected error: $responseBody");
    }
  }

  Future<void> pickImage(bool isProfile) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isProfile) {
        profileImage = File(pickedFile.path);
      } else {
        logoImage = File(pickedFile.path);
      }
      update();
    }
  }

  Future<void> pickSelfie() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selfie = File(pickedFile.path);
      update();
    }
  }

  var languagesList = <String>[].obs;

  void updateMaleGender(String gender) {
    partnerOneGender.value = gender;
  }

  void updateFemaleGender(String gender) {
    partnerTwoGender.value = gender;
  }

  var shareLink = ''.obs;

  // var sexuality = ''.obs;
  var generatedQACode = ''.obs;

  //
  // String? drinkingHabit;
  // String? smokingHabit;
  // String? safetyPractice;
  // // var location = ''.obs;
  // var weight = ''.obs;
  //
  // var shareLink = 'Yes'.obs;
  // var sexuality = ''.obs;
  // var generatedQACode = ''.obs;
  //
  // // var description = ''.obs;
  //
  // var attributes = <String>[].obs;
  //
  // var email = ''.obs;
  // var password = ''.obs;
  // var confirmPassword = ''.obs;
  // var phone = ''.obs;
  //
  // // var age = ''.obs;
  //
  // void updateMaleGender(String gender) {
  //   partnerOneGender.value = gender;
  // }
  //
  // void updateFemaleGender(String gender) {
  //   partnerTwoGender.value = gender;
  // }
  //
  //
  //
  // Future<Map<String, dynamic>> registerUser() async {
  //   isLoading.value = true;
  //   final Uri url = Uri.parse(APiEndPoint.register);
  //   final request = http.MultipartRequest('POST', url);
  //
  //   final headers = {
  //     'Content-Type': 'application/json',
  //   };
  //
  //   request.headers.addAll(headers);
  //
  //   // Add only non-empty fields to the request
  //   void addField(String key, String value) {
  //     if (value.isNotEmpty) {
  //       request.fields[key] = value;
  //     }
  //   }
  //
  //   addField('f_name', firstPartnerName.text.trim());
  //   addField('email', email.value);
  //   addField('password', password.value);
  //   addField('password_confirmation', confirmPassword.value);
  //   addField('phone', phone.value);
  //   addField('user_type', userType.value);
  //   // addField('age', age.value);
  //   addField('city', cityController.text);
  //   addField('country', country.value);
  //   // addField('device_token', deviceToken.value);
  //   addField('birth_date', birthDate.value.toString());
  //   addField('Partner_1_sex', partnerOneGender.value);
  //   addField('Partner_2_sex', partnerTwoGender.value);
  //   // addField('verification_status', verificationStatus.value);
  //   // addField('opening_date', openingDate.value);
  //   // addField('opening_time', openingTime.value);
  //   // addField('club_location', clubLocation.value);
  //   addField('drinking_habit', drinkingHabit!);
  //   addField('smoking_habit', smokingHabit!);
  //   // addField('body_type', bodyType!);
  //   addField('safety_practice', safetyPractice!);
  //   addField('location', address.value);
  //   addField('height', height.value);
  //   addField('weight', weight.value);
  //   // addField('eye_color', eyeColor.value);
  //   // addField('ethnicity', ethnicity.value);
  //   // addField('smoking', smoking.value);
  //   // addField('piercing', piercing.value);
  //   addField('share_link', shareLink.value);
  //   addField('sexuality', sexuality.value);
  //   // addField('education', education.value);
  //   addField('generated_QA_code', generatedQACode.value);
  //   // addField('description', description.value);
  //   addField('longitude', longitude.value);
  //   addField('latitude', latitude.value);
  //   // addField('hobbies', jsonEncode(hobbies));
  //   // addField('desires', jsonEncode(desires));
  //   // addField('party_titles', jsonEncode(partyTitles));
  //   // addField('recent_images', jsonEncode(recentImages));
  //
  //   // Adding file fields
  //   if (profileImage != null) {
  //     request.files
  //         .add(await http.MultipartFile.fromPath('image', profileImage!.path));
  //   }
  //
  //   if (idDocument != null) {
  //     request.files.add(
  //         await http.MultipartFile.fromPath('id_document', idDocument!.path));
  //   }
  //   if (utilityBill != null) {
  //     request.files.add(
  //         await http.MultipartFile.fromPath('utility_bill', utilityBill!.path));
  //   }
  //
  //   try {
  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();
  //     final responseJson = jsonDecode(responseBody);
  //     log('Response Body: $responseJson');
  //     log(response.toString());
  //     log(responseJson.toString());
  //     if (response.statusCode == 200) {
  //       isLoading.value = false;
  //       return responseJson;
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to register: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     rethrow;
  //   }
  // }

  /// User login

  Future<void> userLogin() async {
    isLoading.value = true;
    String email = emailController.text;
    String password = passwordController.text;
    String apiUrl = APiEndPoint.login;

    var body = jsonEncode({'email': email, 'password': password});

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      var responseData = jsonDecode(response.body);
      log(response.body);
      log(responseData.toString());

      if (response.statusCode == 200) {
        // Login successful
        isLoading.value = false;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', responseData['access_token']);
        await prefs.setInt('id', responseData['user']['id']);
        await prefs.setString('userType', responseData['user']['user_type']);

        UserResponse user = UserResponse.fromJson(responseData);
        log(user.user.userType.toString());

        // Display success message
        FirebaseUtils.showSuccess("Login successful");

        // Navigation logic based on user type
        navigateBasedOnUserType(user);
      } else if (response.statusCode == 422) {
        // Unprocessable Entity (validation errors)
        String emailErrors = responseData['email']?.join(', ') ?? '';
        String passwordErrors = responseData['password']?.join(', ') ?? '';
        String combinedErrors =
            [emailErrors, passwordErrors].where((e) => e.isNotEmpty).join('\n');
        String errorMessage = responseData['message'] ?? '';
        FirebaseUtils.showError(combinedErrors.isNotEmpty
            ? combinedErrors
            : "Validation errors occurred.");
        if (errorMessage.contains('Email is not verified')) {
          FirebaseUtils.showError(
              "Email is not verified. Please verify your email.");

          // Navigate to OTP screen
          Get.to(() => ScreenEmailOTP(
                email: email,
                step: '5/11',
              )); // Adjust to your OTP screen logic
        }
      } else if (response.statusCode == 401) {
        // Unauthorized (invalid email or password)
        String errorMessage =
            responseData['message'] ?? "Invalid email or password.";
        FirebaseUtils.showError(errorMessage);
        if (errorMessage.contains('Email is not verified')) {
          FirebaseUtils.showError(
              "Email is not verified. Please verify your email.");

          // Navigate to OTP screen
          Get.to(() => ScreenEmailOTP(
                email: email,
                step: '5/11',
              )); // Adjust to your OTP screen logic
        }
      } else if (response.statusCode == 403) {
        // Forbidden (email not verified)
        String errorMessage =
            responseData['message'] ?? "Email is not verified.";
        FirebaseUtils.showError(errorMessage);

        if (errorMessage.contains('Email is not verified')) {
          FirebaseUtils.showError(
              "Email is not verified. Please verify your email.");

          // Navigate to OTP screen
          Get.to(() => ScreenEmailOTP(
                email: email,
                step: '5/11',
              )); // Adjust to your OTP screen logic
        }
      } else if (response.statusCode == 500) {
        // Internal Server Error
        String errorMessage = responseData['message'] ??
            "An internal server error occurred. Please try again later.";
        FirebaseUtils.showError(errorMessage);
      } else {
        // Handle other unexpected status codes
        FirebaseUtils.showError(
            "Make Sure you have Stable Internet Connection. Please try again.");
      }
    } catch (e) {
      // Handle exceptions
      isLoading.value = false;
      log("Error during login: $e");
      FirebaseUtils.showError("An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

// Helper method to navigate based on user type
  void navigateBasedOnUserType(UserResponse userResponse) {
    User user = userResponse.user;
    if (user.userType == "couple") {
      if (user.reference == null || user.reference!.height == null) {
        Get.offAll(() => ScreenChooseHeight(step: "6 of 11", user: user));
      } else if (user.reference!.shareLink == null &&
          user.reference!.eyeColor == null) {
        Get.offAll(() => ScreenAboutDetails(step: "7 of 11", user: user));
      } else if (user.commonCoupleData!.description == null &&
          user.reference!.shareLink == null) {
        Get.offAll(() => ScreenDescribe(step: '8 of 11', user: user));
      } else if (user.coupleRecentImage == null) {
        Get.offAll(() => ScreenAddPhotos(step: '9 of 11', user: user));
      } else if (user.reference!.shareLink == null) {
        Get.offAll(() => ScreenExploring(user: user));
      } else if (userResponse.has_couple == "0") {
        Get.to(ScreenExploring(user: user));
      } else {
        Get.offAll(() => HomeScreen());
      }
    } else if (user.userType == "single") {
      if (user.country!.isEmpty) {
        Get.offAll(() => ScreenChooseCountry(step: "5 of 11", user: user));
      }
      // else if (user.verification!.idDocument!.isEmpty) {
      //   Get.offAll(
      //       () => ScreenIdentityVerification(step: "6 of 11", user: user));
      // }
      else if (user.verification!.selfie!.isEmpty) {
        Get.offAll(() => ScreenSelfieSingleUser(step: " 7 of 11", user: user));
      } else if (user.reference!.description!.isEmpty) {
        Get.offAll(() => ScreenDescribe(step: "8 of 11", user: user));
      } else if (user.reference!.eyeColor!.isEmpty) {
        Get.offAll(() => ScreenAboutDetails(step: "9 of 11", user: user));
      } else if (user.reference!.lookingFor!.isEmpty) {
        Get.offAll(() => ScreenPassion(step: "10 of 11", user: user));
      } else if (user.singleRecentImage == null) {
        Get.offAll(() => ScreenAddPhotos(step: "11 of 11", user: user));
      } else if (user.waitListStatus == 0 && user.goldenMember == 0) {
        Get.to(ScreenWaitListSingleUser());
      } else {
        Get.offAll(() => HomeScreen());
      }
    } else if (user.userType == "individual_event_organizer") {
      if (user.ownerEvent == null) {
        Get.offAll(() => ScreenCreateEventIndividual(user: user));
      } else if (user.singleRecentImage == null) {
        Get.offAll(() => ScreenAddPhotos(step: "11 of 11", user: user));
      } else if (user.waitListStatus == 0 && user.goldenMember == 0) {
        Get.to(ScreenWaitListClub(user: user));
      } else {
        Get.offAll(() => HomeScreen());
      }
    } else if (user.userType == "club_event_organizer") {
      if (user.clubs!.first.recentImages == null) {
        Get.offAll(() => ScreenAddPhotos(step: "11 of 11", user: user));
      } else if (user.ownerEvent == null) {
        Get.offAll(() => ScreenCreateEventIndividual(user: user));
      } else if (user.waitListStatus == 0 && user.goldenMember == 0) {
        Get.to(ScreenWaitListClub(user: user));
      } else {
        Get.offAll(() => HomeScreen());
      }
    } else {
      Get.offAll(() => ScreenSplash());
    }
  }

  ///update userType
  Future<void> updateUserType() async {
    isLoading.value = true;
    String? accessToken = await ControllerLogin.getToken();
    String apiUrl = APiEndPoint.updateProfile;
    var body = jsonEncode({
      'user_type': "couple",
      "Partner_1_name": "tes",
      "Partner_2_name": "test",
      "Partner_1_sex": "male",
      "Partner_2_sex": "female",
      "country": "test",
      "city": "Layyah"
    });
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: body,
    );
    var responseData = jsonDecode(response.body);
    log(response.body);
    log(responseData.toString());
    if (response.statusCode == 200) {
      isLoading.value = false;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('userType', responseData['user']['user_type']);
      log(responseData.toString());
    } else {
      isLoading.value = false;
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }

  Future<void> partnerTwo() async {}

  ///Update Couple
  Future<void> updateCoupleProfile(
    User user, {
    String? height,
    String? city,
    String? country,
    String? descriptions,
    String? eyeColor,
    String? bodyType,
    String? location,
    String? latitude,
    String? longitude,
    String? ethnicity,
    String? education,
    List<String>? languages,
    String? drinkingHabit,
    String? smokingHabit,
    String? safetyPractice,
    List<String>? selectedDesires,
    List<String>? lookingFor,
    List<String>? hobbies,
    List<String>? desires,
    List<String>? Party,
    List<String>? attributes,
    String? shareLink,
  }) async {
    String? token = await ControllerLogin.getToken();
    log("Click");
    var singleBody = user.userType == "couple"
        ? {
            'height': height ?? user.reference!.height!,
            "Partner_1_name": user.partner1Name,
            "Partner_2_name": user.partner2Name,
            "Partner_1_sex": user.partner1Sex,
            "Partner_2_sex": user.partner2Sex,
            "birth_date": user.birthDate,
            "city": city ?? user.commonCoupleData?.city ?? "",
            "country": country ?? user.commonCoupleData?.country ?? "",
            "user_type": user.userType,
            'eye_color': eyeColor ?? user.reference!.eyeColor!,
            'ethnicity': ethnicity ?? user.reference!.ethnicity!,
            'education': education ?? user.reference!.education!,
            'languages': languages ?? user.reference!.language!.toList(),
            'drinking_habit':
                drinkingHabit ?? user.additionalInfo?.drinkingHabit ?? "",
            'smoking_habit':
                smokingHabit ?? user.additionalInfo?.smokingHabit ?? "",
            'safety_practice':
                safetyPractice ?? user.additionalInfo?.safetyPractice,
            'body_type': bodyType ?? user.additionalInfo?.bodyType,
            'description':
                descriptions ?? user.commonCoupleData?.description ?? "Test",
            'looking_fors': lookingFor ?? selectedLookingFor,
            'desires': desires ?? selectedDesires,
            'attributes': hobbies ?? attributes,
            'hobbies': hobbies ?? selectedHobbies,
            'party_titles': Party ?? selectedParties,
            'latitude': latitude ?? user.reference?.latitude ?? "",
            'longitude': longitude ?? user.reference?.longitude ?? "",
            'location': location ?? user.reference?.location ?? "",
          }
        : {
            'country': user.country!,
            'city': user.city!,
            'f_name': user.fName!,
            'age': user.age!,
            "birth_date": user.birthDate,

            'sexuality': user.reference?.sexuality ?? selectGender.value,
            "user_type": user.userType!,
            // "id_document": user.verification!.idDocument.toString(),
            // "utility_bill": user.verification!.utilityBill.toString(),
            "selfie": user.verification!.selfie.toString(),
            'description': user.reference!.description!,
            'eye_color': eyeColor ?? user.reference!.eyeColor!,
            'ethnicity': ethnicity ?? user.reference!.ethnicity!,
            'education': education ?? user.reference!.education!,
            'languages': languages ?? user.reference!.language!.toList(),
            'drinking_habit':
                drinkingHabit ?? user.additionalInfo?.drinkingHabit ?? "",
            'smoking_habit':
                smokingHabit ?? user.additionalInfo?.smokingHabit ?? "",
            'safety_practice':
                safetyPractice ?? user.additionalInfo?.safetyPractice,
            'body_type': bodyType ?? user.additionalInfo?.bodyType,
            'looking_fors': lookingFor ??
                user.reference?.lookingFor!.map((e) => e).toList(),
            'desires': desires ?? user.desires!.map((e) => e.title).toList(),
            'hobbies': hobbies ?? user.hobbies!.map((e) => e.hobbie).toList(),
            'party_titles': Party ?? user.parties!.map((e) => e.name).toList(),
            'latitude': latitude ?? user.reference?.latitude ?? "",
            'longitude': longitude ?? user.reference?.longitude ?? "",
            'location': location ?? user.reference?.location ?? "",
      'attributes': hobbies ?? attributes,

    };

    log(singleBody.toString());
    isLoading.value = true; // Start loading indicator
    try {
      final response = await http.post(
        Uri.parse("https://blaxity.codergize.com/api/user/update-profile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(singleBody),
      );
      log(response.body);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        log(responseData.toString());
        print("Message: About details updated successfully");
        User _user = User.fromJson(responseData["user"]);
        Get.back();
        await ControllerHome().fetchUserInfo();
        isLoading.value = false; // Stop loading indicator
      } else {
        // Show error message with red background
        FirebaseUtils.showError("Failed to update profile.");
        isLoading.value = false; // Stop loading indicator
      }
    } catch (e) {
      log(e.toString());
      // Handle exceptions and show error message
      FirebaseUtils.showError("An error occurred: $e");
      isLoading.value = false; // Stop loading indicator
    } finally {
      isLoading.value = false;
    }
  }
}
