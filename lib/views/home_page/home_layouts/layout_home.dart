import 'dart:developer';
import 'dart:ui';
import 'package:blaxity/controllers/SettingController.dart';
import 'package:blaxity/controllers/blogs_controller.dart';
import 'package:blaxity/controllers/boost_controller.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/controllers/users_controllers/controller_get_user_all_data.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/widgets/custom_User_card_swiper.dart';
import 'package:blaxity/widgets/custom_splash_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../constants/location_utils.dart';
import '../../../controllers/controller_get_couple_sphere.dart';
import '../../../widgets/custom_blog_card_swiper.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_event_card_swiper.dart';
import '../../../widgets/custom_overLay_card_swiper.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/custom_toggle_switch.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/toggle_filter.dart';
import '../../layouts/item_event/event_button/item_event.dart';
import '../../layouts/item_subscription/item_subscription.dart';
import '../../screens/overlay_screen/screen_overlay.dart';
import '../../screens/screen_add_user.dart';
import '../../screens/screen_add_user_anonymousley.dart';
import '../../screens/screen_advance_filter.dart';
import '../../screens/screen_be_seen_details.dart';
import '../../screens/screen_favourite_sphere.dart';

class LayoutHome extends StatefulWidget {
  const LayoutHome({super.key});

  @override
  _LayoutHomeState createState() => _LayoutHomeState();
}

class _LayoutHomeState extends State<LayoutHome> {
  ControllerHome controllerHome = Get.put(ControllerHome());

  bool _isExpanded = false;
  double _sliderValue = 0.0;
  RangeValues _rangeValues = RangeValues(0, 100);

