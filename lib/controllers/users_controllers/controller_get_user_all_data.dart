import 'dart:developer';
import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/firebase_utils.dart';
import '../../models/user.dart';  // Ensure this file contains your User model and JSON parsing logic.
import 'dart:convert';

class ControllerGetUserAllData extends GetxController {
  var isLoading = false.obs;
  var userList = <User>[].obs; // Change the list type to User instead of UserResponse if User is your model

  Future<void> getUserDataAdvanced({
    List<String>? hobbies,
    List<String>? desires,
    List<String>? parties,
    List<String>? lookingFor,
    String? bodyType,
    int? age,
    String? country,
    String? eyeColor,
    String? ethnicity,
    String? smoking,
    String? drinking,
    String? education,
    List<String>? languages,
    String? sexuality,
    List<String>? attributes,
  })
  async {



    log(hobbies.toString());
    log(desires.toString());
    log(parties.toString());
    log(lookingFor.toString());
    log(bodyType.toString());
    log(age.toString());
    log(country.toString());
    log(eyeColor.toString());
    log(ethnicity.toString());
    log(smoking.toString());
    log(drinking.toString());
    log(education.toString());
    log(languages.toString());
    log(sexuality.toString());
    log(attributes.toString());

    String? token = await ControllerLogin.getToken();

    if (token == null) {
      log('Token is null. Cannot fetch user data.');
      FirebaseUtils.showError("Authentication token is missing.");
      return;
    }

    isLoading.value = true;

    // Build the query parameters
    Map<String, dynamic> queryParams = {};

    log(queryParams.toString());

    // Construct the URL with query parameters
    Uri uri = Uri.parse(APiEndPoint.getUserAllData).replace(queryParameters: queryParams);

    try {
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the JSON response safely
        var data = jsonDecode(response.body);

        // Initialize empty lists for singles and couples
        List<User> coupleUser = [];
        List<User> singleUser = [];

        // Safely parse the 'couples' data
        if (data['couples'] != null) {
          List<User> allCouples = List<User>.from(
            (data['couples'] as List).map((json) => User.fromJson(json as Map<String, dynamic>)),
          );

          // Filter the couples based on the provided criteria
          coupleUser = allCouples.where((user) {
            log("${user.id}:${user.partner1Name} ${user.partner2Name}");
            return _isCoupleMatching(
              user,
              hobbies: hobbies,
              desires: desires,
              parties: parties,
              lookingFor: lookingFor,
              bodyType: bodyType,
              partner1Age: age,
              partner2Age: age,
              country: country,
              eyeColor: eyeColor,
              ethnicity: ethnicity,
              smoking: smoking,
              drinking: drinking,
              education: education,
              languages: languages,
              sexuality: sexuality,
              attributes: attributes,
            );
          }).toList();
        }

        // Safely parse the 'singles' data
        if (data['singles'] != null) {
          singleUser = List<User>.from(
            (data['singles'] as List).map((json) => User.fromJson(json as Map<String, dynamic>)),
          );
          // Filter the singles based on the provided criteria
          singleUser = singleUser.where((user) {
            return _isSingleUserMatching(
              user,
              hobbies: hobbies,
              desires: desires,
              parties: parties,
              lookingFor: lookingFor,
              bodyType: bodyType,
              age: age,
              country: country,
              eyeColor: eyeColor,
              ethnicity: ethnicity,
              smoking: smoking,
              drinking: drinking,
              education: education,
              languages: languages,
              sexuality: sexuality,
              attributes: attributes,
            );
          }).toList();
        }

        // Update the observable list with the combined data
        userList.value = singleUser + coupleUser;
        userList.value.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        log(userList.value.toString());
        Navigator.pop(Get.context!);

        log("User data retrieved successfully.");
      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        FirebaseUtils.showError(data['message'] ?? "No data found for the given parameters.");
      } else if (response.statusCode == 500) {
        final data = jsonDecode(response.body);
        FirebaseUtils.showError(data['message'] ?? "An internal server error occurred.");
      } else {
        log("Unexpected status code: ${response.statusCode}");
        log('Response body: ${response.body}');
        FirebaseUtils.showError("An unexpected error occurred.");
      }
    } catch (e) {
      log("Error fetching user data: $e");
      FirebaseUtils.showError("An error occurred while fetching user data.");
    } finally {
      isLoading.value = false;
    }
  }

  bool _isCoupleMatching(
      User user, {
        List<String>? hobbies,
        List<String>? desires,
        List<String>? parties,
        List<String>? lookingFor,
        String? bodyType,
        int? partner1Age,
        int? partner2Age,
        String? country,
        String? eyeColor,
        String? ethnicity,
        String? smoking,
        String? drinking,
        String? education,
        List<String>? languages,
        String? sexuality,
        List<String>? attributes,
      }) {
    bool matches = true;

    // Debug logs

    // Check for hobbies
    log(user.partner1Name.toString());
    log(user.commonCoupleData!.partyTitles.toString());
    if (hobbies != null && hobbies.isNotEmpty) {
      log('Hobbies filter: $hobbies');
      log('User hobbies: ${user.commonCoupleData?.hobbies}');
      matches &= _listIntersects(user.commonCoupleData?.hobbies ?? [], hobbies);
    }

    // Check for desires
    if (desires != null && desires.isNotEmpty) {
      log('Desires filter: $desires');
      log('User desires: ${user.commonCoupleData?.desires}');
      matches &= _listIntersects(user.commonCoupleData?.desires ?? [], desires);
    }

    // Check for parties
    if (parties != null && parties.isNotEmpty) {
      log('Parties filter: $parties');
      log('User parties: ${user.commonCoupleData?.partyTitles}');
      matches &= _listIntersects(user.commonCoupleData?.partyTitles , parties);
    }

    // Check for lookingFor
    if (lookingFor != null && lookingFor.isNotEmpty) {
      log('LookingFor filter: $lookingFor');
      log('User lookingFors: ${user.commonCoupleData?.lookingFors}');
      matches &= _listIntersects(user.commonCoupleData?.lookingFors, lookingFor);
    }

    // Check for bodyType
    if (bodyType != null) {
      log('BodyType filter: $bodyType');
      log('User bodyType: ${user.additionalInfo?.bodyType}');
      matches &= user.additionalInfo?.bodyType == bodyType;
    }

    // Check for partner ages
    if (partner1Age != null) {
      log('Partner1Age filter: $partner1Age');
      log('User partner1Age: ${user.partner_1_age}');
      matches &= user.partner_1_age == partner1Age;
    }
    if (partner2Age != null) {
      log('Partner2Age filter: $partner2Age');
      log('User partner2Age: ${user.partner_2_age}');
      matches &= user.partner_2_age == partner2Age;
    }

    // Check for country
    if (country != null) {
      log('Country filter: $country');
      log('User country: ${user.commonCoupleData?.country}');
      matches &= user.commonCoupleData?.country == country;
    }

    // Check for eyeColor
    if (eyeColor != null) {
      log('EyeColor filter: $eyeColor');
      log('User eyeColor: ${user.reference?.eyeColor}');
      matches &= user.reference?.eyeColor == eyeColor;
    }

    // Check for ethnicity
    if (ethnicity != null) {
      log('Ethnicity filter: $ethnicity');
      log('User ethnicity: ${user.reference?.ethnicity}');
      matches &= user.reference?.ethnicity == ethnicity;
    }

    // Check for smoking habit
    if (smoking != null) {
      log('Smoking filter: $smoking');
      log('User smokingHabit: ${user.additionalInfo?.smokingHabit}');
      matches &= user.additionalInfo?.smokingHabit == smoking;
    }

    // Check for drinking habit
    if (drinking != null) {
      log('Drinking filter: $drinking');
      log('User drinkingHabit: ${user.additionalInfo?.drinkingHabit}');
      matches &= user.additionalInfo?.drinkingHabit == drinking;
    }

    // Check for education
    if (education != null) {
      log('Education filter: $education');
      log('User education: ${user.reference?.education}');
      matches &= user.reference?.education == education;
    }

    // Check for languages
    if (languages != null && languages.isNotEmpty) {
      log('Languages filter: $languages');
      log('User languages: ${user.reference?.language}');
      matches &= _listIntersects(user.reference?.language ?? [], languages);
    }

    // Check for sexuality
    if (sexuality != null) {
      log('Sexuality filter: $sexuality');
      log('User sexuality: ${user.partner1Sex}');
      matches &= user.partner1Sex == sexuality || user.partner2Sex == sexuality;
    }

    // Check for attributes
    // if (attributes != null && attributes.isNotEmpty) {
    //   log('Attributes filter: $attributes');
    //   log('User attributes: ${user.reference?.attributes}');
    //   matches &= _listIntersects(user.reference?.attributes ?? [], attributes);
    // }

    log('Match result: $matches');
    return matches;
  }

  bool _listIntersects(List<String>? list1, List<String> list2) {
    if (list1 == null || list1.isEmpty) return false;
    return list1.any((item) => list2.contains(item));
  }


  bool _isSingleUserMatching(
      User user, {
        List<String>? hobbies,
        List<String>? desires,
        List<String>? parties,
        List<String>? lookingFor,
        String? bodyType,
        int? age,
        String? country,
        String? eyeColor,
        String? ethnicity,
        String? smoking,
        String? drinking,
        String? education,
        List<String>? languages,
        String? sexuality,
        List<String>? attributes,
      })
  {
    bool matches = true;

    // Debug logs
    log('Checking single user: ${user.email}');

    // Check if hobbies match
    if (hobbies != null && hobbies.isNotEmpty) {
      log('Hobbies filter: $hobbies');
      log('User hobbies: ${user.hobbies}');
      matches &= _listIntersects(user.hobbies?.map((h) => h.hobbie).toList(), hobbies);
      log(' $matches');

    }

    // Check if desires match
    if (desires != null && desires.isNotEmpty) {
      log('Desires filter: $desires');
      log('User desires: ${user.desires}');
      matches &= _listIntersects(user.desires?.map((d) => d.title).toList(), desires);
      log(' $matches');

    }

    // Check if parties match
    if (parties != null && parties.isNotEmpty) {
      log('Parties filter: $parties');
      log('User parties: ${user.parties}');
      matches &= _listIntersects(user.parties?.map((p) => p.name).toList(), parties);
      log(' $matches');

    }

    // Check if lookingFor match
    if (lookingFor != null && lookingFor.isNotEmpty) {
      log('LookingFor filter: $lookingFor');
      log('User lookingFors: ${user.reference?.lookingFor}');
      matches &= _listIntersects(user.reference?.lookingFor, lookingFor);
      log(' $matches');

    }

    // Check if bodyType matches
    if (bodyType != null) {
      log('BodyType filter: $bodyType');
      log('User bodyType: ${user.additionalInfo?.bodyType}');
      matches &= user.additionalInfo?.bodyType == bodyType;
      log(' $matches');

    }

    // Check if age matches
    if (age != null) {
      log('Age filter: $age');
      log('User age: ${user.age}');
      matches &= user.age == age;
      log(' $matches');

    }

    // Check if country matches
    if (country != null) {
      log('Country filter: $country');
      log('User country: ${user.country}');
      matches &= user.country == country;
      log(' $matches');

    }

    // Check if eyeColor matches
    if (eyeColor != null) {
      log('EyeColor filter: $eyeColor');
      log('User eyeColor: ${user.reference?.eyeColor}');
      matches &= user.reference?.eyeColor == eyeColor;
      log(' $matches');

    }

    // Check if ethnicity matches
    if (ethnicity != null) {
      log('Ethnicity filter: $ethnicity');
      log('User ethnicity: ${user.reference?.ethnicity}');
      matches &= user.reference?.ethnicity == ethnicity;
      log(' $matches');

    }

    // Check if smoking matches
    if (smoking != null) {
      log('Smoking filter: $smoking');
      log('User smoking: ${user.reference?.smorking}');
      matches &= user.reference?.smorking == smoking;
      log(' $matches');

    }

    // Check if drinking matches
    if (drinking != null) {
      log('Drinking filter: $drinking');
      log('User drinkingHabit: ${user.additionalInfo?.drinkingHabit}');
      matches &= user.additionalInfo?.drinkingHabit == drinking;
      log(' $matches');

    }

    // Check if education matches
    if (education != null) {
      log('Education filter: $education');
      log('User education: ${user.reference?.education}');
      matches &= user.reference?.education == education;
      log(' $matches');

    }

    // Check if languages match
    if (languages != null && languages.isNotEmpty) {
      log('Languages filter: $languages');
      log('User languages: ${user.reference?.language}');
      matches &= _listIntersects(user.reference?.language, languages);
      log(' $matches');

    }

    // Check if sexuality matches
    if (sexuality != null) {
      log('Sexuality filter: $sexuality');
      log('User sexuality: ${user.reference?.sexuality}');
      matches &= user.reference?.sexuality == sexuality;
      log(' $matches');

    }

    // Check if attributes match
    if (attributes != null && attributes.isNotEmpty) {
      log('Attributes filter: $attributes');
      log('User attributes: ${user.reference?.attributes}');
      matches &= _listIntersects(user.reference?.attributes, attributes);
      log(' $matches');


    }

    log('Match result: $matches');
    return matches;
  }


