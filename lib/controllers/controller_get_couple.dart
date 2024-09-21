import 'dart:developer';

import 'package:blaxity/models/user.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'authentication_controllers/controller_sign_in_.dart';

class CoupleController extends GetxController {
  RxList<User?> couple = RxList<User?>([]);
  RxList<NetWork?> networks = RxList<NetWork?>([]);
  // RxList<CoupleData?> networks = RxList<c?>([]);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<CoupleData> fetchCoupleDetails(String coupleId) async {
    log("Couple id is $coupleId");
    String? token = await ControllerLogin.getToken();
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('https://blaxity.codergize.com/api/get-single-couple/$coupleId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body);
      final parsedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CoupleData coupleData = CoupleData.fromMap(parsedData);
        return coupleData;
      } else {
        log('Failed to fetch couple details: ${response.body}');
        return CoupleData(status: 'error', data: [], networks: []);

        throw Exception('Failed to fetch couple details');
        errorMessage.value = 'Failed to fetch couple details: ${response.body}';
      }
    } catch (e) {
      log(e.toString());

      errorMessage.value = 'Error occurred: $e';
      return CoupleData(status: 'error', data: [], networks: []);
    } finally {
      isLoading.value = false;
    }
  }
}
 class CoupleData{
  String status;
  List<User> data;
  List<NetWork> networks;

  //<editor-fold desc="Data Methods">
  CoupleData({
    required this.status,
    required this.data,
    required this.networks,
  });

  factory CoupleData.fromMap(Map<String, dynamic> map) {
    return CoupleData(
      status: map['status'] as String,
      data: List<User>.from(map['data'].map((user) => User.fromJson(user))),
      networks: List<NetWork>.from(map['networks'].map((network) => NetWork.fromMap(network))),
    );
  }

  //</editor-fold>
}
class NetWork{
  int id;
  String f_name;
  String user_type;

//<editor-fold desc="Data Methods">
  NetWork({
    required this.id,
    required this.f_name,
    required this.user_type,
  });



  factory NetWork.fromMap(Map<String, dynamic> map) {
    return NetWork(
      id: map['id'] as int,
      f_name: map['f_name'] as String,
      user_type: map['user_type'] as String,
    );
  }

//</editor-fold>
}
