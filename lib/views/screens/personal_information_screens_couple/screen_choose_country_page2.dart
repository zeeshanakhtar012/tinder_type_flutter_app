import 'dart:developer';
import 'dart:ffi';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_date_of_birth3.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_identity_verification.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../constants/location_utils.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../main.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenChooseCountry extends StatefulWidget {
  String step;
  User? user;

  @override
  State<ScreenChooseCountry> createState() => _ScreenChooseCountryState();

  ScreenChooseCountry({
    required this.step,
    this.user,
  });
}

class _ScreenChooseCountryState extends State<ScreenChooseCountry> {
  RxString selectCountry = "".obs;
  RxString city = "".obs;
  RxString state = "".obs;
  var cities = <String>[].obs;
  // late LocationData locationData;

  void updateCityList(String selectedCountry, Map<String, List<String>> countryCityData) {
    cities.value = countryCityData[selectedCountry] ?? [];
    if (cities.value.isNotEmpty) {
      city.value = cities.first;
    } else {

    } // Reset the city selection
  }
  @override
  Widget build(BuildContext context) {
    final controllerRegister = Get.put(ControllerRegistration());

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
                    child: CircularProgressIndicator(
                  backgroundColor: Color(0xFFA26837),
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
                          child: CircularProgressIndicator(
                        color: Color(0xFFA26837),
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
                              color: Color(0xFFA26837),
                              // strokeWidth: 3,
                            ));
                          } else if (snapshot.data == null) {
                            return Center(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: Text("Please Try Again"),
                              ),
                            );
                          }
                          var placemarks = snapshot.data!;
                          var locality = placemarks.locality;
                          var name = placemarks.name;
                          var country = placemarks.country;
                          var subAdminArea = placemarks.subAdministrativeArea;
                          controllerRegister.address.value =
                              "${locality != null ? locality + ", " : ""}${name != null ? name + ", " : ""}${subAdminArea != null ? subAdminArea + ", " : ""}${country != null ? country : ""}" ??
                                  "No Address Found";
                          controllerRegister.country.value = country!;
                          controllerRegister.cityController.text =
                              locality ?? "";
                          updateCityList(country!, locationData!.countryCityData); // Optionally update city list

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientText(
                                text: "Choose Your country",
                                style: AppFonts.titleLogin,
                              ),
                              Text(
                                "Please select your country to help us give you a\nbetter experience.",
                                style: AppFonts.subtitle,
                              ),
                              Obx(() {
                                return DropdownButton<String>(
                                  isExpanded: true, // Set the dropdown to expand to the full width of the screen
                                  hint: Text("Select Country"), // Set the hint text
                                  underline: SizedBox(), // Remove the underline
                                  icon: Icon(Icons.keyboard_arrow_down), // Optional: Customize the dropdown icon
                                  value: controllerRegister.country.value, // Do not display the selected value in the dropdown
                                  onChanged: (newCountry) {
                                    if (newCountry != null) {
                                      controllerRegister.country.value = newCountry; // Save the selected country to the controller
                                      updateCityList(newCountry, locationData!.countryCityData); // Optionally update city list
                                    }
                                  },
                                  items: locationData!.countryCityData.keys.map((country) {
                                    return DropdownMenuItem(
                                      value: country,
                                      child: Text(country),
                                    );
                                  }).toList(),
                                );
                              }),
                              GradientDivider(
                                thickness: 0.3,
                                gradient: AppColors.buttonColor,
                                width: Get.width,
                              ),
                              Obx(() {
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Select City"),
                                  // Set the dropdown to expand to the full width of the screen
                                  underline: SizedBox(), // Remove the underline
                                  icon: Icon(Icons.keyboard_arrow_down), // Optional: Customize the dropdown icon
                                  value: city.value.isEmpty?null:city.value, // Do not display the selected value in the dropdown button
                                  onChanged: (newCity) {
                                    if (newCity != null) {
                                      city.value = newCity; // Save the selected city to the controller
                                    }
                                  },
                                  items: cities.map((city) {
                                    return DropdownMenuItem(
                                      value: city,
                                      child: Text(city),
                                    );
                                  }).toList(),
                                );
                              }),
                              GradientDivider(
                                thickness: 0.3,
                                gradient: AppColors.buttonColor,
                                width: Get.width,
                              ),
                              // Obx(() {
                              //   return DropdownButton<String>(
                              //     value: controllerRegister.country.value.isEmpty
                              //         ? null
                              //         : controllerRegister.country.value,
                              //
                              //     hint: Text("Select Country"),
                              //     onChanged: (newCountry) {
                              //       if (newCountry != null) {
                              //         controllerRegister.country.value = newCountry;
                              //         updateCityList(newCountry, locationData!.countryCityData);
                              //       }
                              //     },
                              //     items: locationData!.countryCityData.keys.map((country) {
                              //       return DropdownMenuItem(
                              //         value: country,
                              //         child: Text(country),
                              //       );
                              //     }).toList(),
                              //   );
                              // }),
                              // GradientDivider(
                              //   thickness: 0.3,
                              //   gradient: AppColors.buttonColor,
                              //   width: Get.width,
                              // ),
                              // GradientDivider(
                              //   thickness: 0.3,
                              //   gradient: AppColors.buttonColor,
                              //   width: Get.width,
                              // ),
                              // Obx(() {
                              //   return DropdownButton<String>(
                              //     value: city.value.isEmpty ? null : city.value,
                              //     hint: Text("Select City"),
                              //     onChanged: (newCity) {
                              //       if (newCity != null) {
                              //         city.value = newCity;
                              //       }
                              //     },
                              //     items:cities.map((city) {
                              //       return DropdownMenuItem(
                              //         value: city,
                              //         child: Text(city),
                              //       );
                              //     }).toList(),
                              //   );
                              // }),
                              Spacer(),
                              Obx(() {
                                return CustomSelectbaleButton(
                                  isLoading: controllerRegister.isLoading.value,
                                  onTap: () async {
                                    log(" selected country : ${controllerRegister.country.value}");
                                    log(" selected city : ${controllerRegister.cityController.value}");
                                    if (controllerRegister
                                            .cityController.text.isNotEmpty &&
                                        controllerRegister.country.isNotEmpty) {
                                      if (controllerRegister.userType.value ==
                                          "couple") {
                                        Get.to(
                                          ScreenChooseDate(
                                            step: '3 of 11',
                                          ),
                                        );
                                      } else {
                                        await controllerRegister
                                            .updateCountry(widget.user!);
                                      }
                                    } else {
                                      FirebaseUtils.showError(
                                          "Please Enter Country and City");
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
                          ).marginSymmetric(
                            horizontal: 10.sp,
                            vertical: 10.sp,
                          );
                        });
                  });
            }),
      ),
    );
  }
}
