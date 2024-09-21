import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/boost_controller.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/controllers/controller_payment.dart';
import 'package:blaxity/models/boost.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/layouts/item_subscription/item_boost.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_selectable_button.dart';
import '../layouts/item_subscription/item_subscription.dart';

class ScreenBeSeenDetails extends StatefulWidget {
  @override
  State<ScreenBeSeenDetails> createState() => _ScreenBeSeenDetailsState();
}

class _ScreenBeSeenDetailsState extends State<ScreenBeSeenDetails> {
  // const ScreenBeSeenDetails({super.key});
  RxInt selectedButtonIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    BoostController boostController = Get.put(BoostController());
    boostController.fetchBoosts();
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
              "assets/images/image_profile_appBar.png"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/icon_be_seen_flash.svg"),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  style: AppFonts.titleLogin,
                  text: "Be Seen",
                  gradient: AppColors.buttonColor,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Be a top profile in your area for 30 minutes to get more matches",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ).marginSymmetric(
                vertical: 5.sp,
              ),
              Obx(() {
                return (boostController.isLoading.value) ? Center(
                    child: CircularProgressIndicator()) : (boostController
                    .boosts.isEmpty) ? Center(
                  child: Text("No Boosts", style: TextStyle(color: Colors
                      .white),),) : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: boostController.boosts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Boost boost = boostController.boosts[index];
                    return ItemBoost(boost: boost, onTap: () {
                      selectedButtonIndex.value = index;
                    },);
                  },);
              }),

              Obx(() {
                return (Get.find<ControllerHome>().user.value!.user.goldenMember==0)?Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.33),
                    border: Border.all(
                      color: Color(0xFFA7713F),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                height: 22.h,
                                width: 148.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFA7713F),
                                  ),
                                  borderRadius: BorderRadius.circular(11.33),
                                ),
                                child: Center(
                                  child: Text(
                                    "1 free boost per month",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "Get Blaxity Gold",
                                    style: AppFonts.subtitle,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Get.to(ScreenSubscription(isHome: true));
                                    },
                                    child: Container(
                                      height: 22.h,
                                      width: 64.w,
                                      decoration: BoxDecoration(
                                        gradient: AppColors
                                            .buttonColor,
                                        borderRadius: BorderRadius.circular(
                                            11.33),
                                        border: Border.all(
                                          color: Color(0xFFA7713F),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Select",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ).marginSymmetric(
                                horizontal: 10.sp,
                                vertical: 10.sp,
                              )
                            ],
                          )),
                    ],
                  ),
                ):SizedBox();
              }).marginSymmetric(
                vertical: 45.h,
              ),
              Obx(() {
                return CustomSelectbaleButton(
                  isSelected: true,
                  isLoading: boostController.isProcessing.value,
                  buttonTextColor: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () {
                    PaymentsController().makePayment(
                        boostController.boosts[selectedButtonIndex.value].price,
                        boostController.boosts.first.stripePlan,
                        onSuccess: (paymentResult) {
                          boostController.createBoostPayment("", boostController
                              .boosts[selectedButtonIndex.value].name, "");
                        }, onError: (error) {
                      log("Error$error");
                      FirebaseUtils.showError(error);
                    });
                  },
                  width: Get.width,
                  height: 52.h,
                  strokeWidth: 2,
                  gradient: AppColors.buttonColor,
                  titleButton: 'Continue US\$${boostController
                      .boosts[selectedButtonIndex.value]
                      .price} total',
                );
              }).marginSymmetric(
                vertical: 5.sp,
              ),
              CustomButton(
                isRound: true,
                isBorder: true,
                text: "Skip for now",
                textColor: Colors.grey,
                onTap: () {
                  Get.back();
                },
              ).marginSymmetric(
                vertical: 10.sp,
              ),
            ],
          ).marginSymmetric(
            horizontal: 25.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }
}
