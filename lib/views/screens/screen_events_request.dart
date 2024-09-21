import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/models/event.dart';
import 'package:blaxity/models/event_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../layouts/item_event/event_button/item_event.dart';
import '../layouts/item_event_request_couple.dart';

class ScreenEventsRequests extends StatefulWidget {
  Event event;

  @override
  State<ScreenEventsRequests> createState() => _ScreenEventsRequestsState();

  ScreenEventsRequests({
    required this.event,
  });
}

class _ScreenEventsRequestsState extends State<ScreenEventsRequests> {
  // int _selectedButtonIndex = -1;
  // //
  // void _onButtonTap(int index) {
  //   setState(() {
  //     _selectedButtonIndex = index;
  //   });
  // }

  EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    controller.fetchEventRequests(widget.event.id!);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Image.asset(
            height: Get.height * .23,
            "assets/images/image_profile_appBar.png",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height*.3,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Color(0xFF1D1D1D),
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: NetworkImage(
                            APiEndPoint.imageUrl+widget.event.image!),
                        fit: BoxFit.cover
                    )
                ),),
              Text(
                widget.event.title!, style: AppFonts.subscriptionBlaxityGold,),
              Text("Request", style: AppFonts.subscriptionTitle,).marginOnly(
                top: 30.sp,
              ),
              Obx(() {
                return (controller.isLoading.value)?Center(child: CircularProgressIndicator()):ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    EventRequest eventRequest=controller.eventRequests[index];
                    return ItemEventCouple(eventRequest: eventRequest, event: widget.event,);
                  },
                itemCount: controller.eventRequests.length,
                );
              })
            ],
          ).marginSymmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
        ),
      ),
    );
  }
}
