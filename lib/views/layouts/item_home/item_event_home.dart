// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../../../constants/colors.dart';
// import '../../../constants/fonts.dart';
// import '../../../widgets/custom_divider_gradient.dart';
// import '../../../widgets/custom_selectable_button.dart';
// import '../../screens/screen_blog_details.dart';
// import '../item_event/event_button/item_event.dart';
//
// class ItemEventHome extends StatefulWidget {
//   String eventOwnerName;
//   String eventName;
//   String eventType;
//   String eventLocation;
//   String eventTime;
//   String eventMember;
//   String eventDate;
//   String feedTitle;
//   String feedDescription;
//   String feedComments;
//   String feedLikes;
//   ItemEventHome({
//     required this.eventOwnerName,
//     required this.eventName,
//     required this.eventLocation,
//     required this.eventTime,
//     required this.eventMember,
//     required this.eventDate,
//     required this.eventType,
//     required this.feedTitle,
//     required this.feedDescription,
//     required this.feedComments,
//     required this.feedLikes,
//     super.key});
//
//   @override
//   State<ItemEventHome> createState() => _ItemEventHomeState();
// }
//
// class _ItemEventHomeState extends State<ItemEventHome> {
//   // bool _isExpanded = false;
//
//   // int _selectedIndex = -1;
//
//   int _selectedButtonIndex = -1;
//
//   // double _sliderValue = 0.0;
//   //
//   // int _selectedToggleIndex = 1;
//   //
//   // void _onToggle(int index) {
//   //   setState(() {
//   //     _selectedToggleIndex = index;
//   //   });
//   //   print('Switched to: $index');
//   // }
//
//   void _onButtonTap(int index) {
//     setState(() {
//       _selectedButtonIndex = index;
//       // _showBottomSheetFilter(context);
//     });
//   }
//   // void _onAvatarTap(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //     if(_selectedIndex == 0)
//   //       _showBottomSheet(context);
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height*1;
//     final width = MediaQuery.sizeOf(context).width*1;
//     return Container(
//       margin: EdgeInsets.all(5.sp,),
//       padding: EdgeInsets.all(8.0),
//       width: width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: Color(0xFFA7713F),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SvgPicture.asset(
//                 "assets/icons/icon_eventSection_svg.svg",
//               ),
//               Text("Events", style: AppFonts.subscriptionTitle,).marginOnly(
//                 left: 10.sp,
//               ),
//               // Spacer(),
//               // SvgPicture.asset(
//               //   "assets/icons/icon_share.svg",
//               // ),
//             ],
//           ),
//           Container(
//             height: height * .25,
//             width: width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(11.33),
//               // border: Border.all(
//               //   color: Color(0xFFA7713F),
//               // ),
//             ),
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: Image.asset(
//                     "assets/images/image_event.png",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 30.h,
//                         width: 104.w,
//                         decoration: BoxDecoration(
//                           gradient: AppColors.buttonColor,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(10),
//                             bottomRight: Radius.circular(10),
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "${widget.eventType}",
//                             style: AppFonts.subscriptionDuration,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ).marginOnly(
//               top: 10.sp,
//           ),
//           Container(
//             padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(.3),
//                     blurStyle: BlurStyle.inner,
//                   )
//                 ]
//             ),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                       style: AppFonts.subscriptionSubtitle,
//                       "${widget.eventName}"),
//                 ),
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SvgPicture.asset(
//                       height: 15.h,
//                       width: 15.w,
//                       "assets/icons/icon_profile_svg.svg",
//                     ).marginSymmetric(
//                       vertical: 5.h,
//                       horizontal: 5.w
//                     ),
//                     Text( '${widget.eventOwnerName}',
//                       style: AppFonts.subtitle,
//                     ).marginOnly(
//                       left: 5.sp,
//                     ),
//                     Spacer(),
//                     Row(
//                       children: [
//                         SvgPicture.asset("assets/icons/icon_clock.svg"),
//                         Text(
//                             style: AppFonts.subtitle,
//                             "${widget.eventTime}").marginOnly(
//                           left: 5.sp,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/icons/icon_location.svg"),
//                     Text(
//                         style: AppFonts.subtitle,
//                         "${widget.eventLocation}").marginOnly(
//                       left: 6.sp,
//                     ),
//                     Spacer(),
//                     Row(
//                       // mainAxisAlignment: MainAxisAlignment.end,
//                       // crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         SvgPicture.asset("assets/icons/icon_member.svg"),
//                         Text(
//                             style: AppFonts.subtitle,
//                             "${widget.eventMember} members").marginOnly(
//                           left: 6.sp,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/icons/icon_calneder.svg"),
//                     Text(
//                         style: AppFonts.subtitle,
//                         "${widget.eventDate}"
//                             ).marginOnly(
//                       left: 6.sp,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             // padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(.3),
//                     blurStyle: BlurStyle.inner,
//                   )
//                 ]
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/icon_blog.svg",
//                     ).marginSymmetric(
//                       vertical: 5.sp,
//                     ),
//                     Text("Feed", style: AppFonts.subscriptionTitle,).marginOnly(
//                       left: 10.sp,
//                     ),
//                     // Spacer(),
//                     // SvgPicture.asset(
//                     //   "assets/icons/icon_share.svg",
//                     // ),
//                   ],
//                 ).marginOnly(
//                   left: 8.sp,
//                 ),
//                 Container(
//                   // height: height * .25,
//                   width: width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(11.33),
//                   ),
//                   child: Image(image: AssetImage("assets/images/blog-image.png")),
//                 ).marginOnly(
//                     top: 10.sp,
//                     bottom: 15.sp
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text('${widget.feedTitle}',
//                     style:TextStyle(
//                       fontSize: 15.33.sp,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Avenir LT Pro",
//                       color: Color(0xffC19B61),
//                     ),
//                   ),
//                 ).marginOnly(
//                   left: 10.sp,
//                 ),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Container(
//                 //       padding: EdgeInsets.only(left: 3.sp),
//                 //       height: 20.h,
//                 //       width: 70.w,
//                 //       decoration: BoxDecoration(
//                 //         boxShadow: [
//                 //           BoxShadow(
//                 //             color: Colors.grey.withOpacity(.3),
//                 //             blurStyle: BlurStyle.inner,
//                 //           ),
//                 //         ],
//                 //         borderRadius: BorderRadius.circular(10),
//                 //         border: Border.all(color: Color(0xFFA7713F)),
//                 //       ),
//                 //       child: Center(
//                 //         child: Text(
//                 //           "Soft Swap",
//                 //           style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 10.37.sp,
//                 //           ),
//                 //         ).marginOnly(left: 4.sp),
//                 //       ),
//                 //     ),
//                 //     Container(
//                 //       padding: EdgeInsets.only(left: 3.sp),
//                 //       height: 20.h,
//                 //       width: 70.w,
//                 //       decoration: BoxDecoration(
//                 //         boxShadow: [
//                 //           BoxShadow(
//                 //             color: Colors.grey.withOpacity(.3),
//                 //             blurStyle: BlurStyle.inner,
//                 //           ),
//                 //         ],
//                 //         borderRadius: BorderRadius.circular(10),
//                 //         border: Border.all(color: Color(0xFFA7713F)),
//                 //       ),
//                 //       child: Center(
//                 //         child: Text(
//                 //           "Soft Swap",
//                 //           style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 10.37.sp,
//                 //           ),
//                 //         ).marginOnly(left: 4.sp),
//                 //       ),
//                 //     ).marginSymmetric(
//                 //       horizontal: 10.sp,
//                 //     ),
//                 //     Container(
//                 //       padding: EdgeInsets.only(left: 3.sp),
//                 //       height: 20.h,
//                 //       width: 70.w,
//                 //       decoration: BoxDecoration(
//                 //         boxShadow: [
//                 //           BoxShadow(
//                 //             color: Colors.grey.withOpacity(.3),
//                 //             blurStyle: BlurStyle.inner,
//                 //           ),
//                 //         ],
//                 //         borderRadius: BorderRadius.circular(10),
//                 //         border: Border.all(color: Color(0xFFA7713F)),
//                 //       ),
//                 //       child: Center(
//                 //         child: Text(
//                 //           "Soft Swap",
//                 //           style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 10.37.sp,
//                 //           ),
//                 //         ).marginOnly(left: 4.sp),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ).marginSymmetric(
//                 //   vertical: 15.sp,
//                 // ),
//                 Text(
//                   textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 12.33.sp,
//                       fontWeight: FontWeight.w300,
//                       fontFamily: "Avenir LT Pro",
//                       color: Color(0xffC19B61),
//                     ),
//                     "${widget.feedDescription}").marginOnly(
//                   left: 10.sp,
//                 ),
//                Row(
//                  children: [
//                    SvgPicture.asset('assets/icons/icon_chat_svg.svg'),
//                    RichText(
//                      text: TextSpan(
//                        text: "${widget.feedComments}",
//                        style: TextStyle(
//                          fontSize: 13.34.sp,
//                          color: Colors.white,
//                        ),
//                        children: [
//                          TextSpan(
//                            text: "comments",
//                            style: TextStyle(
//                              fontSize: 12.sp,
//                              color: Color(0xffC19B61),
//                            )
//                          )
//                        ]
//                      ),
//                    ).marginOnly(
//                      left: 12.sp,
//                    ),
//                    Spacer(),
//                    RichText(
//                      text: TextSpan(
//                          text: "${widget.feedLikes}",
//                          style: TextStyle(
//                            fontSize: 13.34.sp,
//                            color: Colors.white,
//                          ),
//                          children: [
//                            TextSpan(
//                                text: "Likes",
//                                style: TextStyle(
//                                  fontSize: 12.sp,
//                                  color: Color(0xffC19B61),
//                                )
//                            )
//                          ]
//                      ),
//                    ),
//                    SvgPicture.asset('assets/icons/icon_heart_gold.svg').marginOnly(
//                      left: 12.sp,
//                    ),
//                  ],
//                ).marginOnly(
//                  top: 10.sp,
//                  left: 10.sp,
//                  right: 10.sp,
//                ),
//                 GradientDivider(gradient: AppColors.buttonColor, width: Get.width,
//                 thickness: 0.1,
//                 ).marginSymmetric(vertical: 8.h,),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: CustomSelectbaleButton(
//                     onTap: (){
//                       Get.to(ScreenBlogDetails());
//                     },
//                     borderRadius: BorderRadius.circular(20),
//                     width: 104.w,
//                     height: 28.h,
//                     strokeWidth: 1,
//                     gradient: AppColors.buttonColor,
//                     titleButton: "Read more",
//                   ),
//                 ).marginSymmetric(
//                   vertical: 15.sp,
//                 )
//               ],
//             ).marginOnly(
//               top: 6.sp,
//             ),
//           )
//           // Container(
//           //   height: 65.h,
//           //   decoration: BoxDecoration(
//           //       boxShadow: [
//           //         BoxShadow(
//           //           color: Colors.grey.withOpacity(.3),
//           //           blurStyle: BlurStyle.inner,
//           //         )
//           //       ]
//           //   ),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: [
//           //       SelectableButton(
//           //         text: 'Organizer',
//           //         isSelected: _selectedButtonIndex == 0,
//           //         onTap: () => _onButtonTap(0),
//           //       ),
//           //       SelectableButton(
//           //         text: 'Attend',
//           //         isSelected: _selectedButtonIndex == 1,
//           //         onTap: () => _onButtonTap(1),
//           //       ).marginSymmetric(
//           //         horizontal: 10.sp,
//           //       ),
//           //       SelectableButton(
//           //         text: 'Like',
//           //         isSelected: _selectedButtonIndex == 1,
//           //         onTap: () => _onButtonTap(1),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           // Align(
//           //   alignment: Alignment.bottomRight,
//           //   child: InkWell(
//           //     onTap: _toggleExpand,
//           //     child: CircleAvatar(
//           //       backgroundColor: Colors.grey.withOpacity(.3),
//           //       child:  SvgPicture.asset(
//           //           "assets/icons/icon_down.svg"),
//           //     ),
//           //   ),
//           // ),
//           // if (_isExpanded) ...[
//           //   Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: [
//           //       GestureDetector(
//           //         onTap: () => _onAvatarTap(0),
//           //         child: CircleAvatar(
//           //           backgroundColor: _selectedIndex == 0
//           //               ? Color(0xFFA7713F)
//           //               : Colors.grey.withOpacity(0.3),
//           //           child: Icon(Icons.close, color: Colors.white),
//           //         ),
//           //       ),
//           //       SizedBox(width: 10.w),
//           //       GestureDetector(
//           //         onTap: () => _onAvatarTap(1),
//           //         child: CircleAvatar(
//           //           backgroundColor: _selectedIndex == 1
//           //               ? Color(0xFFA7713F)
//           //               : Colors.grey.withOpacity(0.3),
//           //           child: SvgPicture.asset(
//           //             "assets/icons/icon_flah.svg",
//           //           ).marginSymmetric(horizontal: 5.sp),
//           //         ),
//           //       ),
//           //       SizedBox(width: 10),
//           //       GestureDetector(
//           //         onTap: () => _onAvatarTap(2),
//           //         child: CircleAvatar(
//           //           backgroundColor: _selectedIndex == 2
//           //               ? Color(0xFFA7713F)
//           //               : Colors.grey.withOpacity(0.3),
//           //           child: SvgPicture.asset(
//           //             "assets/icons/icon_chat.svg",
//           //           ).marginSymmetric(horizontal: 5.sp),
//           //         ),
//           //       ),
//           //       SizedBox(width: 10),
//           //       GestureDetector(
//           //         onTap: () => _onAvatarTap(3),
//           //         child: CircleAvatar(
//           //           backgroundColor: _selectedIndex == 3
//           //               ? Color(0xFFA7713F)
//           //               : Colors.grey.withOpacity(0.3),
//           //           child: SvgPicture.asset(
//           //             "assets/icons/icon_heart.svg",
//           //           ).marginSymmetric(horizontal: 5.sp),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ],
//         ],
//       ),
//     );
//   }
// }
