import 'dart:developer';
import 'dart:io';

import 'package:blaxity/controllers/event_controllers/create_event_controller.dart';
import 'package:blaxity/models/event.dart' as model;
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/widgets/custom_counter_values_create_group.dart';
import 'package:blaxity/widgets/custom_divider_gradient.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_check_box.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_image_picker_container.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenCreateEventIndividual extends StatefulWidget {
 User? user;
 model.Event? event;
 bool? isHome;
  @override
  State<ScreenCreateEventIndividual> createState() =>
      _ScreenCreateEventIndividualState();

 ScreenCreateEventIndividual({
    this.user,
    this.event,
   this.isHome=false
 });
}

class _ScreenCreateEventIndividualState
    extends State<ScreenCreateEventIndividual> {

  ControllerCreateEvent controllerCreateEvent = Get.put(
      ControllerCreateEvent());
  @override
  void initState() {
    if (widget.event!=null) {
      controllerCreateEvent.eventTitleController.text=widget.event!.title??"";
      controllerCreateEvent.eventDescriptionController.text=widget.event!.description ??"";
      controllerCreateEvent.eventDateController.text=widget.event!.date??"";
      controllerCreateEvent.eventTimeController.text=widget.event!.time??'';
      controllerCreateEvent.locationController.text=widget.event!.location??"";
      controllerCreateEvent.eventPricing.value="${widget.event!.entrancePrice?? 0}";
      controllerCreateEvent.eventPrivacy.value=widget.event!.privacy!;
      controllerCreateEvent.selectPartyType.value=widget.event!.typeOfParty!;
      controllerCreateEvent.capacityLimited.value=widget.event!.capacityLimited=="1"?true:false;
      controllerCreateEvent.eventPricing.value=widget.event!.pricing?? "";


    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.user!=null) {
      if (widget.user!.userType=="club_event_organizer") {
        controllerCreateEvent.locationController.text=widget.user!.clubs![0].location??"";
      }
      // else{
      //   // controllerCreateEvent.locationController.text=widget.user!.reference!.location??"";
      // }
    }
    // log("user type =  ${widget.user!.userType}");
    return SafeArea(
      child: Scaffold(
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
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             widget.user!.userType=="club_event_organizer"?
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(text: "Create Event", style: AppFonts.titleLogin, gradient: AppColors.buttonColor,),
                  SvgPicture.asset("assets/icons/upload.svg")
                ],
              ): GradientText(text: "Party Calendar", style: AppFonts.titleLogin, gradient: AppColors.buttonColor,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create Events with Ease.",
                  style: AppFonts.subtitle,
                ),
              ),
              MyInputField(
                readOnly: true,
                hint: "Add Event",
              ),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              MyInputField(
                readOnly: true,
                hint: "Event Cover Image",
                suffix: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return AppColors.buttonColor.createShader(bounds);
                  },
                  child: Icon(
                    Icons.image_outlined,
                    size: 24,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomImagePickerContainer(
                  onImagePicked: (value) {
                    controllerCreateEvent.image = XFile(value);
                  },
                ),
              ),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              MyInputField(
                hint: "Title",
                controller: controllerCreateEvent.eventTitleController,
              ),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              MyInputField(
                hint: "Description",
                controller: controllerCreateEvent.eventDescriptionController,
              ),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              MyInputField(
                readOnly: true,

                hint: "Select Day",
                controller: controllerCreateEvent.eventDateController,
                suffix: InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Color(0xFFA7713F),
                              // header background color
                              onPrimary: Colors.black,
                              // header text color
                              onSurface: Colors.black, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors
                                    .black, // button text color
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
                      controllerCreateEvent.eventDateController.text = "${picked
                          .toLocal()}".split(' ')[0];
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
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              MyInputField(
                hint: "Select Time",
                controller: controllerCreateEvent.eventTimeController,
                readOnly: true,
                suffix: InkWell(
                  onTap: () {
                    showTimePicker(
                        context: context, initialTime: TimeOfDay.now()).then((
                        value) {
                      controllerCreateEvent.eventTimeController.text = value!.format(context).toString();
                    });
                  },
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColors.buttonColor.createShader(bounds);
                    },
                    child: Icon(
                      Icons.watch_later_outlined,
                      size: 24,
                    ),
                  ),
                ),
              ),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                    text: "Type of Party",
                    style: AppFonts.subscriptionTitle,
                    gradient: AppColors.buttonColor),
              ).marginSymmetric(
                vertical: 10.sp,
              ),
              Wrap(children:
              List.generate(
                  controllerCreateEvent.optionsParties.length,
                      (value) {
                    return Obx(() {
                      return IntrinsicWidth(
                        child: _buildSelectOneOption(
                            controllerCreateEvent.optionsParties[value],
                                () {
                              controllerCreateEvent.selectPartyType.value =
                              controllerCreateEvent.optionsParties[value];
                            },
                            controllerCreateEvent.selectPartyType.value ==
                                controllerCreateEvent.optionsParties[value]),
                      );
                    });
                  }
              )
                ,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(text: "Set Your Event Privacy",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor)).marginOnly(
                top: 6.sp,
              ),

              Obx(() {
                return CustomCheckbox(
                  isSelected: controllerCreateEvent.eventPrivacy.value ==
                      'Public',
                  onChanged: (isSelected) {
                    if (isSelected) {
                      controllerCreateEvent.eventPrivacy.value = 'Public';
                    }
                    else {
                      controllerCreateEvent.eventPrivacy.value = '';
                    }
                  },
                  titleText: "Public",
                );
              }),
              Obx(() {
                return CustomCheckbox(
                  isSelected: controllerCreateEvent.eventPrivacy.value ==
                      'Private',
                  onChanged: (isSelected) {
                    if (isSelected) {
                      controllerCreateEvent.eventPrivacy.value = 'Private';
                    }
                    else {
                      controllerCreateEvent.eventPrivacy.value = '';
                    }
                  },
                  titleText: "Private",
                );
              }).marginSymmetric(vertical: 8.h),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),

              Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(text: "Set Your Event Pricing",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor)).marginOnly(
                top: 15.sp,
              ),
              Obx(() {
                return CustomCheckbox(
                  isSelected: controllerCreateEvent.eventPricing.value ==
                      'Free',
                  onChanged: (isSelected) {
                    if (isSelected) {
                      controllerCreateEvent.eventPricing.value = 'Free';
                    }
                    else {
                      controllerCreateEvent.eventPricing.value = '';
                    }
                  },
                  titleText: "Free",
                );
              }),
              Obx(() {
                return CustomCheckbox(
                  isSelected: controllerCreateEvent.eventPricing.value ==
                      'Paid',
                  onChanged: (isSelected) {
                    if (isSelected) {
                      controllerCreateEvent.eventPricing.value = 'Paid';
                    }
                    else {
                      controllerCreateEvent.eventPricing.value = '';
                    }
                  },
                  titleText: "Paid",
                );
              }).marginSymmetric(vertical: 8.h),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              Obx(() {
                return (controllerCreateEvent.eventPricing.value == 'Paid')
                    ? Column(
                  children: [
                    MyInputField(
                      hint: "Enter Price",
                      controller: controllerCreateEvent.entrancePriceController,
                      keyboardType: TextInputType.number,
                    ),
                    GradientDivider(gradient: AppColors.buttonColor,
                      width: Get.width,
                      thickness: .3,),
                  ],
                )
                    : SizedBox();
              }),

              Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(text: "Event Capacity Options",
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor)).marginOnly(
                top: 15.sp,
              ),
              Obx(() {
                return CustomCheckbox(
                  isSelected: controllerCreateEvent.capacity.value == 'Limited',
                  onChanged: (isSelected) {
                    if (isSelected) {
                      controllerCreateEvent.capacity.value = 'Limited';
                      controllerCreateEvent.capacityLimited.value = true;
                    }
                    else {
                      controllerCreateEvent.capacityLimited.value = false;
                      controllerCreateEvent.capacity.value = '';
                    }
                  },
                  titleText: "Limited",
                );
              }),
              Obx(() {
                return CustomCheckbox(
                  isSelected: controllerCreateEvent.capacity.value ==
                      'Not Limited',
                  onChanged: (isSelected) {
                    if (isSelected) {
                      controllerCreateEvent.capacity.value = 'Not Limited';
                      controllerCreateEvent.capacityLimited.value = false;
                    }
                    else {
                      controllerCreateEvent.capacity.value = '';
                      controllerCreateEvent.capacityLimited.value = false;
                    }
                  },
                  titleText: "Not Limited",
                );
              }).marginSymmetric(vertical: 8.h),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              Obx(() {
                return (controllerCreateEvent.capacityLimited.value == true)
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("If Limited: Set Attendee Limit",
                      style: AppFonts.subtitleImagePickerButtonColor,)
                        .marginOnly(
                      top: 10.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w,),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${controllerCreateEvent.attendeeLimit.value}',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: controllerCreateEvent.increment,
                              child: Icon(
                                size: 18.sp,
                                Icons.keyboard_arrow_up,
                                color: Color(0xFFB48650),
                              ),
                            ),
                            InkWell(
                              onTap: controllerCreateEvent.decrement,
                              child: Icon(
                                size: 18.sp,
                                Icons.keyboard_arrow_down,
                                color: Color(0xFFB48650),
                              ),
                            ),
                          ],
                        ).marginOnly(
                          left: 5.sp,
                        ),
                      ],
                    ).marginOnly(
                      top: 5.sp,
                    ),
                  ],
                )
                    : SizedBox();
              }),
              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .3,),
              MyInputField(
                controller: controllerCreateEvent.locationController,
                hint: "Location (added by the club)",
              ),

              GradientDivider(gradient: AppColors.buttonColor,
                width: Get.width,
                thickness: .2,),

              Obx(() {
                return CustomSelectbaleButton(
                  isLoading: controllerCreateEvent.isLoading.value,
                  onTap: () async {

                   if (widget.event==null) {
                     await controllerCreateEvent.CreateEvent(widget.isHome!,widget.user!);

                   }
                   else{
                     await controllerCreateEvent.updateEvent(widget.event!);
                   }
                    // Get.to(HomeScreen());
                  },
                  borderRadius: BorderRadius.circular(20),
                  width: Get.width,
                  height: 54.h,
                  strokeWidth: 1,
                  gradient: AppColors.buttonColor,
                  titleButton: "Save",
                );
              }).marginSymmetric(vertical: 20.h),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectOneOption(String label, VoidCallback onTap,
      bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(6.sp),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.transparent : Colors.white, width: 1),
          borderRadius: BorderRadius.circular(20),
          gradient: isSelected ? AppColors.buttonColor : null,
          color: isSelected ? null : Colors.transparent,
        ),
        child: Text(label, style: AppFonts.subtitleImagePickerButtonColor),
      ),
    );
  }
}
