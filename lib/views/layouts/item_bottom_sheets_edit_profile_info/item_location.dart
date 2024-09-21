import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../constants/location_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_selectable_button.dart';

class ItemLocationBottomSheet {

  static void show(BuildContext context,User user) {
    ControllerRegistration controllerRegister=Get.put(ControllerRegistration());
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FutureBuilder<bool>(
                future: checkPermissionStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator.adaptive(
                          // backgroundColor: AppColors.,
                          strokeWidth: 3,
                        ));
                  }

                  if (!(snapshot.data ?? false)) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Location Permission Required",
                          ),
                          OutlinedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text("Retry",))
                        ],
                      ),
                    );
                  }

                  return FutureBuilder<Position>(
                      future: Geolocator.getCurrentPosition(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ));
                        }

                        var position = snapshot.data!;
                        controllerRegister.longitude.value =
                            position.longitude.toString();
                        controllerRegister.latitude.value =
                            position.latitude.toString();
                        return FutureBuilder<Placemark?>(
                            future: getAddressWithFromCurrentLocation(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                      // backgroundColor: appPrimaryColor,
                                      strokeWidth: 3,
                                    ));
                              }
                              else if(snapshot.data==null){
                                return Center(child: TextButton(onPressed: () {
                                  setState(() {

                                  });
                                }, child: Text("Please Try Again"),),);
                              }
                              var placemarks = snapshot.data!;
                              var locality = placemarks.locality;
                              var name = placemarks.name;
                              var country = placemarks.country;
                              var subAdminArea = placemarks.subAdministrativeArea;
                              controllerRegister.address.value =
                                  "${locality != null ? locality + ", " : ""}${name != null ? name + ", " : ""}${subAdminArea != null ? subAdminArea + ", " : ""}${country != null ? country : ""}" ?? "No Address Found";

                              return Container(
                                padding: EdgeInsets.all(16.0),
                                // height: 200.h,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 30.h,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(),

                                              Align(
                                                  alignment: Alignment.topCenter,
                                                  child: SvgPicture.asset("assets/icons/line.svg"))
                                                  .marginOnly(top: 7.h),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);

                                                },
                                                child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: SvgPicture.asset(
                                                        "assets/icons/cross.svg")),
                                              ),
                                            ],
                                          ),
                                        ).marginSymmetric(horizontal: 20.w, vertical: 10.h
                                        ),


                                        GradientText(
                                            text: "Location", style: AppFonts.subscriptionBlaxityGold).paddingSymmetric(
                                          vertical: 6.h,
                                        ),

                                        ListTile(
                                      title: Text("My Current Location", style: AppFonts.titleWelcome,),
                                      leading: ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return AppColors.buttonColor.createShader(bounds);
                                        },
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          size: 14,
                                        ),
                                      ),
                                      subtitle: Text(controllerRegister.address.value, style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8.sp
                                      ),),
                                    ),
                                    Obx(() {
                                      return CustomSelectbaleButton(
                                        isLoading: controllerRegister.isLoading.value,
                                        onTap: () async {

                                          if (controllerRegister.address.value.isNotEmpty) {
                                            await controllerRegister.updateCoupleProfile(
                                                user, location: controllerRegister.address.value,latitude: controllerRegister.latitude.value,longitude: controllerRegister.longitude.value);
                                            Get.back();
                                          }
                                          else {
                                            FirebaseUtils.showError("Please select your location.");
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(20),
                                        width: Get.width,
                                        height: 54.h,
                                        strokeWidth: 1,
                                        gradient: AppColors.buttonColor,
                                        titleButton: "Continue",
                                      );
                                    }),
                                  ],
                                ),
                              ])
                                );
                            }
                        );
                      }
                  );
                }
            );
          },
        );
      },
    );
  }
}
