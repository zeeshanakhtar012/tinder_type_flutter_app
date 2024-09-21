import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../constants/ApiEndPoint.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import 'event_button/item_event.dart';

class ItemLayoutEvent extends StatefulWidget {
  String eventOwnerName;
  String eventName;
  String eventType;
  String eventLocation;
  String eventTime;
  String eventMember;
  String eventDate;
  String eventImageUrl;
  VoidCallback? onTap;
  ItemLayoutEvent({
    required this.eventOwnerName,
    required this.eventName,
    required this.eventLocation,
    required this.eventTime,
    required this.eventMember,
    required this.eventDate,
    required this.eventType,
    required this.eventImageUrl,
    this.onTap,
    super.key});

  @override
  State<ItemLayoutEvent> createState() => _ItemLayoutEventState();
}

class _ItemLayoutEventState extends State<ItemLayoutEvent> {
  int _selectedButtonIndex = -1;
  void _onButtonTap(int index) {
    setState(() {
      _selectedButtonIndex = index;
      // _showBottomSheetFilter(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height*1;
    final width = MediaQuery.sizeOf(context).width*1;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.all(5.sp,),
        padding: EdgeInsets.all(8.0),
        width: width,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(
        //     color: Color(0xFFA7713F),
        //   ),
        // ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/icon_eventSection_svg.svg",
                ),
                Text("Events", style: AppFonts.subscriptionTitle,).marginOnly(
                  left: 10.sp,
                ),
                Spacer(),
                SvgPicture.asset(
                  "assets/icons/icon_share.svg",
                ),
              ],
            ),
            Container(
              height: height * .25,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.33),
                // border: Border.all(
                //   color: Color(0xFFA7713F),
                // ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      "${APiEndPoint.imageUrl+widget.eventImageUrl}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          height: 30.h,
                          width: 104.w,
                          decoration: BoxDecoration(
                            gradient: AppColors.buttonColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Public",
                              style: AppFonts.subscriptionDuration,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).marginOnly(
                top: 10.sp,
                bottom: 15.sp
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              // decoration: BoxDecoration(
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(.3),
              //         blurStyle: BlurStyle.inner,
              //       )
              //     ]
              // ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: AppFonts.subscriptionSubtitle,
                        "${widget.eventName}"),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        height: 15.h,
                        width: 15.w,
                        "assets/icons/icon_profile_svg.svg",
                      ).marginSymmetric(
                          vertical: 5.h,
                          horizontal: 5.w
                      ),
                      Text( '${widget.eventOwnerName}',
                        style: AppFonts.subtitle,
                      ).marginOnly(
                        left: 5.sp,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/icon_clock.svg"),
                          Text(
                              style: AppFonts.subtitle,
                              "${widget.eventTime}").marginOnly(
                            left: 5.sp,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/icon_location.svg"),
                            Expanded(
                              child: Text(
                                      style: AppFonts.subtitle,
                                      "${widget.eventLocation}")
                                  .marginOnly(
                                left: 6.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset("assets/icons/icon_member.svg"),
                          Text(
                              style: AppFonts.subtitle,
                              "${widget.eventMember} members").marginOnly(
                            left: 6.sp,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/icon_calneder.svg"),
                      Text(
                          style: AppFonts.subtitle,
                          "${widget.eventDate}"
                      ).marginOnly(
                        left: 6.sp,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 65.h,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurStyle: BlurStyle.inner,
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableButton(
                    text: 'Organizer',
                    isSelected: _selectedButtonIndex == 0,
                    onTap: () => _onButtonTap(0),
                  ),
                  SelectableButton(
                    text: 'Attend',
                    isSelected: _selectedButtonIndex == 1,
                    onTap: () => _onButtonTap(1),
                  ).marginSymmetric(
                    horizontal: 10.sp,
                  ),
                  SelectableButton(
                    text: 'Like',
                    isSelected: _selectedButtonIndex == 1,
                    onTap: () => _onButtonTap(1),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: InkWell(
            //     onTap: _toggleExpand,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.grey.withOpacity(.3),
            //       child:  SvgPicture.asset(
            //           "assets/icons/icon_down.svg"),
            //     ),
            //   ),
            // ),
            // if (_isExpanded) ...[
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       GestureDetector(
            //         onTap: () => _onAvatarTap(0),
            //         child: CircleAvatar(
            //           backgroundColor: _selectedIndex == 0
            //               ? Color(0xFFA7713F)
            //               : Colors.grey.withOpacity(0.3),
            //           child: Icon(Icons.close, color: Colors.white),
            //         ),
            //       ),
            //       SizedBox(width: 10.w),
            //       GestureDetector(
            //         onTap: () => _onAvatarTap(1),
            //         child: CircleAvatar(
            //           backgroundColor: _selectedIndex == 1
            //               ? Color(0xFFA7713F)
            //               : Colors.grey.withOpacity(0.3),
            //           child: SvgPicture.asset(
            //             "assets/icons/icon_flah.svg",
            //           ).marginSymmetric(horizontal: 5.sp),
            //         ),
            //       ),
            //       SizedBox(width: 10),
            //       GestureDetector(
            //         onTap: () => _onAvatarTap(2),
            //         child: CircleAvatar(
            //           backgroundColor: _selectedIndex == 2
            //               ? Color(0xFFA7713F)
            //               : Colors.grey.withOpacity(0.3),
            //           child: SvgPicture.asset(
            //             "assets/icons/icon_chat.svg",
            //           ).marginSymmetric(horizontal: 5.sp),
            //         ),
            //       ),
            //       SizedBox(width: 10),
            //       GestureDetector(
            //         onTap: () => _onAvatarTap(3),
            //         child: CircleAvatar(
            //           backgroundColor: _selectedIndex == 3
            //               ? Color(0xFFA7713F)
            //               : Colors.grey.withOpacity(0.3),
            //           child: SvgPicture.asset(
            //             "assets/icons/icon_heart.svg",
            //           ).marginSymmetric(horizontal: 5.sp),
            //         ),
            //       ),
            //     ],
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}
