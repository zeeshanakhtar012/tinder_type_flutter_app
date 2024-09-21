import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_blog.dart';
import 'package:blaxity/views/layouts/item_club_home_event.dart';
import 'package:blaxity/views/screens/screen_individual/screen_create_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/custom_toggle_switch.dart';
import '../../controllers/controller_home.dart';
import '../../widgets/custom_drawer.dart';
import '../screens/screen_filter_event.dart';
import '../screens/screen_group_hub.dart';
import '../screens/screen_blog_search.dart';
import 'item_event/item_layout_event.dart';


class LayoutEventTimeLine extends StatefulWidget {
  const LayoutEventTimeLine({super.key});

  @override
  State<LayoutEventTimeLine> createState() => _LayoutEventTimeLineState();
}

class _LayoutEventTimeLineState extends State<LayoutEventTimeLine> {
  // bool _isExpanded = false;
  int _selectedIndex = 0;
  // int _selectedButtonIndex = -1;
  // double _sliderValue = 0.0;
  // int _selectedToggleIndex = 1;
  //
  // void _onToggle(int index) {
  //   setState(() {
  //     _selectedToggleIndex = index;
  //   });
  //   print('Switched to: $index');
  // }
  //
  // void _onButtonTap(int index) {
  //   setState(() {
  //     _selectedButtonIndex = index;
  //     // _showBottomSheetFilter(context);
  //   });
  // }
  //
  // void _onAvatarTap(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //     if (_selectedIndex == 0)
  //       _showBottomSheet(context);
  //   });
  // }
  //
  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(20.sp),
  //         height: 150.h,
  //         color: Colors.black,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text("Block Sandy", style: TextStyle(
  //                   color: Colors.red,
  //                 ),),
  //                 Icon(CupertinoIcons.nosign, color: Colors.white,),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text("Report user", style: TextStyle(
  //                   color: Colors.red,
  //                 ),),
  //                 Icon(CupertinoIcons.exclamationmark_octagon,
  //                   color: Colors.white,),
  //               ],
  //             ).paddingOnly(
  //               top: 20.sp,
  //             ),
  //           ],
  //         ).marginSymmetric(
  //           horizontal: 15.sp,
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showBottomSheetFilter(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(20.sp),
  //         height: Get.height * 0.55,
  //         color: Colors.black,
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 height: 3.h,
  //                 width: 70.w,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "Location",
  //                   style: TextStyle(fontSize: 18.sp, color: Colors.white),
  //                 ),
  //               ).marginOnly(
  //                 top: 20.sp,
  //
  //               ),
  //               Container(
  //                 height: 50.h,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   border: Border.all(
  //                     color: Color(0xFFA7713F),
  //                   ),
  //                 ),
  //                 child: TextField(
  //                   decoration: InputDecoration(
  //                     contentPadding: EdgeInsets.all(6.0),
  //                     hintText: 'Dubai',
  //                     suffixIcon: Icon(Icons.location_on_outlined),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   onChanged: (value) {},
  //                   onSubmitted: (value) {},
  //                 ),
  //               ).marginOnly(
  //                 top: 10.sp,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text("Distance Preference", style: TextStyle(color: Colors.white)),
  //                   Text("${_sliderValue.round()} km", style: TextStyle(color: Colors.white)),
  //                 ],
  //               ).marginOnly(
  //                 top: 50.sp,
  //               ),
  //               SliderTheme(
  //                 data: SliderTheme.of(context).copyWith(
  //                   activeTrackColor: Color(0xFFA7713F),
  //                   inactiveTrackColor: Colors.grey,
  //                   trackHeight: 4.0,
  //                   thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
  //                   overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
  //                   valueIndicatorTextStyle: TextStyle(color: Colors.white, fontSize: 9),
  //                   showValueIndicator: ShowValueIndicator.always,
  //                 ),
  //                 child: Slider(
  //                   value: _sliderValue,
  //                   min: 0,
  //                   max: 100,
  //                   divisions: 100,
  //                   label: _sliderValue.round().toString(),
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _sliderValue = value;
  //                     });
  //                   },
  //                 ),
  //               )..marginOnly(
  //                 top: 20.sp,
  //               ),
  //               CustomToggleSwitch(
  //                 labels: ['America', 'London', 'Asia'],
  //                 onToggle: _onToggle,
  //                 selectedIndex: _selectedToggleIndex,
  //               ).marginOnly(
  //                 top: 50.sp,
  //               ),
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text("Age Preference", style: TextStyle(color: Colors.white)).marginOnly(
  //                   top: 50.sp,
  //                 ),
  //               ),
  //               SliderTheme(
  //                 data: SliderTheme.of(context).copyWith(
  //                   activeTrackColor: Color(0xFFA7713F),
  //                   inactiveTrackColor: Colors.grey,
  //                   trackHeight: 4.0,
  //                   thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
  //                   overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
  //                   valueIndicatorTextStyle: TextStyle(color: Colors.white, fontSize: 9),
  //                   showValueIndicator: ShowValueIndicator.always,
  //                 ),
  //                 child: Slider.adaptive(
  //                   value: _sliderValue,
  //                   min: 0,
  //                   max: 100,
  //                   divisions: 100,
  //                   label: _sliderValue.round().toString(),
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _sliderValue = value;
  //                     });
  //                   },
  //                 ),
  //               )..marginOnly(
  //                 top: 50.sp,
  //               ),
  //             ],
  //           ).marginSymmetric(
  //             horizontal: 15.sp,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  // void _toggleExpand() {
  //   setState(() {
  //     _isExpanded = !_isExpanded;
  //   });
  // }
  List<String> labels = ['My Events', 'Completed', 'Upcoming'];
  EventController eventController = Get.put(EventController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(ScreenCreateEventIndividual(user: Get
                  .find<ControllerHome>()
                  .user
                  .value!
                  .user, isHome: true,));
            },
            icon: SvgPicture.asset("assets/icons/create-event.svg"),
          ),
          IconButton(
            onPressed: () {
              Get.to(ScreenGroupHub());
            },
            icon: SvgPicture.asset("assets/icons/group.svg"),
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: SvgPicture.asset("assets/icons/notification.svg"),
          ),


        ],
      ),

      body: RefreshIndicator(
        color: AppColors.appColor,
        onRefresh: () {

          return eventController.fetchMyEvents();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                gradient: AppColors.buttonColor,
                text: "Your Event Timeline",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Upcoming and Past",
                style: TextStyle(
                  color: Color(0xFFD0D0D0),
                  fontSize: 14.sp,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 47.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff353535),
                          )
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          eventController.fetchMyEvents(search: value);
                        },
                        onSubmitted: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () {
                      Get.to(ScreenFilterEvent());
                    },
                    child: Container(
                      height: 47.h,
                      width: 70.w,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff353535),
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: SvgPicture.asset("assets/icons/filter.svg"),
                    ),
                  ),
                ],
              ).marginSymmetric(
                vertical: 10.h,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  height: 36.h,
                  width: 250.w,
                  decoration: BoxDecoration(
                    color: Color(0xFf353535),
                    borderRadius: BorderRadius.circular(60.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(labels.length, (index) {
                      bool isSelected = index == _selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          if (_selectedIndex == 1) {
                            eventController.fetchMyEvents(completed: 0);
                          } else if (_selectedIndex == 2) {
                            eventController.fetchMyEvents(upcoming: 1);
                          } else {
                            eventController.fetchMyEvents();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          decoration: isSelected
                              ? BoxDecoration(
                            gradient: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(60.r),
                          )
                              : null,
                          child: Center(
                            child: Text(
                              labels[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              // Remove Expanded and wrap with Container or SizedBox
              Obx(() {
                return eventController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : eventController.myEvents.isEmpty
                    ? Center(child: Text('No events found'))
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: eventController.myEvents.length,
                      itemBuilder: (BuildContext context, int index) {
                        var event = eventController.myEvents[index];
                        return ItemClubHomeEvent(
                          event: event,
                          isMyEvent: true,
                        );
                      },
                    );
              }),
            ],
          ),
        ).marginSymmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
      ),
    );
  }

// Widget _buildFilterButton(String text) {
//   return Container(
//     constraints: BoxConstraints(
//       minWidth: 100.w,
//       minHeight: 36.h,
//     ),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: Color(0xFFA7713F),
//       ),
//       borderRadius: BorderRadius.circular(60),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (text == 'Filter') Icon(Icons.filter_list, color: Colors.white),
//         Text(text),
//         Icon(Icons.keyboard_arrow_down, color: Colors.white),
//       ],
//     ),
//   );
// }
}
