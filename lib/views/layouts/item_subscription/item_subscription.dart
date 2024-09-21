import 'dart:developer';

import 'package:blaxity/controllers/subscription_controller.dart';
import 'package:blaxity/models/boost.dart';
import 'package:blaxity/models/subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_payment.dart';
import '../../screens/screen_subscription_details.dart';

class ItemSubscription extends StatelessWidget {
  Subscription subscription;
  bool isHome;
  ItemSubscription({
    required this.subscription,
    required this.isHome
  });
RxBool isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.h),
          height: 136.h,
          width: 239.13.w,
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
                      height: 28.92.h,
                      width: 97.47.w,
                      decoration: BoxDecoration(
                        gradient: AppColors.buttonColorSubscription,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          subscription.stripeProduct.toString(),
                          style: AppFonts.subscriptionDuration,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\$ ${subscription.price} ",
                            style: AppFonts.subscriptionPrice.copyWith(
                                fontSize: 22.sp),
                          ),
                          if((subscription.stripeProduct != '1 week' &&
                              subscription.stripeProduct !=
                                  'lifetime'))TextSpan(
                            text: "\n\$${ (double.parse(subscription.price) /
                                (subscription.stripeProduct == '1 month gold'
                                    ? 4
                                    : (subscription.stripeProduct ==
                                    '1 year gold' ? 52 : 1))).toStringAsFixed(
                                2)}/ week",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  Get.to(ScreenSubscriptionDetails(
                    subscription: subscription, isHome: isHome,
                  ));
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GradientText(
                        text: "Blaxity Gold Features",
                        style: AppFonts.subscriptionSubtitle,
                        gradient: AppColors.buttonColorSubscription,
                      ),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return AppColors.buttonColor.createShader(bounds);
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 24,
                        ),
                      ),
                    ],
                  ).marginSymmetric(vertical: 5.h),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            isLoading.value = true;

         await   PaymentsController().makePayment(subscription.price, subscription.stripePrice,onError: (error){
              log(error.toString());
              FirebaseUtils.showError(error);
            },onSuccess: (paymentIntent) async {
             await Get.find<SubscriptionController>().createPayment("", subscription.stripeProduct, "");
            });

            isLoading.value = false;

          },
          child: Container(
            height: 28.92.h,
            width: 217.w,
            decoration: BoxDecoration(
              gradient: AppColors.buttonColorSubscription,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Obx(() {
              return Center(
                child:(isLoading.value)?SizedBox(height: 15.h,width: 15.w,child: CircularProgressIndicator(),): Text(
                  "Subscribe",
                  style: AppFonts.subscriptionDuration,
                ),
              );
            }),
          ),
        ),
      ],
    ).marginOnly(
      bottom: 20.h,
    );
  }


}
