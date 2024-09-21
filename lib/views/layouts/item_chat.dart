import 'package:blaxity/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemChat extends StatefulWidget {
  final String? titleChat;
  final String? subtitleChat;
  final String? imageUrl;
  final String? time;
  final String? messageCounter;
  final VoidCallback onTap;

  ItemChat({
    this.imageUrl,
    this.subtitleChat,
    this.titleChat,
    this.time,
    this.messageCounter,
    super.key, required this.onTap,
  });

  @override
  _ItemChatState createState() => _ItemChatState();
}

class _ItemChatState extends State<ItemChat> with SingleTickerProviderStateMixin {
  bool _isSwiped = false;
  double _swipeOffset = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _handleSwipeUpdate(DragUpdateDetails details) {
    setState(() {
      _swipeOffset -= details.primaryDelta!;
      if (_swipeOffset > 100) {
        _swipeOffset = 100;
      } else if (_swipeOffset < 0) {
        _swipeOffset = 0;
      }
    });
  }

  void _handleSwipeEnd(DragEndDetails details) {
    if (_swipeOffset > 50) {
      setState(() {
        _isSwiped = true;
        _controller.forward();
      });
    } else {
      setState(() {
        _isSwiped = false;
        _controller.reverse();
      });
    }
    setState(() {
      _swipeOffset = 0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 75.h,
                      width: 54.w,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.more_horiz, color: Colors.white,),
                          Text(
                            "Details",
                            style: TextStyle(color: Colors.white),
                          ).marginOnly(
                            top: 10.sp,
                          ),
                        ],
                      ),
                    ), // Adjust spacing between icons
                    Container(
                      height: 75.h,
                      width: 54.w,
                      decoration: BoxDecoration(
                        gradient: AppColors.buttonColor,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5.sp,
                            right: 10.0.sp,
                            child: Container(
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.buttonColor,
                              ),
                              child: Center(
                                child: Text("${widget.messageCounter}"),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.archive, color: Colors.white),
                            onPressed: () {
                              // Handle archive button action here
                            },
                          ),
                          Positioned(
                            bottom: 5.sp,
                            right: 0,
                            left: 0,
                            child: Text(
                              "Archive",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: _handleSwipeUpdate,
          onHorizontalDragEnd: _handleSwipeEnd,
          child: Transform.translate(
            offset: Offset(-_swipeOffset, 0),
            child: Container(
              color: Colors.transparent,
              child: ListTile(
                onTap: widget.onTap,
                title: Text(
                  "${widget.titleChat}",
                  style: TextStyle(
                    fontSize: 13.24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "${widget.subtitleChat}",
                  style: TextStyle(
                    fontSize: 8.24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                leading: CircleAvatar(
                  child: widget.imageUrl != null
                      ? Image.asset("${widget.imageUrl}")
                      : Icon(Icons.person, color: Colors.white),
                ),
                trailing: _isSwiped
                    ? SizedBox.shrink()
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.time}",
                      style: TextStyle(
                        fontSize: 10.24.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    if (widget.messageCounter != null)
                      Container(
                        height: 20.h,
                        width: 20.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.buttonColor,
                        ),
                        child: Center(
                          child: Text("${widget.messageCounter}"),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
