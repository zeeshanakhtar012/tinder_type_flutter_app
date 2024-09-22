import 'dart:developer';

import 'package:blaxity/controllers/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../constants/firebase_utils.dart';
import '../../constants/fonts.dart';
import '../../controllers/controller_payment.dart';
import '../../models/subscription.dart';

class ItemSubscriptionDetails extends StatelessWidget {
  Subscription subscription;


  @override
  Widget build(BuildContext context) {
    SubscriptionController subscriptionController = Get.put(
        SubscriptionController()
    );
    return Column(
      children: [
        Container(
          height: Get.height * .6,
          width: 239.13.w,
          // constraints: BoxConstraints(
          //   maxWidth:239.13.w,
          //   maxHeight: Get.height*.6
          // ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFFA7713F),
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                            height: 28.h,
                            width: 97.47.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFA7713F),
                              // border: Border.all(
                              //   color: Color(0xFFA7713F),
                              // ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                subscription.stripeProduct.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.87.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("\$ ${subscription.price}",
                    style: AppFonts.subscriptionPrice,),
                ).marginOnly(
                  top: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientText(
                      text: 'Blaxity Gold Features',
                      style: AppFonts.subscriptionSubtitle,
                      gradient: AppColors.buttonColor,
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: subscription.features.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Icon(
                            Icons.fiber_manual_record),
                        Text(
                          textAlign: TextAlign.start,
                          subscription.features[index], style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),).marginOnly(
                          left: 6.w,
                        ),
                      ],
                    );
                  },
                ).marginOnly(
                  left: 10.w,
                  top: 15.h,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            PaymentsController().makePayment(
                subscription.price, subscription.stripePrice, onError: (error) {
              log(error.toString());
              FirebaseUtils.showError(error);
            }, onSuccess: (paymentIntent) {
              subscriptionController.createPayment(
                  "", subscription.stripeProduct, "");
            });
          },
          child: Obx(() {
            return Container(
              height: 43.h,
              width: 217.w,
              decoration: BoxDecoration(
                  gradient: AppColors.buttonColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Center(
                  child: (subscriptionController.isProcessing.value)?CircularProgressIndicator():Text(
                    "Subscribe - \$ ${subscription.price} / total",
                    style: AppFonts.subscriptionDuration,
                  )),
            );
          }),
        )
      ],
    );
  }

  ItemSubscriptionDetails({
    required this.subscription,
  });
}
