import 'dart:async';
import 'dart:developer';

import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_chat.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_event.dart';
import 'package:blaxity/views/layouts/layout_club_home.dart';
import 'package:blaxity/views/layouts/layout_club_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../constants/ApiEndPoint.dart';
import '../home_page/home_layouts/layout_blog.dart';
import '../layouts/layout_event_time_line.dart';


class ScreenClubsHome extends StatefulWidget {


  @override
  State<ScreenClubsHome> createState() => _ScreenClubsHomeState();
}

class _ScreenClubsHomeState extends State<ScreenClubsHome>  with WidgetsBindingObserver{

  ControllerHome _controllerHome = Get.put(ControllerHome());
  LinearGradient _iconGradient = const LinearGradient(
    colors: [
      Color(0xFFC19B61),
      Color(0x80B48650), // 50% opacity
      Color(0xFF9C5F30),
    ],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );
  Timer? _lastSeenTimer;

  @override
  void initState() {
  WidgetsBinding.instance.addObserver(this);
  _startLastSeenTimer();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopLastSeenTimer();
    super.dispose();
  }

  void _startLastSeenTimer() {
    _lastSeenTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      updateLastSeen();
      updateActive();
    });
  }

  void _stopLastSeenTimer() {
    _lastSeenTimer?.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startLastSeenTimer();
    } else if (state == AppLifecycleState.hidden) {
      _startLastSeenTimer();
    } else if (state == AppLifecycleState.inactive) {
      _startLastSeenTimer();
    } else if (state == AppLifecycleState.paused) {
      _startLastSeenTimer();
    } else {
      _stopLastSeenTimer();
    }
  }

  Future<void> updateLastSeen() async {
    String? accessToken = await ControllerLogin.getToken();
     String endpoint =
        "${APiEndPoint.baseUrl}/user/last-seen";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    Map<String, String> payload = {
      'last_seen': formattedDate,
    };

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        body: payload,
      );
      // log(response.body);
      if (response.statusCode != 200) {
        log('Failed to update Last Seen: ${response.statusCode}');
      } else {
        log('Last Seen updated successfully');
      }
    } catch (e) {
      log('Error updating Last Seen: $e');
    }
  }
  Future<void> updateActive() async {
    String? accessToken = await ControllerLogin.getToken();
     String endpoint =
        "${APiEndPoint.baseUrl}/user/update-active-status";

    Map<String, String> payload = {
      'active_now': "1",
    };

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        body: payload,
      );
      // log(response.body);
      if (response.statusCode != 200) {
        log('Failed to update Active Status: ${response.statusCode}');
      } else {
        log('Active Status updated successfully');
      }
    } catch (e) {
      log('Error updating Active Status: $e');
    }
  }
  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      LayoutClubHome(),
      LayoutEventTimeLine(),
      LayoutBlog(),
      LayoutChat(),
      LayoutClubProfile(),
    ];
    final BottomNavClubController bottomNavController = Get.put(BottomNavClubController());

    return Obx(
          () => Scaffold(
        body: (_controllerHome.user.value==null)?Center(child: CircularProgressIndicator()):_pages[bottomNavController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: bottomNavController.changeIndex,
          items: [
            _buildNavItem('home', bottomNavController.selectedIndex.value == 0),
            _buildNavItem('event', bottomNavController.selectedIndex.value == 1),
            _buildNavItem('blog', bottomNavController.selectedIndex.value == 2),
            _buildNavItem('message', bottomNavController.selectedIndex.value == 3),
            _buildNavItem('profile', bottomNavController.selectedIndex.value == 4),
          ],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconName, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: isSelected
            ? BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF202020),
        )
            : null,
        padding: EdgeInsets.all(8.0),
        child: isSelected
            ? ShaderMask(
          shaderCallback: (Rect bounds) {
            return _iconGradient.createShader(bounds);
          },
          child: SvgPicture.asset(
            'assets/icons/$iconName.svg',
            color: Colors.white,
          ),
        )
            : SvgPicture.asset(
          'assets/icons/$iconName.svg',
          color: Color(0xFF6D7076), // Unselected icon color
        ),
      ),
      label: '', // No label needed
    );
  }}


class BottomNavClubController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
