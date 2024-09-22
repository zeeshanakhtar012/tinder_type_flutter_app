import 'package:blaxity/models/event_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/fonts.dart';
import '../layouts/item_event_profile.dart';

class ScreenViewEvents extends StatelessWidget {
 List<EventAction> eventActions;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Events",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GradientText(text:
            "Joined Events",
              style: AppFonts.titleLogin,
            ),

            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child:(eventActions.isNotEmpty)? GridView.builder(
                itemCount: eventActions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
              padding: EdgeInsets.all(10.h), itemBuilder: (BuildContext context, int index) {
                return ItemUserEventProfile(
                                            event: eventActions[index],
                                          );
                },

              ):Center(child: Text("No Events"),),
            )


          ],
        ).marginSymmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
      ),
    );
  }

 ScreenViewEvents({
    required this.eventActions,
  });
}
