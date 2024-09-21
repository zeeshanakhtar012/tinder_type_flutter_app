import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/layouts/item_bottom_sheets_edit_profile_info/item_eye_color_bottomSheet.dart';
import 'package:blaxity/widgets/custom_divider_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_selectable_button.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_attributes.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_body_type.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_desires.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_drink_details.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_education.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_ethnicity.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_height_bottomSheet.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_hobbies.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_language.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_location.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_lookingFor.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_parties.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_safety_practices.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_show_more.dart';
import '../layouts/item_bottom_sheets_edit_profile_info/item_smoke_details.dart';

class ScreenEditProfile extends StatefulWidget {
  // final bool? isEventProfile;
  // final bool? isCoupleProfile;
  ScreenEditProfile(
      {
      // this.isCoupleProfile = false,
      // this.isEventProfile = false,
      super.key});

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  @override
  Widget build(BuildContext context) {
    ControllerHome _controllerHome = Get.put(ControllerHome());
    double _sliderValue = 0.0;
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
        body: Obx(() {
          if (_controllerHome.isLoading.value) {
            return Center(child: CircularProgressIndicator(
              color: Color(0xFFA26837),
            ));
          } else {
            User user = _controllerHome.user.value!.user;
            return RefreshIndicator(
              color: AppColors.appColor,
              onRefresh: () async {

                await _controllerHome.fetchUserInfo();
              },
              child
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    // if(isCoupleProfile == true)
                    Column(
                      children: [
                       if(user.userType!="single")Column(
                         // crossAxisAlignment: s,
                         children: <Widget>[
                           InkWell(
                             onTap: () {
                               ItemHeightBottomSheet.show(context, user);
                             },
                             child: Row(
                               children: [
                                 Text(
                                   "Height",
                                   style: AppFonts.titleWelcome,
                                 ),
                                 Spacer(),
                                 Text(
                                   "Select",
                                   style: AppFonts.resendEmailStyle,
                                 ),
                                 Icon(
                                   Icons.arrow_forward_ios,
                                   color: Colors.white,
                                 )
                               ],
                             ),
                           ),
                           Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                         ],
                       ),
                        InkWell(
                          onTap: () {
                            ItemEyeColorBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Eye color",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemEthnicityBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Ethnicity",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemEducationBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Education",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemLanguageBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Language",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemDrinkDetailsBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "How often do you drink?",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemSmokeDetailsBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "How often do you smoke?",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemBodyTypeBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "What’s your Body Type?",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemSafetyPracticesBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Safety Practices",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemHobbiesBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Hobbies",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemDesiresBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Desires",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemPartiesBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Parties",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemLookingForBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "What are you looking for?",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                        InkWell(
                          onTap: () {
                            ItemAttributesBottomSheet.show(context, user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Attributes",
                                style: AppFonts.titleWelcome,
                              ),
                              Spacer(),
                              Text(
                                "Select",
                                style: AppFonts.resendEmailStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ).marginOnly(
                            top: 20.sp,
                          ),
                        ),
                        Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 4.h),
                                            ],
                    ).marginSymmetric(
          horizontal: 15.w,
          vertical: 15.h,
          ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GradientText(
                        text: "DISCOVERY",
                        style: AppFonts.titleLogin,
                        gradient: AppColors.buttonColor,
                      ).marginOnly(
                        top: 10.sp,
                      ),
                    ).marginSymmetric(horizontal: 15.w),
                    InkWell(
                      onTap: () {
                        ItemLocationBottomSheet.show(context, user);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Location",
                            style: AppFonts.titleWelcome,
                          ),
                          Spacer(),
                          Text(
                            user.reference!.location ?? "No Location ",
                            style: AppFonts.resendEmailStyle,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ).marginOnly(
                        top: 20.sp,
                      ),
                    ).marginSymmetric(horizontal: 15.w),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 6.h,left: 15.w,right: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: GradientText(
                        text: "Maximum Distance",
                        style: AppFonts.subtitle,
                        gradient: AppColors.buttonColor,
                      ).marginOnly(
                        top: 10.sp,
                      ),
                    ).marginSymmetric(horizontal: 15.w),
                    StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Color(0xFFA7713F),
                            inactiveTrackColor: Colors.grey,
                            trackHeight: 4.0,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                            valueIndicatorTextStyle: TextStyle(color: Colors.white, fontSize: 9),
                            showValueIndicator: ShowValueIndicator.always,
                          ),
                          child: Slider(
                            value: _distanceSliderValue,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            label: _distanceSliderValue.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                _distanceSliderValue = value;
                              });
                              _saveDistanceSliderValue(value); // Save the distance slider value
                            },
                          ),
                        ).marginOnly(top: 20.sp);
                      },
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Show people further away if i run out of profiles to see.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ).marginSymmetric(horizontal: 15.w),
                    InkWell(
                      onTap: () {
                        ItemShowMoreBottomSheet.show(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Show me",
                            style: AppFonts.titleWelcome.copyWith(
                              fontSize: 16.sp

                            ),
                          ),
                          Spacer(),
                          Text(
                            _selectedShowMeOption,
                            style: AppFonts.resendEmailStyle,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ).marginOnly(
                        top: 20.sp,
                      ),
                    ).marginSymmetric(horizontal: 15.w),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 6.h,left: 15.w,right: 15),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GradientText(
                            text: "Age Range",
                            style: AppFonts.subtitle.copyWith(fontSize: 16.sp
                            ),
                            gradient: AppColors.buttonColor,
                          ).marginOnly(
                            top: 10.sp,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${_ageRangeMinValue.round()} - ${_ageRangeMaxValue.round()}",
                          style: AppFonts.resendEmailStyle,
                        ),
                      ],
                    ).marginSymmetric(horizontal: 15.w),
                    StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Color(0xFFA7713F),
                            inactiveTrackColor: Colors.grey,
                            trackHeight: 4.0,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 8.0),
                            overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                            valueIndicatorTextStyle:
                            TextStyle(color: Colors.white, fontSize: 9),
                            showValueIndicator: ShowValueIndicator.always,
                          ),
                          child: RangeSlider(
                            max: 100,
                            min: 1,
                            values: RangeValues(_ageRangeMinValue, _ageRangeMaxValue), onChanged: (RangeValues value) {
                            setState(() {
                              _ageRangeMinValue = value.start;
                              _ageRangeMaxValue = value.end;
                            });
                            _saveAgeRangeSliderValues(_ageRangeMinValue,
                                _ageRangeMaxValue);
                          },).marginOnly(top: 20.sp),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Show people slightly out of my preferred range if i run out\nof profile to see.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ).marginSymmetric(horizontal: 15.w),
                    SizedBox(height: 20.h,)
                    // if(isEventProfile== true)
                  ],
                )
              ),
            );
          }
        }),
      ),
    );
  }

  double _distanceSliderValue = 0.0;

  double _ageRangeMinValue = 18.0;

  double _ageRangeMaxValue = 60.0;

  void _loadSliderValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _distanceSliderValue = prefs.getDouble('distanceSliderValue') ?? 0.0;
      _ageRangeMinValue = prefs.getDouble('ageRangeMinValue') ?? 18.0;
      _ageRangeMaxValue = prefs.getDouble('ageRangeMaxValue') ?? 60.0;
    });
  }

// Save the distance slider value to SharedPreferences
  void _saveDistanceSliderValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('distanceSliderValue', value);
  }

// Save the age range slider values to SharedPreferences
  void _saveAgeRangeSliderValues(double minValue, double maxValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('ageRangeMinValue', minValue);
    prefs.setDouble('ageRangeMaxValue', maxValue);
  }
  void _loadShowMeOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedShowMeOption = prefs.getString('selectedShowMeOption') ?? "Everyone";
    });
  }
  String _selectedShowMeOption = "Everyone"; // Default value

  @override
  void initState() {
    _loadSliderValues();
    _loadShowMeOption();

    // TODO: implement initState
    super.initState();
  }
}
