import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemChatArchived extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;

  ItemChatArchived({
    required this.userName,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user.png"),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 13.24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  lastMessage,
                  style: TextStyle(
                    fontSize: 8.24.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timestamp,
                style: TextStyle(
                  fontSize: 10.24.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              if (unreadCount > 0)
                Container(
                  height: 20.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      unreadCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