// Helper function to check if there's any intersection between two lists
//   bool _listIntersects(List<String>? userList, List<String>? filterList) {
//     if (userList == null || filterList == null) return false;
//     return userList.any((item) => filterList.contains(item));
//   }

  Future<void> getUserData({
    Map<String, dynamic>? location,
    int? distancePreference,
    String? gender,
    int? ageMin,
    int? ageMax,
    List<String>? hobbies,
    List<String>? desires,
    List<String>? parties,
    List<String>? lookingFor,
    String? bodyType,
    int? age,
    String? country,
    int? height,
    int? weight,
    String? eyeColor,
    String? ethnicity,
    String? smoking,
    String? piercing,
    String? education,
    List<String>? languages,
    String? sexuality,
    List<String>? attributes,
  })
  async {
    String? token = await ControllerLogin.getToken();

    if (token == null) {
      log('Token is null. Cannot fetch user data.');
      FirebaseUtils.showError("Authentication token is missing.");
      return;
    }

    isLoading.value = true;

    // Build the query parameters
    Map<String, dynamic> queryParams = {};

    if (location != null) queryParams['location'] = jsonEncode(location);
    if (distancePreference != null) queryParams['distance_preference'] = distancePreference.toString();
    if (gender != null) queryParams['gender'] = gender;
    if (ageMin != null) queryParams['age_min'] = ageMin.toString();
    if (ageMax != null) queryParams['age_max'] = ageMax.toString();
    if (hobbies != null && hobbies.isNotEmpty) queryParams['hobbies'] = jsonEncode(hobbies);
    if (desires != null && desires.isNotEmpty) queryParams['desires'] = jsonEncode(desires);
    if (parties != null && parties.isNotEmpty) queryParams['parties'] = jsonEncode(parties);
    if (lookingFor != null && lookingFor.isNotEmpty) queryParams['looking_for'] = jsonEncode(lookingFor);
    if (bodyType != null) queryParams['body_type'] = bodyType;
    if (age != null) queryParams['age'] = age.toString();
    if (country != null) queryParams['country'] = country;
    if (height != null) queryParams['height'] = height.toString();
    if (weight != null) queryParams['weight'] = weight.toString();
    if (eyeColor != null) queryParams['eye_color'] = eyeColor;
    if (ethnicity != null) queryParams['ethnicity'] = ethnicity;
    if (smoking != null) queryParams['smoking'] = smoking.toString();
    if (piercing != null) queryParams['piercing'] = piercing.toString();
    if (education != null) queryParams['education'] = education;
    if (languages != null && languages.isNotEmpty) queryParams['languages'] = jsonEncode(languages);
    if (sexuality != null) queryParams['sexuality'] = sexuality;
    if (attributes != null && attributes.isNotEmpty) queryParams['attributes'] = jsonEncode(attributes);
    log(queryParams.toString());
    // Construct the URL with query parameters
    Uri uri = Uri.parse(APiEndPoint.getUserAllData).replace(queryParameters: queryParams);

    try {
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the JSON response safely
        var data = jsonDecode(response.body);

        // Initialize empty lists for singles and couples
        List<User> coupleUser = [];
        List<User> singleUser = [];

        // Safely parse the 'couples' data
        if (data['couples'] != null) {
          coupleUser = List<User>.from(
            (data['couples'] as List).map((json) => User.fromJson(json as Map<String, dynamic>)),
          );
        }

        // Safely parse the 'singles' data
        if (data['singles'] != null) {
          singleUser = List<User>.from(
            (data['singles'] as List).map((json) => User.fromJson(json as Map<String, dynamic>)),
          );
        }

        // Update the observable list with the combined data
        userList.value = singleUser + coupleUser;
        userList.value.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        log(userList.value.toString());

        log("User data retrieved successfully.");
      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        FirebaseUtils.showError(data['message'] ?? "No data found for the given parameters.");
      } else if (response.statusCode == 500) {
        final data = jsonDecode(response.body);
        FirebaseUtils.showError(data['message'] ?? "An internal server error occurred.");
      } else {
        log("Unexpected status code: ${response.statusCode}");
        log('Response body: ${response.body}');
        FirebaseUtils.showError("An unexpected error occurred.");
      }
    } catch (e) {
      log("Error fetching user data: $e");
      FirebaseUtils.showError("An error occurred while fetching user data.");
    } finally {
      isLoading.value = false;
    }
  }
}
class AllUsers {
  String? status;
  List<User>? singles;
  List<User>? couples;

