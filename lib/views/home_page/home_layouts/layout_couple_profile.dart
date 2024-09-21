import 'dart:developer';

import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/views/screens/screen_be_seen_details.dart';
import 'package:blaxity/views/screens/screen_view_couple_connections.dart';
import 'package:blaxity/views/screens/screen_view_description.dart';
import 'package:blaxity/views/screens/screen_view_events.dart';
import 'package:blaxity/views/screens/screen_view_user_photos.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/views/screens/screen_start_verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../constants/ApiEndPoint.dart';
import '../../../constants/extensions/time_ago.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_get_couple.dart';
import '../../../controllers/controller_like_user.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';
import '../../layouts/item_event_profile.dart';
import '../../layouts/item_profile_details.dart';
import '../../screens/screen_subscription.dart';
import '../../screens/screen_subscription_type_profile.dart';
import '../../screens/screen_userChat.dart';

class LayoutCoupleProfile extends StatefulWidget {
  int coupleId;
    bool? isMatch;
  LayoutCoupleProfile({required this.coupleId,this .isMatch = false});

  @override
  State<LayoutCoupleProfile> createState() => _LayoutCoupleProfileState();
}

class _LayoutCoupleProfileState extends State<LayoutCoupleProfile> {
  User? user1,user2;

  @override
  Widget build(BuildContext context) {
    log("My Couple Id ${widget.coupleId}");
    CoupleController coupleController = Get.put(CoupleController());

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: (widget.isMatch == true)?AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Profile",style: TextStyle(color: Color(0xFFA7713F),fontSize: 16.sp,fontWeight: FontWeight.w500),),
      ):null,
      body: RefreshIndicator(
        color:  Color(0xFFA7713F),
        onRefresh: () async {
          await coupleController.fetchCoupleDetails(widget.coupleId.toString());

          },
        child: FutureBuilder<CoupleData>(
          future: coupleController.fetchCoupleDetails(widget.coupleId.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
               color: Color(0xFFA7713F),
              ));

            }

