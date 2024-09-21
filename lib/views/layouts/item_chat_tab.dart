import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemChatTab extends StatefulWidget {
  @override
  _ItemChatTabState createState() => _ItemChatTabState();
}

class _ItemChatTabState extends State<ItemChatTab> {
  bool isFirstActive = true;

  // void _navigateToNextScreen() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ScreenGoOut()),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isFirstActive = true;
            });
          },
          child: Container(
            height: 34.h,
            width: 110.w,
            decoration: BoxDecoration(
              color: isFirstActive ? Color(0xFFA7713F) : Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25)
              ),
            ),
            child: Center(child: Text("Messages", style: TextStyle(color: Colors.white))),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isFirstActive = false;
            });
            // _navigateToNextScreen();
          },
          child: Container(
            height: 34.h,
            width: 110.w,
            decoration: BoxDecoration(
              color: isFirstActive ? Colors.grey : Color(0xFFA7713F),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25)
              ),
            ),
            child: Center(child: Text("Groups", style: TextStyle(color: Colors.white))),
          ),
        ),
      ],
    );
  }
}