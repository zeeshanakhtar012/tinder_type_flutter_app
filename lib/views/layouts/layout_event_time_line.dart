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


class LayoutEventTimeLine extends StatefulWidget {
  const LayoutEventTimeLine({super.key});

  @override
  State<LayoutEventTimeLine> createState() => _LayoutEventTimeLineState();
}

class _LayoutEventTimeLineState extends State<LayoutEventTimeLine> {
  int _selectedIndex = 0;
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
