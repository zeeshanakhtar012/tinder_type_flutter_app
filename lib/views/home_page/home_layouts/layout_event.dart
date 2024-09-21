import 'package:blaxity/controllers/SettingController.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/controllers/event_controllers/create_event_controller.dart';
import 'package:blaxity/views/layouts/item_club_home_event.dart';
import 'package:blaxity/views/screens/screen_individual/screen_create_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_check_box.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';
import '../../screens/personal_information_screens_couple/screen_about_details_page7.dart';
import '../../screens/screen_filter_event.dart';
import '../../screens/screen_go_out_filter.dart';
import '../../screens/screen_group_hub.dart';

class LayoutEvent extends StatefulWidget {
  LayoutEvent({super.key});

  @override
  State<LayoutEvent> createState() => _LayoutEventState();
}

class _LayoutEventState extends State<LayoutEvent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  List<String> labels = ['Events', 'Organizer', 'Clubs'];

  @override
  Widget build(BuildContext context) {
    EventController eventController = Get.find<EventController>();
    eventController.fetchEvents();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ScreenGroupHub());
              },
              icon: Icon(
                CupertinoIcons.globe,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
        centerTitle: true,
        title: Image.asset(
          height: Get.height * .23,
          "assets/images/image_profile_appBar.png",
        ),
      ),
      body:(Get.find<SettingController>().isShowEvent.value == true)?Center(child: Container(
        height: 150.h,
          alignment: Alignment.center,
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(
            color: AppColors.chatColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xFFA7713F),
              width: 2,
            )
          ),
          child: GradientText(text:"Coming Soon",style: TextStyle(color: Colors.white,fontSize: 20.sp
          ,fontWeight: FontWeight.w600),))): RefreshIndicator(
        color:  Color(0xFFA7713F),
        onRefresh: () async {
          await eventController.fetchEvents();
        },
        child: ListView(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          primary: true,
          children: [
            GradientText(
              text: 'Event Explorer',
              style: AppFonts.titleLogin,
              gradient: AppColors.buttonColor,
            ),
            Text(
              "Discover and Filter Events.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      onChanged: (value) async {
                        await eventController.fetchEvents(search: value);
                      },
                      onSubmitted: (value) {},
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      // Allows the bottom sheet to cover the full screen
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .9,
                            child: FilterEvent(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 44.h,
                    width: 65.w,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff353535),
                          // blurRadius: 2,
                          spreadRadius: 2,
                          // offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: SvgPicture.asset("assets/icons/filter.svg"),
                  ),
                ),
              ],
            ).marginOnly(top: 10.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(ScreenFilterEvent());
                      },
                      child: _buildFilterButton('Filter')),
                  GestureDetector(
                      onTap: () {
                        Get.to(ScreenGoOut());
                      },
                      child: _buildFilterButton('Date').marginOnly(left: 6.sp)),
                  _buildFilterButton('Price').marginOnly(left: 6.sp),
                  _buildFilterButton('Categories').marginOnly(left: 6.sp),
                ],
              ).marginOnly(
                top: 20.sp,
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              height: 36.h,
              width: 250.w,
              decoration: BoxDecoration(
                color: Color(0xFF353535),
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
                        eventController.fetchEvents(organization: 0);
                      } else if (_selectedIndex == 2) {
                        eventController.fetchEvents(club: 1);
                      } else {
                        eventController.fetchEvents();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
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
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
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
          Obx(() {
            return (eventController.isLoading.value)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFA26837),
                    ),
                  )
                : (eventController.events.isEmpty)
                    ? Center(
                        child: Text('No events found'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: eventController.events.length,
                        shrinkWrap: true,
                        // reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var event = eventController.events[index];
                          return ItemClubHomeEvent(
                              isMyEvent: false, event: event);
                        },
                      );
          })
          ],
        ).paddingSymmetric(
          horizontal: 15.sp,
          vertical: 10.sp,
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 100.w,
        minHeight: 36.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFA7713F),
        ),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (text == 'Filter') Icon(Icons.filter_list, color: Colors.white),
          Text(text),
          Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
      ),
    );
  }
}

