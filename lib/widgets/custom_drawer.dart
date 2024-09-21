import 'package:blaxity/constants/extensions/time_ago.dart';
import 'package:blaxity/controllers/notification_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../views/layouts/item_event/event_button/item_event.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int _selectedButtonIndex = -1;

  void _onButtonTap(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    NotificationController notificationController =
        Get.put(NotificationController());
    notificationController.fetchNotifications();
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height * .12,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            topLeft: Radius.circular(60),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(
                   'Notifications',
                  style: AppFonts.homeScreenText,
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  color: Color(0xFFA7713F),
                  onRefresh: () async {
                    await   notificationController.fetchNotifications();
                  },
                  child: (notificationController.isLoading.value)
                      ? Center(child: CircularProgressIndicator(
                    color: Color(0xFFA7713F),
                  ))
                      : notificationController.notifications.isEmpty
                          ? Center(
                              child: Text(
                                'No Notifications',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  notificationController.notifications.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                    notificationController
                                        .notifications[index].title
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    notificationController
                                        .notifications[index].body
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Text(
                                    getRelativeTimeFromDateString(notificationController.notifications[index].createdAt.toString()),
                                  ),
                                );
                              },
                            ),
                );
              }),
            )
            // Add other content here
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 10.sp,
        ),
      ).marginOnly(
        top: 70.sp,
      ),
    );
  }
}
