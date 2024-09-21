import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_individual/screen_amenities_individual.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../constants/location_utils.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenLocationIndividual extends StatefulWidget {
  String step;
  User? user;

  @override
  State<ScreenLocationIndividual> createState() =>
      _ScreenLocationIndividualState();

  ScreenLocationIndividual({
    required this.step,
    this.user,
  });
}

class _ScreenLocationIndividualState extends State<ScreenLocationIndividual> {
  ControllerRegistration controllerRegistration =
      Get.put(ControllerRegistration());
Club ? club;
  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      club = widget.user!.clubs!.first;
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Text(
            widget.step,
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: FutureBuilder<bool>(
            future: checkPermissionStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: GradientWidget(
                  child: CircularProgressIndicator.adaptive(
                    // backgroundColor: AppColors.,
                    strokeWidth: 3,
                  ),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: GradientWidget(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ));
                    }

                    var position = snapshot.data!;
                    controllerRegistration.longitude.value =
                        position.longitude.toString();
                    controllerRegistration.latitude.value =
                        position.latitude.toString();
                    return FutureBuilder<String?>(
                        future: getAddressFromCurrentLocation(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFA7713F),
                                  // backgroundColor: appPrimaryColor,
                                  // strokeWidth: 3,
                                ));
                          }
                          controllerRegistration.address.value =
                              snapshot.data ?? "No Address Found";
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/icon_location_large.svg"),
                              GradientText(
                                  text: "Add Location",
                                  style: AppFonts.titleLogin,
                                  gradient: AppColors.buttonColor).marginOnly(
                                top: 45.sp,
                              ),
                              Text(
                                "Guide Users to where they will have a blast",
                                style: AppFonts.subtitle,
                              ),
                              Text(
                                controllerRegistration.address.value,
                                style: AppFonts.subtitle,
                              ).marginOnly().marginSymmetric(vertical: 20.h),
                              Spacer(),
                              CustomSelectbaleButton(
                                onTap: () {
                                  if (controllerRegistration
                                          .longitude.value.isNotEmpty &&
                                      controllerRegistration
                                          .latitude.value.isNotEmpty &&
                                      controllerRegistration
                                          .address.value.isNotEmpty) {
                                    if (widget.user == null) {
                                      Get.to(ScreenAmenitiesInfdividual(
                                        step: controllerRegistration
                                                    .userType.value ==
                                                "individual_event_organizer"
                                            ? "4/5"
                                            : "7/9",
                                      ));
                                    } else {
                                      controllerRegistration.updateClub(
                                          club: club!, f_name: widget.user!.fName?? "Test", descrption: widget.user!.reference!.description?? "Test Decription",
                                          location: controllerRegistration
                                              .address.value,
                                          latitude: controllerRegistration
                                              .latitude.value,
                                          longitude: controllerRegistration
                                              .longitude.value, phone: widget.user!.phone??"");
                                    }
                                  }
                                },
                                borderRadius: BorderRadius.circular(20),
                                width: Get.width,
                                height: 54.h,
                                strokeWidth: 1,
                                gradient: AppColors.buttonColor,
                                titleButton: "Add Location",
                              ),
                            ],
                          ).marginSymmetric(
                            horizontal: 15.sp,
                            vertical: 15.sp,
                          );
                        });
                  });
            }),
      ),
    );
  }
}