class FilterEvent extends StatelessWidget {
  ControllerCreateEvent controllerCreateEvent =
      Get.put(ControllerCreateEvent());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientText(
                  text: "Event Filter Option",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ).marginSymmetric(vertical: 7.h),
          MyInputField(
            readOnly: true,
            hint: "Select Day",
            controller: controllerCreateEvent.eventDateController,
            suffix: InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Color(0xFFA7713F),
                          // header background color
                          onPrimary: Colors.black,
                          // header text color
                          onSurface: Colors.black, // body text color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != DateTime.now()) {
                  controllerCreateEvent.eventDateController.text =
                      "${picked.toLocal()}".split(' ')[0];
                }
              },
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppColors.buttonColor.createShader(bounds);
                },
                child: Icon(
                  Icons.calendar_month,
                  size: 24,
                ),
              ),
            ),
          ),
          GradientDivider(
            gradient: AppColors.buttonColor,
            width: Get.width,
            thickness: .3,
          ),
          MyInputField(
            hint: "Select Time",
            controller: controllerCreateEvent.eventTimeController,
            readOnly: true,
            suffix: InkWell(
              onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value) {
                  controllerCreateEvent.eventTimeController.text =
                      value!.format(context).toString();
                });
              },
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppColors.buttonColor.createShader(bounds);
                },
                child: Icon(
                  Icons.watch_later_outlined,
                  size: 24,
                ),
              ),
            ),
          ),
          GradientDivider(
            gradient: AppColors.buttonColor,
            width: Get.width,
            thickness: .3,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GradientText(
                text: "Type of Party",
                style: AppFonts.subscriptionTitle,
                gradient: AppColors.buttonColor),
          ).marginSymmetric(
            vertical: 10.sp,
          ),
          Wrap(
            children: List.generate(controllerCreateEvent.optionsParties.length,
                (value) {
              return Obx(() {
                return IntrinsicWidth(
                  child: buildSelectOneOption(
                      controllerCreateEvent.optionsParties[value], () {
                    controllerCreateEvent.selectPartyType.value =
                        controllerCreateEvent.optionsParties[value];
                  },
                      controllerCreateEvent.selectPartyType.value ==
                          controllerCreateEvent.optionsParties[value]),
                );
              });
            }),
          ),
          Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(
                      text: "Set Your Event Privacy",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor))
              .marginOnly(
            top: 6.sp,
          ),
          Obx(() {
            return CustomCheckbox(
              isSelected: controllerCreateEvent.eventPrivacy.value == 'Public',
              onChanged: (isSelected) {
                if (isSelected) {
                  controllerCreateEvent.eventPrivacy.value = 'Public';
                } else {
                  controllerCreateEvent.eventPrivacy.value = '';
                }
              },
              titleText: "Public",
            );
          }),
          Obx(() {
            return CustomCheckbox(
              isSelected: controllerCreateEvent.eventPrivacy.value == 'Private',
              onChanged: (isSelected) {
                if (isSelected) {
                  controllerCreateEvent.eventPrivacy.value = 'Private';
                } else {
                  controllerCreateEvent.eventPrivacy.value = '';
                }
              },
              titleText: "Private",
            );
          }).marginSymmetric(vertical: 8.h),
          GradientDivider(
            gradient: AppColors.buttonColor,
            width: Get.width,
            thickness: .3,
          ),
          Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(
                      text: "Set Your Event Pricing",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor))
              .marginOnly(
            top: 15.sp,
          ),
          Obx(() {
            return CustomCheckbox(
              isSelected: controllerCreateEvent.eventPricing.value == 'Free',
              onChanged: (isSelected) {
                if (isSelected) {
                  controllerCreateEvent.eventPricing.value = 'Free';
                } else {
                  controllerCreateEvent.eventPricing.value = '';
                }
              },
              titleText: "Free",
            );
          }),
          Obx(() {
            return CustomCheckbox(
              isSelected: controllerCreateEvent.eventPricing.value == 'Paid',
              onChanged: (isSelected) {
                if (isSelected) {
                  controllerCreateEvent.eventPricing.value = 'Paid';
                } else {
                  controllerCreateEvent.eventPricing.value = '';
                }
              },
              titleText: "Paid",
            );
          }).marginSymmetric(vertical: 8.h),
          GradientDivider(
            gradient: AppColors.buttonColor,
            width: Get.width,
            thickness: .3,
          ),
          Obx(() {
            return (controllerCreateEvent.eventPricing.value == 'Paid')
                ? Column(
                    children: [
                      MyInputField(
                        hint: "Enter Price",
                        controller:
                            controllerCreateEvent.entrancePriceController,
                        keyboardType: TextInputType.number,
                      ),
                      GradientDivider(
                        gradient: AppColors.buttonColor,
                        width: Get.width,
                        thickness: .3,
                      ),
                    ],
                  )
                : SizedBox();
          }),
          Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(
                      text: "Event Capacity Options",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor))
              .marginOnly(
            top: 15.sp,
          ),
          Obx(() {
            return CustomCheckbox(
              isSelected: controllerCreateEvent.capacity.value == 'Limited',
              onChanged: (isSelected) {
                if (isSelected) {
                  controllerCreateEvent.capacity.value = 'Limited';
                  controllerCreateEvent.capacityLimited.value = true;
                } else {
                  controllerCreateEvent.capacityLimited.value = false;
                  controllerCreateEvent.capacity.value = '';
                }
              },
              titleText: "Limited",
            );
          }),
          Obx(() {
            return CustomCheckbox(
              isSelected: controllerCreateEvent.capacity.value == 'Not Limited',
              onChanged: (isSelected) {
                if (isSelected) {
                  controllerCreateEvent.capacity.value = 'Not Limited';
                  controllerCreateEvent.capacityLimited.value = false;
                } else {
                  controllerCreateEvent.capacity.value = '';
                  controllerCreateEvent.capacityLimited.value = false;
                }
              },
              titleText: "Not Limited",
            );
          }).marginSymmetric(vertical: 8.h),
          GradientDivider(
            gradient: AppColors.buttonColor,
            width: Get.width,
            thickness: .3,
          ),
          Obx(() {
            return (controllerCreateEvent.capacityLimited.value == true)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "If Limited: Set Attendee Limit",
                        style: AppFonts.subtitleImagePickerButtonColor,
                      ).marginOnly(
                        top: 10.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '${controllerCreateEvent.attendeeLimit.value}',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: controllerCreateEvent.increment,
                                child: Icon(
                                  size: 18.sp,
                                  Icons.keyboard_arrow_up,
                                  color: Color(0xFFB48650),
                                ),
                              ),
                              InkWell(
                                onTap: controllerCreateEvent.decrement,
                                child: Icon(
                                  size: 18.sp,
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFFB48650),
                                ),
                              ),
                            ],
                          ).marginOnly(
                            left: 5.sp,
                          ),
                        ],
                      ).marginOnly(
                        top: 5.sp,
                      ),
                    ],
                  )
                : SizedBox();
          }),
          GradientDivider(
            gradient: AppColors.buttonColor,
            width: Get.width,
            thickness: .3,
          ),
          MyInputField(
            controller: controllerCreateEvent.locationController,
            hint: "Location (added by the club)",
          ),
          GradientDivider(
            gradient: AppColors.buttonColor,
            width: Get.width,
            thickness: .2,
          ),
          Obx(() {
            return CustomSelectbaleButton(
              isLoading: controllerCreateEvent.isLoading.value,
              onTap: () async {
                String location = controllerCreateEvent.locationController.text;

                EventController eventController = Get.find();
                eventController.fetchEvents(
                  location: location,
                  day: controllerCreateEvent.eventDateController.text,
                  time: controllerCreateEvent.eventTimeController.text,
                  eventType: controllerCreateEvent.selectPartyType.value,
                  pricing: controllerCreateEvent.eventPricing.value,
                  capacityLimited: controllerCreateEvent.capacityLimited.value,
                );
                Get.back();
              },
              borderRadius: BorderRadius.circular(20),
              width: Get.width,
              height: 54.h,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Apply Filter",
            );
          }).marginSymmetric(vertical: 20.h),
        ],
      ).marginSymmetric(horizontal: 20.w),
    );
  }
}
