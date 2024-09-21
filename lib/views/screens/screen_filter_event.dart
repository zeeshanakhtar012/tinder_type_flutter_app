import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../widgets/custom_chip_choice.dart';
import '../../widgets/custom_selectable_button.dart';
import '../../widgets/custom_switch_button_filter.dart';
import '../../widgets/custom_toggle_switch.dart';
import '../../widgets/custom_toggle_switch_filter.dart';

class ScreenFilterEvent extends StatefulWidget {
  @override
  State<ScreenFilterEvent> createState() => _ScreenFilterEventState();
}

class _ScreenFilterEventState extends State<ScreenFilterEvent> {
  final EventController _controller = Get.find(); // Use GetX to get your controller

  RxList<String> sortByOptions = ["relevance", "date"].obs;
  List<String> filterOptions = [
    'Board Games',
    'TV',
    'Coffee',
    'Climbing',
    'Yoga',
    'Concerts'
  ];
  List<String> eventOption = [
    'TV',
    'Convention',
    'Expo',
    'Seminar',
    'Conference'
  ];
  List<String> languageOption = [
    'Italian',
    'French',
    'Spanish',
    'German',
    'English'
  ];
  List<String> selectedLanguageOption = [];

  RxString sortBy = "relevance".obs;
  RxString isFree = "free".obs;
  RxString selectedCategory = "".obs;
  RxString selectedEvent = "".obs;

  @override
  Widget build(BuildContext context) {
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
            "assets/images/image_profile_appBar.png",
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
                  GradientText(
                    text: "Filters",
                    style: AppFonts.titleLogin,
                    gradient: AppColors.buttonColor,
                  ),
                  GestureDetector(
                    onTap: _clearFilters,
                    child: Text(
                      "Clear all",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Text("Categories", style: AppFonts.subscriptionTitle).marginOnly(top: 15.h),
              Wrap(
                children: List.generate(
                  filterOptions.length,
                      (index) {
                    return Obx(() {
                      return IntrinsicWidth(
                        child: buildSelectOneOption(
                          filterOptions[index],
                              () {
                            selectedCategory.value = filterOptions[index];
                          },
                          selectedCategory.value == filterOptions[index],
                        ),
                      );
                    });
                  },
                ),
              ),
              Text("Events", style: AppFonts.subscriptionTitle).marginOnly(top: 15.h),
              Wrap(
                children: List.generate(
                  eventOption.length,
                      (index) {
                    return Obx(() {
                      return IntrinsicWidth(
                        child: buildSelectOneOption(
                          eventOption[index],
                              () {
                            selectedEvent.value = eventOption[index];
                          },
                          selectedEvent.value == eventOption[index],
                        ),
                      );
                    });
                  },
                ),
              ),
              _buildFilterSection(
                "Language",
                languageOption,
                selectedLanguageOption,
                    (selectedItems) {
                  setState(() {
                    selectedLanguageOption = selectedItems;
                  });
                },
              ),
              Text("Price", style: AppFonts.subscriptionTitle).marginOnly(top: 15.h),
              Obx(() {
                return SwitchListTile(
                  activeColor: Color(0xFFA7713F),

                  title: Text("Only free events"),
                  value: isFree.value == "free",
                  onChanged: (value) {
                    isFree.value = value ? "free" : "paid";
                  },
                );
              }),
              Text("Sort by", style: AppFonts.subscriptionTitle),
              Obx(() {
                return Row(
                  children: List.generate(sortByOptions.length, (index) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          sortBy.value = sortByOptions[index];
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: sortBy.value == sortByOptions[index] ? AppColors.buttonColor : null,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            sortByOptions[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: sortBy.value == sortByOptions[index] ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
              CustomSelectbaleButton(
                onTap: _applyFilters,
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Apply filters",
              ).marginOnly(top: 30.h),
            ],
          ).marginSymmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options,
      List<String> selectedOptions, Function(List<String>) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppFonts.subscriptionTitle).marginOnly(top: 15.h),
        CustomChipsChoice<String>(
          options: options,
          selectedOptions: selectedOptions,
          onChanged: onChanged,
        ).marginOnly(top: 6.h),
        GradientText(
          text: "Show all categories",
          style: AppFonts.subtitle,
          gradient: AppColors.buttonColor,
        ),
      ],
    );
  }

  Widget buildSelectOneOption(String option, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.buttonColor : null,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white),
        ),
        alignment: Alignment.center,
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _applyFilters() {
    String? category = selectedCategory.value.isNotEmpty ? selectedCategory.value : null;
    String? eventType = selectedEvent.value.isNotEmpty ? selectedEvent.value : null;
    String? languages = selectedLanguageOption.isNotEmpty ? selectedLanguageOption.join(',') : null;
    String? pricing = isFree.value;
    String? sort = sortBy.value;

    // Call the fetchEvents method from your EventController
    _controller.fetchEvents(
      search: category,
      typeOfParty: eventType,
      languages: languages,
      pricing: pricing,
      sortBy: sort,
    );

    Get.back(); // Navigate back or show results
  }

  void _clearFilters() {
    setState(() {
      selectedCategory.value = "";
      selectedEvent.value = "";
      selectedLanguageOption.clear();
      isFree.value = "free";
      sortBy.value = "relevance";
    });
  }
}
