import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';

class ScreenGoOut extends StatefulWidget {
  const ScreenGoOut({super.key});

  @override
  _ScreenGoOutState createState() => _ScreenGoOutState();
}

class _ScreenGoOutState extends State<ScreenGoOut> {
  RxString selectedOption = "anytime".obs; // For tracking the selected filter option
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null); // For storing the picked date
  final EventController _eventController = Get.find<EventController>(); // Assuming you have a controller to fetch and filter events

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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  text: "When do you want\nto go out?",
                  style: AppFonts.titleLogin,
                  gradient: AppColors.buttonColor,
                ),
              ),
              SizedBox(height: 20.h),
              _buildDateOption("Anytime", "anytime"),
              _buildDateOption("Today", "today"),
              _buildDateOption("Tomorrow", "tomorrow"),
              _buildDateOption("This Week", "this_week"),
              _buildDateOption("This Weekend", "this_weekend"),
              _buildDateOption("Choose a date...", "choose_date"),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build each selectable date option row
  Widget _buildDateOption(String text, String value) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          if (value == "choose_date") {
            _selectDate(context);
          } else {
            selectedOption.value = value;
            selectedDateTime.value = null; // Clear the selected date if a predefined option is selected
            _filterEventsBySelectedDay(value);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          // decoration: BoxDecoration(
          //   gradient: selectedOption.value == value ? AppColors.buttonColor : null,
          //   borderRadius: BorderRadius.circular(8),
          //   border: Border.all(
          //     color:  ? Colors.blueAccent : Colors.grey,
          //     width: 1,
          //   ),
          // ),
          child:
          selectedOption.value == value? GradientWidget(
            child: Row(
              children: [
                Center(
                  child: GradientText(
                    text:text,
                    style: TextStyle(
                      fontSize: 32.sp,
                    ),
                  ),
                ),
                Spacer(),

                  GradientWidget(
                    child: Icon(
                      Icons.check,
                    ),
                  ),
              ],
            ),
          ):
          Row(
            children: [
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    });
  }

  // Method to filter events based on the selected day
  void _filterEventsBySelectedDay(String selectedDay) {
    DateTime currentDate = DateTime.now();
    DateTime targetDate;

    switch (selectedDay) {
      case "today":
        targetDate = currentDate;
        break;
      case "tomorrow":
        targetDate = currentDate.add(Duration(days: 1));
        break;
      case "this_week":
        targetDate = currentDate.add(Duration(days: (7 - currentDate.weekday)));
        break;
      case "this_weekend":
        int daysToWeekend = 6 - currentDate.weekday; // Days until Saturday
        targetDate = currentDate.add(Duration(days: daysToWeekend));
        break;
      default:
        targetDate = currentDate; // Default to today if none of the cases match
    }

    String formattedDate = targetDate.toIso8601String().split('T').first; // "YYYY-MM-DD"

   Get.back();
    _eventController.fetchEvents(day: formattedDate); // Assuming this function filters the events by date in your controller
  }

  // Date picker method to select a specific date
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      selectedOption.value = "${pickedDate.toLocal().toIso8601String().split('T').first}";
      selectedDateTime.value = pickedDate;
      _eventController.fetchEvents(day: selectedOption.value); // Filter events by the selected date
    }
  }
}