            if (snapshot.hasError) {
              return Text("Something went wrong: ${snapshot.error}");
            }
            List<User> userList = snapshot.data!.data;
             if (userList.isNotEmpty) {
               user1 =userList.first;
               if (widget.isMatch==true) {
                 Get.find<ControllerHome>().viewUserCount(int.parse(user1!.id!));
               }

             }
             if (userList.length > 1) {
               user2 =userList[1];
               if (widget.isMatch==true) {
                 Get.find<ControllerHome>().viewUserCount(int.parse(user2!.id!));
               }

             }
            return (userList.isEmpty)?Center(child: Text("No Couple Found")):SingleChildScrollView(
              child: Column(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 83.h,
                        width: 83.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2.w,
                            color: Color(0xFFA7713F),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "${APiEndPoint.imageUrl}${user1!.coupleRecentImage!=null?user1!.coupleRecentImage!.userRecentImages.first:"https://via.placeholder.com/250"}",
                          ))

                        ),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return AppColors.buttonColor.createShader(bounds);
                          },


                        ),
                      ),
                      Container(
                        height: 58.h,
                        width: 336.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFFA7713F),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GradientText(
                              text: "${user1!.partner1Name}&${user1!.partner2Name}",
                              style: AppFonts.homeScreenText,
                              gradient: AppColors.buttonColor,
                            ),
                            if(user1!.commonCoupleData!.goldenMember == 1)SvgPicture.asset(
                              "assets/icons/icon_dimond.svg",
                            ).marginOnly(
                              left: 8.sp,
                            ),
                          ],
                        ),
                      ).marginOnly(
                        top: 15.sp,
                      ),
                      Container(
                        height: 30.05.h,
                        width: 194.w,
                        decoration: BoxDecoration(
                            gradient: AppColors.buttonColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.1),
                              bottomRight: Radius.circular(20.1),
                            )
                        ),
                        child: Center(
                          child: Text(user1!.pmType?? "Free", style: AppFonts.subtitle,),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: height * .15,
                            width: width * .15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFA7713F),
                                )
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(user1!.commonCoupleData==null?"0":user1!.commonCoupleData!.score ?? "0",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 18.0.sp,
                                  left: 2.sp,
                                  child: Container(
                                    height: 20.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        gradient: AppColors.buttonColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        )
                                    ),
                                    child: Center(
                                      child: Text("Level 0", style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text("Score",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).paddingSymmetric(
                            horizontal: 20.sp,),
                          Container(
                            height: height * .15,
                            width: width * .15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFA7713F),
                                )
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(getDaysSinceFromDateString(user1!.createdAt!).toString(),
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 18.0.sp,
                                  left: 2.sp,
                                  child: Container(
                                    height: 20.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        gradient: AppColors.buttonColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        )
                                    ),
                                    child: Center(
                                      child: Text("Year 0",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text("Days",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).paddingSymmetric(
                            horizontal: 20.sp,),
                          Container(
                            height: height * .15,
                            width: width * .15,
                            decoration: BoxDecoration(
                              color: user1!.verified == 1 ? AppColors.appColor : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFA7713F),
                                )
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    user1!.verified ==
                                        1 ? Icons.done : Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(

                                    textAlign: TextAlign.center,
                                    user1!.verified ==
                                        1 ? "Verified" : "Not Verified",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).paddingSymmetric(
                            horizontal: 20.sp,),
                        ],
                      ),
                      //When user1! is not Verified////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      /////////////////////
                      /////////////////////
                      ////////////////////
                      //////////////////
                      ///////////////
                      /////////////
                      ///////////
                      /////////
                      if(Get.find<ControllerHome>().user.value!.user.verification!.status=="pending"&&widget.isMatch==false) Container(
                        height:184.h,
                        width: 335.w,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Color(0xff1D1D1D),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFFA7713F),
                            )
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/icons/icon_right_tick.svg")
                                .marginOnly(
                              top: 10.sp,
                              bottom: 10.sp,
                            ),
                            Text("Verify Your Profile",
                              style: AppFonts.titleSuccessFullPassword,),
                            Text(
                                textAlign: TextAlign.center,
                                style: AppFonts.subtitle,
                                "Enhance your credibility by verifying\nyour profile.")
                                .marginSymmetric(
                              vertical: 8.sp,
                            ),
                            InkWell(
                              onTap: (){
                                if (user1!.verification!.status=="pending"&&user1!.verification!.selfie==null) {

                                  Get.to(ScreenVerification());
                                }  else{
                                  FirebaseUtils.showError("Your profile in Pending for Verification");
                                }
                              },
                              child: Container(
                                height: 31.3.h,
                                width: 194.19.w,
                                decoration: BoxDecoration(
                                  gradient: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(11.59.r),
                                ),
                                child: Center(
                                  child: Text(
                                    Get.find<ControllerHome>().user.value!.user.verification!.status=="pending"&&Get.find<ControllerHome>().user.value!.user.verification!.status==null?"Start Verification":"Pending", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.66.sp,
                                    fontWeight: FontWeight.w700,
                                  ),),
                                ),
                              ).paddingOnly(
                                top: 5.h,
                              ),
                            ),
                          ],
                        ),
                      ).marginOnly(
                        top: 30.sp,
                      ),

                    ],
                  ).marginSymmetric(
                    horizontal: 15.sp,
                    vertical: 10.sp,
                  ),

                  (Get.find<ControllerHome>().user.value!.user.goldenMember==1|| widget.isMatch==false)?Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          text: 'Photos',
                          style: AppFonts.homeScreenText,
                          gradient: AppColors.buttonColor,
                        ),
                      ).marginSymmetric(
                        vertical: 15.sp,
                      ),
                      (user1!.coupleRecentImage != null)?
                        GestureDetector(
                          onTap: (){
                            List<String> imageList=user1!.coupleRecentImage!.userRecentImages.map((e) => APiEndPoint.imageUrl + e).toList();
                            Get.to(ScreenViewUserPhotos(imagesList:imageList , UserName: user1!.partner1Name!+"&"+user1!.partner2Name!,));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(children: List.generate(
                                      user1!.coupleRecentImage!
                                          .userRecentImages
                                          .length>3?3:user1!.coupleRecentImage!.userRecentImages.length, (index) =>
                                        Container(
                                            width: 97.w,
                                            height: 152.h,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF353535),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 2.w,
                                                  color: Color(0xFFA7713F),
                                                ),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        APiEndPoint.imageUrl +
                                                            user1!.coupleRecentImage!

                                                                .userRecentImages[index]))
                                            )).marginOnly(right: 6.w),
                                    ),),
                                  )),
                              GradientWidget(
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24,
                                ),
                              ),
                            ],
                          ).marginSymmetric(vertical: 6.h),
                        ):Text("No Photos").marginSymmetric(  vertical: 6.h),
                      Row(
                        children: [
                          Expanded(
                            child: GradientText(
                              text: 'Details',
                              style: AppFonts.subscriptionTitle,
                              gradient: AppColors.buttonColor,
                            ),
                          ),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/${user1!.partner1Sex=="Male"?"male-partner":"icon_male"}.svg"),
                                GradientText(
                                  text: user1!.partner1Name ?? "",
                                  style: AppFonts.subscriptionTitle,
                                  gradient: AppColors.buttonColor,
                                ).marginOnly(
                                  left: 5.sp,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                SvgPicture.asset("assets/icons/${user1!.partner2Sex=="Male"?"male-partner":"icon_male"}.svg"),
                                GradientText(
                                  text: user1!.partner2Name ?? "",
                                  style: AppFonts.subscriptionTitle,
                                  gradient: AppColors.buttonColor,
                                ).marginOnly(
                                  left: 5.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).marginOnly(
                        top: 15.h,
                      ),
                      Column(
                        children: [
                          ItemProfileDetails(detail: "Age",
                            ageFirstPerson: "${user1!.partner_1_age??"No"}",
                            ageSecondPerson: "${user1==null?"No":user1!.partner_2_age??"No"}",
                            isGrey: true,
                          ),
                          ItemProfileDetails(detail: "Body Type",
                            ageFirstPerson: "${user1!.additionalInfo!.bodyType}",
                            ageSecondPerson: "${user2==null?"No":user2!
                                .additionalInfo!.bodyType}",
                            isGrey: false,
                          ),
                          ItemProfileDetails(detail: "Height",
                            ageFirstPerson: "${user1!.reference!.height}",
                            ageSecondPerson: "${user2==null?"No":user2!.reference!.height}",
                            isGrey: true,
                          ),
                          ItemProfileDetails(detail: "Ethnicity",
                            ageFirstPerson: "${user1!.reference!.ethnicity}",
                            ageSecondPerson: "${user2==null?"No":user2!.reference!.ethnicity}",
                            isGrey: false,
                          ),
                          ItemProfileDetails(detail: "Smoking",
                            ageFirstPerson: "${user1!.additionalInfo!
                                .smokingHabit}",
                            ageSecondPerson: "${user2==null?"No":user2!.additionalInfo!.smokingHabit}",
                            isGrey: true,
                          ),
                          ItemProfileDetails(detail: "Languages",
                            ageFirstPerson: "${user1!.reference!.language}",
                            ageSecondPerson: "${user2==null?"No":user2!.reference!.language}",
                            isGrey: false,
                          ),
                          ItemProfileDetails(detail: "Education",
                            ageFirstPerson: "${user1!.reference!.education}",
                            ageSecondPerson: "${user2==null?"No":user2!.reference!.education}",
                            isGrey: true,
                          ),
                          ItemProfileDetails(detail: "Drink",
                            ageFirstPerson: "${user1!.additionalInfo!
                                .drinkingHabit}",
                            ageSecondPerson: "${user2==null?"No":user2!.additionalInfo!.drinkingHabit}",
                            isGrey: false,
                          ),
                          ItemProfileDetails(detail: "Safety Practices",
                            ageFirstPerson: "${user1!.additionalInfo!
                                .safetyPractice}",
                            ageSecondPerson: "${user2==null?"No":user2!.additionalInfo!.safetyPractice}",
                            isGrey: true,
                          ),
                          ItemProfileDetails(detail: "Eye Color",
                            ageFirstPerson: "${user1!.reference!.eyeColor}",
                            ageSecondPerson: "${user2==null?"No":user2!.reference!.eyeColor}",
                            isGrey: false,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          text: 'Connections',
                          style: AppFonts.homeScreenText,
                          gradient: AppColors.buttonColor,
                        ),
                      ).marginSymmetric(
                        vertical: 15.sp,
                      ),
                      Row(
                        children: [

                         if( snapshot.data!.networks.isNotEmpty) Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: List.generate(snapshot.data!.networks.length  , (index){
                                NetWork network = snapshot.data!.networks[index];

                                return Container(
                                  margin: EdgeInsets.only(right: 10.w,bottom: 6.h),
                                  height: 39.33.h,
                                  width: 39.33.w,
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    // gradient: AppColors.buttonColor,
                                    border: Border.all(
                                      width: 2.w,
                                      color: Color(0xFFA7713F),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return AppColors.buttonColor.createShader(
                                              bounds);
                                        },
                                        child:(network.user_type=="couple")? Icon(
                                          Icons.group,
                                          size: 15.h,
                                        ): Icon(
                                          Icons.person,
                                          size: 15.h,
                                        ),
                                      ),
                                      Text(" ${network.f_name}", style: TextStyle(
                                        fontSize: 6.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      ),
                                    ],
                                  ),
                                );
                              } ),),
                            ),
                          ),
                          if(snapshot.data!.networks.length>=3)GradientText(
                            text: '+ ${snapshot.data!.networks.length}',
                            style: AppFonts.homeScreenText,
                            gradient: AppColors.buttonColor,
                          ).marginSymmetric(
                            horizontal: 6.sp,
                          ),
                          if (snapshot.data!.networks.isEmpty) Text("No Connections"),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              Get.to(ScreenViewCoupleConnections(connections: snapshot.data!.networks, name: user1!.partner1Name!+'&'+user1!.partner2Name!,));
                            },
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return AppColors.buttonColor.createShader(bounds);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GradientDivider(
                        thickness: 0.4,
                        gradient: AppColors.buttonColor,
                        width: width,
                      ).paddingOnly(
                        top: 5.sp,
                        bottom: 10.sp,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          text: 'Events',
                          style: AppFonts.homeScreenText,
                          gradient: AppColors.buttonColor,
                        ),
                      ).marginSymmetric(
                        vertical: 5.sp,
                      ),
                       (user1!.eventsAction != null&&user1!.eventsAction!.isNotEmpty)?
                        GestureDetector(
                          onTap: (){
                            Get.to(ScreenViewEvents(eventActions: user1!.eventsAction!));
                          },
                          child: Row(
                            children: [
                              Row(
                                children:
                                List.generate(
                                  user1!.eventsAction!.length > 2
                                      ? 2
                                      :user1!.eventsAction!.length,
                                      (index) {
                                    return ItemUserEventProfile(
                                      event: user1!.eventsAction![index],
                                    );
                                  },
                                ),
                              ),
                              if (user1!.eventsAction!.length >= 3)
                                GradientText(
                                  text: '+ ${user1!.eventsAction!.length}',
                                  style: TextStyle(fontSize: 16.sp),
                                  gradient: AppColors.buttonColor,
                                ).marginSymmetric(
                                  horizontal: 6.sp,
                                ),
                              Spacer(),
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return AppColors.buttonColor.createShader(bounds);
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24,
                                ),
                              ),
                            ],
                          ).marginSymmetric(vertical: 6.h),
                        ):Row(
                          children: [
                            Text("No Joined Events").marginSymmetric(vertical: 2.h),
                            Spacer(),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return AppColors.buttonColor.createShader(bounds);
                              },child:  Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 24,
                            )),

                          ],
                        ),
                      GradientDivider(
                        thickness: 0.4,
                        gradient: AppColors.buttonColor,
                        width: width,
                      ).paddingOnly(
                        top: 10.sp,
                        bottom: 10.sp,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GradientText(
                          text: 'About',
                          style: AppFonts.homeScreenText,
                          gradient: AppColors.buttonColor,
                        ),
                      ).marginOnly(
                        top: 20.sp,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(ScreenViewDescription(description: user1!.commonCoupleData==null?"No Description":user1!.commonCoupleData!.description?? "No Description"));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                user1!.commonCoupleData==null?"No Description":user1!.commonCoupleData!.description?? "No Description",),
                            ),
                            // Spacer(),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return AppColors.buttonColor.createShader(bounds);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GradientDivider(
                        thickness: 0.4,
                        gradient: AppColors.buttonColor,
                        width: width,
                      ).paddingOnly(
                        top: 5.sp,
                        bottom: 30.sp,
                      ),
                      if (widget.isMatch!)        Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        width: Get.width * .65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Color(0xFFA7713F),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child:CircleAvatar(
                                backgroundColor: Color(0xFF1D1D1D),
                                child: Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                            GestureDetector(
                              child: CircleAvatar(
                                radius: 22.r,
                                backgroundColor: Color(0xFFA7713F),
                                child: SvgPicture.asset(
                                  "assets/icons/icon_flah.svg",
                                ).marginSymmetric(horizontal: 5.h),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                if (snapshot.data!.data.length>1) {
                                 if (Get.find<ControllerHome>().user.value!.user.message_count!>0) {
                                   Get.to(ScreenUserChat(usersList: snapshot.data!.data,));
                                 }
                                 else{
                                   FirebaseUtils.showError("You reached the limit.");
                                 }
                                }  else{
                                  FirebaseUtils.showError("Your partner is not available");
                                }


                                // if (widget.userList[indexValue.value].userType=="couple") {
                                //   CoupleController coupleController = Get.put(CoupleController());
                                //   await coupleController.fetchCoupleDetails(widget.userList[indexValue.value].coupleId.toString()).then((value) {
                                //
                                //     if (value.length>1) {
                                //       Get.to(ScreenUserChat(usersList: value,));
                                //     }
                                //     else{
                                //       FirebaseUtils.showError("Your partner is not available");
                                //     }
                                //   });
                                // }
                                // else{
                                //   ControllerHome controllerHome = Get.find<ControllerHome>();
                                //   await controllerHome.fetchUserByIdProfile(widget.userList[indexValue.value].id!).then((value){
                                //     Get.to(ScreenUserChat(usersList: [value.user],));
                                //   });
                                // }

                              },
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 22.r,
                                    backgroundColor: Color(0xFF1D1D1D),
                                    child: SvgPicture.asset(
                                      "assets/icons/icon_chat.svg",
                                    ).marginSymmetric(horizontal: 5.sp),
                                  ),
                                  // Positioned(
                                  //   top: 0.0,
                                  //   right: 0.sp,
                                  //   child: CircleAvatar(
                                  //     radius: 8.r,
                                  //     backgroundColor: Color(0xFFA7713F),
                                  //     child: Text(
                                  //       "20",
                                  //       style: TextStyle(
                                  //         fontSize: 7.sp,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                LikeController likeController=Get.put(LikeController());
                                likeController.likeEntity(likedCoupleId: user1!.coupleId!);
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFA7713F),
                                child: SvgPicture.asset(
                                  "assets/icons/icon_heart.svg",
                                ).marginSymmetric(horizontal: 5.w),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ).marginSymmetric(
                    horizontal: 15.w,
                  ):Container(
                    height: 184.h,
                    width: 335.w,
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xff1D1D1D),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFA7713F)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upgrade to Gold",
                          style: AppFonts.titleSuccessFullPassword,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Subscribe ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xffD0D0D0),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "Blaxity Gold ",
                                style: TextStyle(
                                  color: Color(0xFFA26837),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text:
                                "to view full profiles\nand much more.",
                                style: TextStyle(
                                  color: Color(0xffD0D0D0),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ).marginSymmetric(vertical: 6.h),
                        InkWell(
                          onTap: () {
                            Get.to(ScreenSubscription(isHome: true));
                          },
                          child: Container(
                            height: 42.27.h,
                            width: 262.22.w,
                            decoration: BoxDecoration(
                              gradient: AppColors.buttonColor,
                              borderRadius:
                              BorderRadius.circular(15.66.r),
                            ),
                            child: Center(
                              child: Text(
                                "View subscription plans",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.66.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ).paddingOnly(top: 15.h),
                        ).marginSymmetric(vertical: 10.h),
                      ],
                    ),
                  ),
                  if (widget.isMatch == false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GradientText(
                          text: 'Subscription type',
                          style: AppFonts.homeScreenText,
                          gradient: AppColors.buttonColor,
                        ),
                        Row(children: [
                          Text(user1!.pmType?? "Free",),
                          Spacer(),
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return AppColors.buttonColor.createShader(bounds);
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 24,
                            ),
                          ),
                        ],).marginSymmetric(vertical: 4.h
                        ),
                       GradientDivider(gradient: AppColors.buttonColor, width: 335.w,),
                        if(user1!.boostCount=="0")CustomSelectbaleButton(
                          isSelected: true,
                          borderRadius: BorderRadius.circular(20),
                          imageUrl: "assets/icons/icon_flash_png.png",
                          gradient: AppColors.buttonColor,
                          onTap: () {
                            Get.to(ScreenBeSeenDetails());
                          },
                          width: width,
                          height: 52.h,
                          strokeWidth: 2,
                          titleButton: 'Boost',
                        ).marginOnly(
                          top: 20.sp,
                        ),
                        if (user1!.goldenMember == 0)
                          Container(
                            height: 184.h,
                            width: 335.w,
                            margin: EdgeInsets.symmetric(vertical: 12.h),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xff1D1D1D),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFFA7713F)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Upgrade to Gold",
                                  style: AppFonts.titleSuccessFullPassword,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Subscribe ",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0xffD0D0D0),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Blaxity Gold ",
                                        style: TextStyle(
                                          color: Color(0xFFA26837),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                        "to view full profiles\nand much more.",
                                        style: TextStyle(
                                          color: Color(0xffD0D0D0),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).marginSymmetric(vertical: 6.h),
                                InkWell(
                                  onTap: () {
                                    Get.to(ScreenSubscription(isHome: true));
                                  },
                                  child: Container(
                                    height: 42.27.h,
                                    width: 262.22.w,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.buttonColor,
                                      borderRadius:
                                      BorderRadius.circular(15.66.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "View subscription plans",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.66.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ).paddingOnly(top: 15.h),
                                ).marginSymmetric(vertical: 10.h),
                              ],
                            ),
                          )
                      ],
                    ).marginSymmetric(
                      horizontal: 15.w,
                      vertical: 10.h
                    ),
                ],
              ),
            );

          },
        ),
      ),
    );
  }
}