  AllUsers({
    this.status,
    this.singles,
    this.couples,
  });

}
// class Couple {
//   int id;
//   String? fName;
//   int verified;
//   String? age;
//   String? profile;
//   String email;
//   String userType;
//   String? emailVerifiedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String? deviceToken;
//   String isSubscribed;
//   String? lastSeen;
//   String? phone;
//   String? country;
//   String? city;
//   String birthDate;
//   String partner1Name;
//   String partner2Name;
//   String partner1Sex;
//   String partner2Sex;
//   String? userRecentImages;
//   String? visibilityRecentImages;
//   int waitListStatus;
//   int coupleId;
//   int boostStatus;
//   String? boostedAt;
//   int boostCount;
//   int goldenMember;
//   int profileViews;
//   int likes;
//   int activeNow;
//   int isAdmin;
//   CommonCoupleData commonCoupleData;
//   List<String> hobbies;
//   List<String> desires;
//   AdditionalInfo additionalInfo;
//   Reference reference;
//   List<User> matches;
//   List<User> matchedBy;
//   List<User> coupleMatches;
//   List<User> matchedByCouple;
//   List<Club> clubs;
//   List<CoupleRecentImage> coupleRecentImages;
//   List<SingleRecentImage> singleRecentImages;
//   List<Party> parties;
//   List<LikedUserForSingle> likedUserForSingle;
//   List<LikedUserForCouple> likedUserForCouple;
//
//   Couple({
//     required this.id,
//     this.fName,
//     required this.verified,
//     this.age,
//     this.profile,
//     required this.email,
//     required this.userType,
//     this.emailVerifiedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deviceToken,
//     required this.isSubscribed,
//     this.lastSeen,
//     this.phone,
//     this.country,
//     this.city,
//     required this.birthDate,
//     required this.partner1Name,
//     required this.partner2Name,
//     required this.partner1Sex,
//     required this.partner2Sex,
//     this.userRecentImages,
//     this.visibilityRecentImages,
//     required this.waitListStatus,
//     required this.coupleId,
//     required this.boostStatus,
//     this.boostedAt,
//     required this.boostCount,
//     required this.goldenMember,
//     required this.profileViews,
//     required this.likes,
//     required this.activeNow,
//     required this.isAdmin,
//     required this.commonCoupleData,
//     required this.hobbies,
//     required this.desires,
//     required this.additionalInfo,
//     required this.reference,
//     required this.matches,
//     required this.matchedBy,
//     required this.coupleMatches,
//     required this.matchedByCouple,
//     required this.clubs,
//     required this.coupleRecentImages,
//     required this.singleRecentImages,
//     required this.parties,
//     required this.likedUserForSingle,
//     required this.likedUserForCouple,
//   });
//
//   // Factory method for creating an instance from JSON
//   factory Couple.fromJson(Map<String, dynamic> json) {
//     return Couple(
//       id: json['id'],
//       fName: json['f_name'],
//       verified: json['verified'],
//       age: json['age'],
//       profile: json['profile'],
//       email: json['email'],
//       userType: json['user_type'],
//       emailVerifiedAt: json['email_verified_at'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       deviceToken: json['device_token'],
//       isSubscribed: json['is_subscribed'],
//       lastSeen: json['last_seen'],
//       phone: json['phone'],
//       country: json['country'],
//       city: json['city'],
//       birthDate: json['birth_date'],
//       partner1Name: json['Partner_1_name'],
//       partner2Name: json['Partner_2_name'],
//       partner1Sex: json['Partner_1_sex'],
//       partner2Sex: json['Partner_2_sex'],
//       userRecentImages: json['user_recent_images'],
//       visibilityRecentImages: json['visibility_recent_images'],
//       waitListStatus: json['wait_list_status'],
//       coupleId: json['couple_id'],
//       boostStatus: json['boost_status'],
//       boostedAt: json['boosted_at'],
//       boostCount: json['boost_count'],
//       goldenMember: json['golden_member'],
//       profileViews: json['profile_views'],
//       likes: json['likes'],
//       activeNow: json['active_now'],
//       isAdmin: json['is_admin'],
//       commonCoupleData: CommonCoupleData.fromJson(json['common__couple__data']),
//       hobbies: List<String>.from(json['hobbies'] ?? []),
//       desires: List<String>.from(json['desires'] ?? []),
//       additionalInfo: AdditionalInfo.fromJson(json['additional_info']),
//       reference: Reference.fromJson(json['reference']),
//       matches: List<dynamic>.from(json['matches'] ?? []),
//       matchedBy: List<dynamic>.from(json['matched_by'] ?? []),
//       coupleMatches: List<dynamic>.from(json['couple_matches'] ?? []),
//       matchedByCouple: List<dynamic>.from(json['matched_by_couple'] ?? []),
//       clubs: List<dynamic>.from(json['clubs'] ?? []),
//       coupleRecentImages: (json['couple_recent_images'] as List<dynamic>)
//           .map((item) => CoupleRecentImage.fromJson(item))
//           .toList(),
//       singleRecentImages: List<dynamic>.from(json['single_recent_images'] ?? []),
//       parties: List<dynamic>.from(json['parties'] ?? []),
//       likedUserForSingle: List<dynamic>.from(json['liked_user_for_single'] ?? []),
//       likedUserForCouple: (json['liked_user_for_couple'] as List<dynamic>)
//           .map((item) => LikedUserForCouple.fromJson(item))
//           .toList(),
//     );
//   }
//
//   // Method to convert an instance to JSON
// }


// Define AdditionalInfo, Reference, CoupleRecentImage, LikedUserForCouple, and other related classes similarly

