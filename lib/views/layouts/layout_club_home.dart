import 'dart:ui';
import 'package:blaxity/controllers/blogs_controller.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/views/layouts/item_blog/item_blog.dart';
import 'package:blaxity/widgets/custom_blog_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/controller_home.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_event_card_swiper.dart';
import '../../widgets/custom_selectable_button.dart';
import '../home_page/home_layouts/layout_event.dart';
import '../screens/screen_add_user_anonymousley.dart';
import '../screens/screen_be_seen_details.dart';
import '../screens/screen_individual/screen_create_event.dart';
import 'item_club_home_event.dart';

class LayoutClubHome extends StatefulWidget {
  @override
  State<LayoutClubHome> createState() => _LayoutClubHomeState();
}

class _LayoutClubHomeState extends State<LayoutClubHome> {
  final EventController eventController = Get.put(EventController());

  final BlogsController blogsController = Get.put(BlogsController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false
        ,
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
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.notifications_none, color: Colors.white),
          ),
          IconButton(
              onPressed: () {

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
              icon: Icon(Icons.filter_list)),

        ],
      ),
      body: RefreshIndicator(
        color: AppColors.appColor,
        onRefresh: () async {

          eventController.fetchEvents();
          blogsController.fetchBlogs();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: Get.height*.6,
                  child: Obx(() {
                  return  (eventController.events.value.isEmpty)?Center(child: Text("No Events",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp
                    ))):CustomEventCardSwiper(eventList: eventController.events);
                  })),
              Container(
                width: Get.width,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFA7713F),
                  ),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset("assets/icons/icon_ingative.svg"),
                    Text("Invite Anonymously",
                        style: AppFonts.titleSuccessFullPassword),
                    Text(
                      "Send an anonymous invitation to connect by entering their email or phone number",
                      style: AppFonts.subtitle,
                      textAlign: TextAlign.center,
                    ).marginSymmetric(vertical: 15.h),
                    CustomSelectbaleButton(
                      isSelected: true,
                      onTap: () {
                        Get.to(ScreenAddUserAnonymously());
                      },
                      borderRadius: BorderRadius.circular(20),
                      width: 200.w,
                      height: 35.h,
                      strokeWidth: 1,
                      gradient: AppColors.buttonColor,
                      titleButton: "Start invitation",
                    ).marginOnly(bottom: 15.h),
                  ],
                ),
              ).marginOnly(bottom: 20.h),
              SizedBox(
                height: Get.height*.56,
                child: CustomBlogCardSwiper(blogList: blogsController.blogsList,),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Color(0xFFA7713F)),
              //   ),
              //   child: Column(
              //     children: [
              //       SvgPicture.asset("assets/icons/icon_flash_gold.svg"),
              //       Text("Be seen", style: AppFonts.titleSuccessFullPassword),
              //       Text(
              //         "Be a top profile in your area for 30 minutes to get more matches",
              //         style: AppFonts.subtitle,
              //         textAlign: TextAlign.center,
              //       ).marginSymmetric(vertical: 8.sp),
              //       CustomSelectbaleButton(
              //         isSelected: true,
              //         onTap: () {
              //           Get.to(ScreenBeSeenDetails());
              //         },
              //         borderRadius: BorderRadius.circular(20),
              //         width: 200.w,
              //         height: 35.h,
              //         strokeWidth: 1,
              //         gradient: AppColors.buttonColor,
              //         titleButton: "Get boost",
              //         imageUrl: "assets/icons/icon_flash_png.png",
              //       ),
              //     ],
              //   ),
              // ).marginOnly(
              //   top: 20.h,
              // ),
            ],
          ).marginSymmetric(horizontal: 25.w),
        ),
      ),
    );
  }
}
