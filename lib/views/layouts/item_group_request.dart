import 'package:blaxity/constants/controller_get_groups.dart';
import 'package:blaxity/constants/extensions/time_ago.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/models/event.dart';
import 'package:blaxity/models/event_request.dart';
import 'package:blaxity/models/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/location_utils.dart';
import '../../controllers/controller_home.dart';
import 'item_event/event_button/item_event.dart';

class ItemGroupRequest extends StatelessWidget {
  // EventRequest eventRequest;
  JoinRequest jointRequest;
  Group group;
  GroupController groupController = Get.put(GroupController());
RxBool loading=RxBool(false);
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 48.59.h,
              width: 48.59.w,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                // gradient: AppColors.buttonColor,
                border: Border.all(
                  width: 4.w,
                  color: Color(0xFFA7713F),
                ),
                shape: BoxShape.circle,
              ),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColors.buttonColor.createShader(bounds);
                    },
                    child: jointRequest.user.userType=="couple"?Icon(
                      Icons.group,
                      // size: 15.h,
                    ):Icon(
                      CupertinoIcons.person_fill,
                    ),
                  ),
                  Text((jointRequest.user.userType=="couple")?"${jointRequest.user.partner1Name![0].toUpperCase()}&${jointRequest.user.partner2Name![0].toUpperCase()}" : jointRequest.user.fName![0].toUpperCase(),  style: TextStyle(
                    fontSize: 6.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${getRelativeTimeFromDateString(jointRequest.createdAt.toIso8601String())}",
                  style: TextStyle(
                    fontSize: 8.sp,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Text((jointRequest.user.userType=="couple")?"${jointRequest.user.partner1Name!}&${jointRequest.user.partner2Name!}" : jointRequest.user.fName!, style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),),
                    Icon(
                      size: 8.sp,
                      CupertinoIcons.location_solid,
                      color: Color(0xFFA7713F),).marginOnly(
                      left: 5.sp,
                    ),
                    Text("${getDistance(Get
                        .find<ControllerHome>()
                        .currentPosition
                        .value!
                        .latitude, Get
                        .find<ControllerHome>()
                        .currentPosition
                        .value!
                        .longitude, double.tryParse(
                        jointRequest.user.reference == null ? "0.0" : jointRequest.user
                            .reference!.latitude ?? "0.0") ?? 0,
                        double.tryParse(
                            jointRequest.user.reference == null ? "0.0" : jointRequest.user
                                .reference!.longitude ?? "0.0") ?? 0)
                        .toStringAsFixed(1)} km",
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text("Requested to join your event"),
              ],
            ).marginOnly(
              left: 6.sp,
            ),
            Spacer(),
            IconButton(onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios,
                  color: Colors.white,))
          ],
        ).marginOnly(
          top: 20.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return SelectableButton(
                loading:loading.value,
                text: 'Accept',
                isSelected: false,
                onTap: () async {
                  loading.value=true;
                 await  groupController.acceptGroupRequest(
                       group.id,jointRequest.userId);
                  loading.value=false;
                },
              );
            }),
            Obx(() {
              return SelectableButton(
                loading: groupController.isRejecting.value,

                text: 'Decline',
                isSelected: false,
                onTap: () {
                  // groupController.r(
                  //     event.id!, eventRequest.id);
                },
              );
            }).marginOnly(
              left: 15.sp,
            ),
            SelectableButton(
              text: 'Message',
              isSelected: false,
              onTap: () {},
            ).marginOnly(
              left: 15.sp,
            ),
          ],
        ).marginOnly(
          top: 20.sp,
        ),
        // Add other content here
      ],
    );
  }

  ItemGroupRequest({
    required this.group,
    required this.jointRequest,
  });
}