  void _showBottomSheetFilter(BuildContext context) {
    List<String> select = ['Male', 'Female', 'Other'];
    RxString address = RxString('');
    RxString latitude = RxString('');
    RxString longitude = RxString('');

    RxString selectValue = RxString(select[0]);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.sp),
          height: Get.height * 0.85,
          color: Colors.black,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FutureBuilder<bool>(
                future: checkPermissionStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Color(0xFFA7713F),
                    ));
                  }

                  if (!(snapshot.data ?? false)) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Location Permission Required",
                          ),
                          OutlinedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text(
                                "Retry",
                              ))
                        ],
                      ),
                    );
                  }

                  return FutureBuilder<Position>(
                      future: Geolocator.getCurrentPosition(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: GradientWidget(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          ));
                        }

                        var position = snapshot.data!;
                        longitude.value = position.longitude.toString();
                        latitude.value = position.latitude.toString();
                        return FutureBuilder<String?>(
                            future: getAddressFromCurrentLocation(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: GradientWidget(
                                  child: CircularProgressIndicator(
                                    // backgroundColor: appPrimaryColor,
                                    strokeWidth: 3,
                                  ),
                                ));
                              }
                              address.value =
                                  snapshot.data ?? "No Address Found";
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 3.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Location",
                                    style: TextStyle(
                                        fontSize: 18.sp, color: Colors.white),
                                  ).marginOnly(
                                    top: 5.h,
                                  ),
                                  Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color(0xFFA7713F),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: address.value),
                                      decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.all(12.0),
                                        hintText: 'Dubai',
                                        suffixIcon:
                                            Icon(Icons.location_on_outlined),
                                        focusColor: Colors.transparent,
                                        enabledBorder: InputBorder.none,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onChanged: (value) {},
                                      onSubmitted: (value) {},
                                    ),
                                  ).marginOnly(
                                    top: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Distance Preference",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text("${_sliderValue.round()} km",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ).marginOnly(
                                    top: 30.h,
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                            StateSetter setState) =>
                                        SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Color(0xFFA7713F),
                                        inactiveTrackColor: Colors.grey,
                                        trackHeight: 4.0,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 12.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 28.0),
                                        valueIndicatorTextStyle: TextStyle(
                                            color: Colors.white, fontSize: 9),
                                        showValueIndicator:
                                            ShowValueIndicator.always,
                                        thumbColor: Color(
                                            0xFFA7713F), // Set the thumb color here
                                      ),
                                      child: Slider(
                                        value: _sliderValue,
                                        min: 0,
                                        max: 100,
                                        divisions: 100,
                                        label: _sliderValue.round().toString(),
                                        onChanged: (value) {
                                          setState(() {
                                            _sliderValue = value;
                                          });
                                        },
                                      ),
                                    )..marginOnly(top: 20.sp),
                                  ),
                                  Text("Gender",
                                          style: TextStyle(color: Colors.white))
                                      .marginOnly(
                                    top: 5.h,
                                  ),
                                  CustomToggleSwitchFilter(
                                    labels: select,
                                    onToggle: (index) {
                                      print('Selected: Tab ${index + 1}');
                                      selectValue.value = select[index];
                                    },
                                  ),
                                  Text("Age Preference",
                                          style: TextStyle(color: Colors.white))
                                      .marginOnly(
                                    top: 5.sp,
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                            StateSetter setState) =>
                                        SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Color(0xFFA7713F),
                                        inactiveTrackColor: Colors.grey,
                                        trackHeight: 4.0,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 12.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 28.0),
                                        valueIndicatorTextStyle: TextStyle(
                                            color: Colors.white, fontSize: 9),
                                        showValueIndicator:
                                            ShowValueIndicator.always,
                                        thumbColor: Color(
                                            0xFFA7713F), // Set the thumb color here
                                      ),
                                      child: RangeSlider(
                                        values: _rangeValues,
                                        min: 0,
                                        max: 100,
                                        divisions: 100,
                                        labels: RangeLabels(
                                          _rangeValues.start.round().toString(),
                                          _rangeValues.end.round().toString(),
                                        ),
                                        onChanged: (RangeValues values) {
                                          setState(() {
                                            _rangeValues = values;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  CustomSplashButton(
                                    borderRadius: BorderRadius.circular(20),
                                    isLoading: controllerHome.isLoading.value,
                                    onTap: () async {
                                      ControllerGetUserAllData
                                          controllerGetUserAllData =
                                          Get.put(ControllerGetUserAllData());
                                      await controllerGetUserAllData
                                          .getUserData(
                                        location: {
                                          "longitude": position.longitude,
                                          "latitude": position.latitude
                                        },
                                        distancePreference:
                                            _sliderValue.round().toInt(),
                                        gender: selectValue.value,
                                        ageMax:
                                            _rangeValues.end.round().toInt(),
                                        ageMin:
                                            _rangeValues.start.round().toInt(),
                                      );
                                      Navigator.pop(context);
                                    },
                                    titleButton: "Apply Filter",
                                    isSelected: true,
                                    width: Get.width,
                                    height: 52.h,
                                    strokeWidth: 3,
                                    gradient: AppColors.buttonColor,
                                  ).marginOnly(
                                    top: 10.h,
                                  )
                                ],
                              ).marginSymmetric(
                                horizontal: 15.sp,
                              );
                            });
                      });
                }),
          ),
        );
      },
    );
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ControllerHome>().fetchUserInfo();
    BlogsController blogsController = Get.put(BlogsController());
    ControllerGetUserAllData controllerGetUserAllData =
        Get.put(ControllerGetUserAllData());
    controllerGetUserAllData.getUserData();
    EventController eventController = Get.put(EventController());
    BoostController boostController = Get.put(BoostController());
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    bool isFirstTime = false;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (Get.find<ControllerHome>()
                            .user
                            .value!
                            .user
                            .goldenMember ==
                        1) {
                      Get.to(ScreenAdvanceFilter());
                    } else {
                      Get.to(ScreenSubscription(isHome: true));
                    }

                    ///15,98
                    ///
                    // Get.find<ControllerHome>().fetchUserByIdProfile(240);
                    // Get.find<ControllerHome>().fetchUserProfile();

                    // Get.to(ScreenAddUser()
                    // );
                  },
                  icon: Icon(Icons.person_search)),
              IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                  icon: Icon(Icons.notifications_none)),
              IconButton(
                  onPressed: () {
                    Get.to(ScreenFavouriteSphere());
                  },
                  icon: Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () => _showBottomSheetFilter(context),
                  icon: Icon(Icons.filter_list)),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Color(0xFFA7713F),
        onRefresh: () async {
          eventController.fetchEvents();
          blogsController.fetchBlogs();
          await controllerGetUserAllData.getUserData();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Obx(() {
                return controllerGetUserAllData.isLoading.value
                    ? CircularProgressIndicator(
                        color: Color(0xFFA7713F),
                      )
                    : controllerGetUserAllData.userList.isEmpty
                        ? Container(
                            height: 530,
                            alignment: Alignment.center,
                            width: Get.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFF1D1D1D),
                              border: Border.all(color: Color(0xFFA7713F)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: GradientText(
                              text: "No User Found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600),
                            ))
                        : Obx(() {
                            return IntrinsicHeight(
                              child: Get.find<ControllerHome>()
                                          .isFirstTime
                                          .value ==
                                      true
                                  ? CustomOverLayCardSwiper(
                                      onDismiss: () async {
                                        await Get.find<ControllerHome>()
                                            .setHasSeenOverlay();
                                      },
                                    )
                                  : CustomUserCardSwiper(
                                      userList:
                                          controllerGetUserAllData.userList,
                                    ).marginSymmetric(horizontal: 16.w),
                            );
                          });
              }),
              Container(
                width: Get.width,
                // width: 335.w,
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFA7713F),
                    )),
                child: Column(
                  children: [
                    SvgPicture.asset("assets/icons/icon_ingative.svg")
                        .paddingOnly(
                      top: 3.h,
                    ),
                    Text(
                      "Invite Anonymously",
                      style: AppFonts.titleSuccessFullPassword,
                    ).paddingOnly(
                      top: 10.h,
                    ),
                    Text(
                            style: AppFonts.subtitle,
                            "Send an anonymous invitation to connect by\nentering their email or phone number")
                        .paddingOnly(
                      top: 5.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ScreenAddUser());
                      },
                      child: Container(
                        height: 31.96.h,
                        width: 194.19.w,
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(11.59.r),
                        ),
                        child: Center(
                          child: Text(
                            "Start invitation",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.59.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ).paddingOnly(
                        top: 13.h,
                      ),
                    )
                  ],
                ),
              ).marginOnly(
                top: 5.h,
              ),
              Obx(() {
                return (Get.find<SettingController>().isShowEvent.value)
                    ? SizedBox()
                    : (eventController.isLoading.value)
                        ? SizedBox()
                        : Container(
                            // color: Colors.red,
                            height: Get.height * .62,
                            margin: EdgeInsets.only(
                              top: 20.h,
                            ),
                            child: CustomEventCardSwiper(
                                eventList: eventController.events));
              }).marginOnly(
                top: 5.h,
              ),
              Obx(() {
                return (blogsController.isLoading.value)
                    ? CircularProgressIndicator()
                    : (blogsController.blogsList.isEmpty)
                        ? Container(
                            height: Get.height * .6,
                            alignment: Alignment.center,
                            width: Get.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFF1D1D1D),
                              border: Border.all(color: Color(0xFFA7713F)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: GradientText(
                              text: "No blogs found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600),
                            ))
                        : SizedBox(
                            height: Get.height * .56,
                            child: CustomBlogCardSwiper(
                              blogList: blogsController.blogsList,
                            ),
                          );
              }).marginOnly(
                top: 5.h,
              ),
              Obx(() {
                return (Get.find<ControllerHome>()
                            .user
                            .value!
                            .user
                            .boostStatus ==
                        "0")
                    ? Container(
                        height: 184.h,
                        width: Get.width,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 16.w),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFFA7713F),
                            )),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                                "assets/icons/icon_flash_gold.svg"),
                            Text(
                              "Get Boost",
                              style: AppFonts.titleSuccessFullPassword
                                  .copyWith(fontSize: 24.sp),
                            ),
                            Text(
                                style: AppFonts.subtitle,
                                textAlign: TextAlign.center,
                                "Be a top profile in your area for 30 minutes to \nget more matches"),
                            InkWell(
                              onTap: () {
                                if (int.parse(Get.find<ControllerHome>()
                                            .user
                                            .value!
                                            .user
                                            .boostCount ??
                                        "0") >
                                    0) {
                                  log(Get.find<ControllerHome>()
                                      .user
                                      .value!
                                      .user
                                      .boostCount
                                      .toString());
                                  boostController.activateBoost();
                                }
                              },
                              child: Container(
                                height: 31.96.h,
                                width: 194.19.w,
                                decoration: BoxDecoration(
                                  gradient: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(11.59.r),
                                ),
                                child: Obx(() {
                                  return (boostController.isProcessing.value)
                                      ? SizedBox(
                                          height: 15.h,
                                          width: 15.w,
                                          child: CircularProgressIndicator(),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                              Text(
                                                "Be seen",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.59.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                "assets/icons/icon_flah.svg",
                                                height: 16.98.h,
                                                width: 10.28.w,
                                              ).paddingOnly(
                                                left: 3.w,
                                              )
                                            ]);
                                }),
                              ).paddingOnly(
                                top: 13.h,
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox();
              }).marginOnly(
                top: 5.h,
              )
            ],
          ).marginSymmetric(vertical: 10.h, horizontal: 4.w),
        ),
      ),
    );
  }
}
