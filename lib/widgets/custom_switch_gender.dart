import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitchGenderButton extends StatefulWidget {
  final Function(String) onGenderChanged;
  final String selectedGender;

  CustomSwitchGenderButton({
    required this.onGenderChanged,
    required this.selectedGender,
  });

  @override
  _CustomSwitchGenderButtonState createState() => _CustomSwitchGenderButtonState();
}

class _CustomSwitchGenderButtonState extends State<CustomSwitchGenderButton> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    // Initialize `isSwitched` based on the `selectedGender`
    isSwitched = widget.selectedGender == 'Male';
  }

  void _handleTap() {
    setState(() {
      isSwitched = !isSwitched;
      // Determine the selected gender based on the switch state
      String selectedGender = isSwitched ? 'Male' : 'Female';
      // Call the callback with the new gender
      widget.onGenderChanged(selectedGender);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 34.h,
        width: 76.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSwitched ? Color(0xFFA7713F) : Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              left: isSwitched ? 40.w : 2.w,
              top: 2.h,
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    isSwitched ? Icons.male : Icons.female,
                    color: isSwitched ? Color(0xFFA7713F) : Colors.grey,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
            Align(
              alignment: isSwitched ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 6.h),
                child: Text(
                  isSwitched ? "Male" : "Female",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
