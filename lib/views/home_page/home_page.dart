import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/controllers/users_controllers/controller_get_user_all_data.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_chat.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../home_page/home_layouts/layout_blog.dart';
import 'home_layouts/layout_home.dart';
import 'home_layouts/layout_profile.dart';


class HomeScreen extends StatelessWidget {


  LinearGradient _iconGradient = const LinearGradient(
    colors: [
      Color(0xFFC19B61),
      Color(0x80B48650), // 50% opacity
      Color(0xFF9C5F30),
    ],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    ControllerGetUserAllData controllerGetUserAllData = Get.put(ControllerGetUserAllData());
    controllerGetUserAllData.getUserData();
    ControllerHome controllerHome = Get.put(ControllerHome());
    controllerHome.fetchUserInfo();
    final List<Widget> _pages = [
      LayoutHome(),
      LayoutEvent(),
      LayoutBlog(),
      LayoutChat(),
      LayoutProfile(),
    ];
    final BottomNavController bottomNavController = Get.put(BottomNavController());

    return Obx(
          () => Scaffold(
        body:(controllerHome.user.value==null)? Center(child: CircularProgressIndicator()): _pages[bottomNavController.selectedIndex.value],
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


class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
