import 'package:blaxity/views/screens/screen_clubs/screen_wait_list_club.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_check_box.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_counter_values_create_group.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_image_picker_container.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';

class ScreenCreateFirstEventClub extends StatefulWidget {
  const ScreenCreateFirstEventClub({super.key});

  @override
  State<ScreenCreateFirstEventClub> createState() => _ScreenCreateFirstEventClubState();
}

class _ScreenCreateFirstEventClubState extends State<ScreenCreateFirstEventClub> {
  List<String> optionsParties = ['Meet & Greet','Swinger Cruise','House Party','Glow Party','Key Party','Swinger Resort',];
  List<String> selectedOptions = [];
  bool showText = false;
  RxString dateOfBirth = ''.obs;
  String selectedPrivacy = '1';
  void _handleCheckboxChange(String privacy) {
    setState(() {
      selectedPrivacy = privacy;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("8/8", style: AppFonts.personalinfoAppBar,),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(text: "Add First Event", style: AppFonts.titleLogin, gradient: AppColors.buttonColor),
                  SvgPicture.asset("assets/icons/icon_share.svg")
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create Events with Ease.",
                  style: AppFonts.subtitle,
                ),
              ),
              MyInputField(
                hint: "Add Event",
              ),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              MyInputField(
                hint: "Event Cover Image",
                suffix: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return AppColors.buttonColor.createShader(bounds);
                  },
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        showText= !showText;
                      });
                    },
                    child: Icon(
                      Icons.image_outlined,
                      size: 24,
                    ),
                  ),
                ),
              ),
              if(showText)
                Align(
                  alignment: Alignment.center,
                  child: CustomImagePickerContainer(
                    // icon: Icons.image,
                    backgroundColor: Colors.transparent,
                    height: 150.h,
                    iconSize: 44.sp,
                    width: 200.w,
                  ),
                ),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              MyInputField(
                hint: "Title",
              ),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              MyInputField(
                hint: "Description",
              ),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              MyInputField(
                onChange: (value) => dateOfBirth.value = value!,
                hint: "Select Day",
                controller: TextEditingController(text: dateOfBirth.value),
                suffix: InkWell(
                  onTap: ()async{
                    final DateTime? picked = await showDatePicker(
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Color(0xFFA7713F), // header background color
                              onPrimary: Colors.black, // header text color
                              onSurface: Colors.black, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != DateTime.now()) {
                      dateOfBirth.value = "${picked.toLocal()}".split(' ')[0];
                      setState(() {

                      });
                    }
                  },
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColors.buttonColor.createShader(bounds);
                    },
                    child: Icon(
                      Icons.calendar_month,
                      size: 24,
                    ),
                  ),
                ),
              ),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              MyInputField(
                hint: "Select Time",
                suffix: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return AppColors.buttonColor.createShader(bounds);
                  },
                  child: Icon(
                    Icons.watch_later_outlined,
                    size: 24,
                  ),
                ),
              ),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                    text: "Type of Party",
                    style: AppFonts.subscriptionTitle,
                    gradient: AppColors.buttonColor),
              ).marginSymmetric(
                vertical: 10.sp,
              ),
              CustomChipsChoice<String>(
                options: optionsParties,
                selectedOptions: selectedOptions,
                onChanged: (List<String> selectedItems) {
                  setState(() {
                    selectedOptions = selectedItems;
                  });
                },
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(text: "Set Your Event Privacy",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor)).marginOnly(
                top: 6.sp,
              ),
              // CustomCheckbox(
              //   isSelected: selectedPrivacy,
              //   onChanged: (isSelected) {
              //     // controllerRegister.piercing.value = isSelected;
              //     print(isSelected);
              //   },
              //   titleText: "Public",
              // ),
              // CustomCheckbox(
              //   isSelected: selectedPrivacy,
              //   onChanged: (isSelected) {
              //     // controllerRegister.piercing.value = isSelected;
              //     print(isSelected);
              //   },
              //   titleText: "Private",
              // ).marginSymmetric(vertical: 6.sp),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),

              Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(text: "Set Your Event Pricing",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor)).marginOnly(
                top: 15.sp,
              ),
              // CustomCheckbox(
              //   isSelected: selectedPrivacy,
              //   onChanged: (isSelected) {
              //     // controllerRegister.piercing.value = isSelected;
              //     print(isSelected);
              //   },
              //   titleText: "Public",
              // ),
              // CustomCheckbox(
              //   isSelected: selectedPrivacy,
              //   onChanged: (isSelected) {
              //     // controllerRegister.piercing.value = isSelected;
              //     print(isSelected);
              //   },
              //   titleText: "Private",
              // ).marginSymmetric(vertical: 6.sp),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(text: "Event Capacity Options",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor)).marginOnly(
                top: 15.sp,
              ),
              // CustomCheckbox(
              //   isSelected: selectedPrivacy,
              //   onChanged: (isSelected) {
              //     // controllerRegister.piercing.value = isSelected;
              //     print(isSelected);
              //   },
              //   titleText: "Public",
              // ),
              // CustomCheckbox(
              //   isSelected: selectedPrivacy,
              //   onChanged: (isSelected) {
              //     // controllerRegister.piercing.value = isSelected;
              //     print(isSelected);
              //   },
              //   titleText: "Private",
              // ).marginSymmetric(vertical: 6.sp),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .3,),
              Text("If Limited: Set Attendee Limit", style: AppFonts.subtitleImagePickerButtonColor,).marginOnly(
                top: 10.sp,
              ),
              CustomCounter().marginOnly(
                top: 5.sp,
              ),
              MyInputField(
                hint: "Location (added by the club)",
              ),
              GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .2,),
              CustomSelectbaleButton(
                onTap: (){
                  // Get.to(ScreenWaitListClub());
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Save",
              ),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }
}
