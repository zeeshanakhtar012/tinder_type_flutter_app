import 'dart:io';

import 'package:blaxity/controllers/controlller_create_group.dart';
import 'package:blaxity/models/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/custom_counter_values_create_group.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/my_input_feild.dart';

class ScreenCreateGroup extends StatelessWidget {
  Group? group;

  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    ControllerCreateGroup controller = Get.put(ControllerCreateGroup());
    if (group!=null) {
      controller.titleController.text=group!.title;
      controller.descriptionController.text=group!.description;
      controller.capacityLimited.value = group!.capacityLimited;
      controller.isPrivate.value = group!.isPrivate;
      controller.attendeeLimit.value = group!.attendeeLimit?? 0;
      // controller.locationController.text=group!.location;
    }


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                style: AppFonts.titleLogin,
                text: "Create Group",
                gradient: AppColors.buttonColor,
              ).marginSymmetric(
                  // vertical: 12.h,
                  horizontal: 8.w
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bring Your Circle Closer: Create Your\nGroup Today!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ).marginSymmetric(
                  // vertical: 12.h,
                  horizontal: 8.w
              ),
              InkWell(
                onTap: () => _pickImage(context, controller),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Picture",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                    SvgPicture.asset(
                        "assets/icons/icon_create_group_photo.svg"),
                  ],
                ).marginOnly(top: 20.h,
                left: 13.w,
                  right: 13.w,
                ),
              ),
              Obx(() {
                return (controller.imgFile.value.path.isNotEmpty) ?
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _pickImage(context, controller),
                    child: Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(controller.imgFile.value.path),
                          fit: BoxFit.cover,
                          width: 200.w,
                          height: 200.h,
                        ),
                      ),
                    ),
                  ),
                ) : SizedBox();
              }),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                vertical: 12.h,
              ),
              MyInputField(
                hint: "Title",
                controller: controller.titleController,
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                // vertical: 12.h,
              ),
              MyInputField(
                hint: "Description",
                controller: controller.descriptionController,
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                // vertical: 4.h,
              ),
              GradientText(
                gradient: AppColors.buttonColor,
                text: "Set Your Group Privacy",
                style: AppFonts.subscriptionTitle,
              ).marginSymmetric(
                vertical: 12.h,
                horizontal: 8.w
              ),
              Obx(
                    () =>
                    CustomCheckbox(
                      isSelected: !controller.isPrivate.value,
                      onChanged: (isSelected) {
                        controller.isPrivate.value = !isSelected;
                      },
                      titleText: "Public",
                    ).paddingSymmetric(vertical: 6.sp),
              ).marginSymmetric(
                  // vertical: 12.h,
                  horizontal: 8.w
              ),
              Obx(
                    () =>
                    CustomCheckbox(
                      isSelected: controller.isPrivate.value,
                      onChanged: (isSelected) {
                        controller.isPrivate.value = isSelected;
                      },
                      titleText: "Private",
                    ).paddingSymmetric(vertical: 6.sp),
              ).marginSymmetric(
                  // vertical: 12.h,
                  horizontal: 8.w
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
              ),
              GradientText(
                gradient: AppColors.buttonColor,
                text:
                "Group Capacity Options",
                style: AppFonts.subscriptionTitle,
              ).marginSymmetric(
                  vertical: 12.h,
                  horizontal: 8.w
              ),
              Obx(
                    () =>
                    CustomCheckbox(
                      isSelected: controller.capacityLimited.value,
                      onChanged: (isSelected) {
                        controller.capacityLimited.value = isSelected;
                      },
                      titleText: "Limited",
                    ).paddingSymmetric(vertical: 6.sp),
              ).marginSymmetric(
                  // vertical: 12.h,
                  horizontal: 8.w
              ),
              Obx(
                    () =>
                    CustomCheckbox(
                      isSelected: !controller.capacityLimited.value,
                      onChanged: (isSelected) {
                        controller.capacityLimited.value = !isSelected;
                      },
                      titleText: "Open",
                    ).marginSymmetric(vertical: 6.sp),
              ).marginSymmetric(
                  // vertical: 12.h,
                  horizontal: 8.w
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "If Limited: Set Members limit",
                  style: AppFonts.subtitleImagePickerButtonColor,
                ),
              ).marginSymmetric(
                  vertical: 12.h,
                  horizontal: 8.w
              ),
              Obx(
                    () =>
                (!controller.capacityLimited.value) ? SizedBox() :
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
                        '${controller.attendeeLimit.value}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: controller.increment,
                          child: Icon(
                            size: 18.sp,
                            Icons.keyboard_arrow_up,
                            color: Color(0xFFB48650),
                          ),
                        ),
                        InkWell(
                          onTap: controller.decrement,
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
                ).marginSymmetric(
                    // vertical: 12.h,
                    horizontal: 8.w
                )
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              SizedBox(
                height: 50.h
              ),
              Obx(() {
                return CustomButton(
                  loading: controller.isLoading.value,
                  text: "Create",
                  textColor: Colors.white,
                  buttonGradient: AppColors.buttonColor,
                  onTap: () async {
                    if (group==null) {
                      await controller.createGroup();
                    }  else{
                      await controller.updateGroup(group!.id);
                    }
                  },
                );
              }).marginSymmetric(
                  vertical: 12.h,
                  horizontal: 8.w
              ),
            ],
          ).marginSymmetric(horizontal: 15.w, vertical: 15.h),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context,
      ControllerCreateGroup controller) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 800,
                    maxHeight: 800,
                  );
                  if (pickedFile != null) {
                    controller.imgFile.value = XFile(pickedFile.path);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 800,
                    maxHeight: 800,
                  );
                  if (pickedFile != null) {
                    controller.imgFile.value = XFile(pickedFile.path);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ScreenCreateGroup({
    this.group,
  });
}
