// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../constants/colors.dart';
// import '../../constants/fonts.dart';
// import '../../models/blog.dart';
// import '../../widgets/custom_selectable_button.dart';
//
// class ItemBlogDetails extends StatelessWidget {
//   // Blog? blog;
//   ItemBlogDetails({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height*1;
//     final width = MediaQuery.sizeOf(context).width*1;
//     return Container(
//       padding: EdgeInsets.all(18.0),
//       width: width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: Color(0xFFA7713F),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             // height: height * .25,
//             width: width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(11.33),
//             ),
//             child: Image(image: AssetImage("assets/images/blog-image.png")),
//           ).marginOnly(
//               top: 10.sp,
//               bottom: 15.sp
//           ),
//           GradientText(
//             text: 'Thing Only People Dating in Big Cities Know',
//             style: AppFonts.subscriptionTitle,
//             gradient: AppColors.buttonColor,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 3.sp),
//                 height: 20.h,
//                 width: 70.w,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(.3),
//                       blurStyle: BlurStyle.inner,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Color(0xFFA7713F)),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Soft Swap",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10.37.sp,
//                     ),
//                   ).marginOnly(left: 4.sp),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 3.sp),
//                 height: 20.h,
//                 width: 70.w,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(.3),
//                       blurStyle: BlurStyle.inner,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Color(0xFFA7713F)),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Soft Swap",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10.37.sp,
//                     ),
//                   ).marginOnly(left: 4.sp),
//                 ),
//               ).marginSymmetric(
//                 horizontal: 10.sp,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 3.sp),
//                 height: 20.h,
//                 width: 70.w,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(.3),
//                       blurStyle: BlurStyle.inner,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Color(0xFFA7713F)),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Soft Swap",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10.37.sp,
//                     ),
//                   ).marginOnly(left: 4.sp),
//                 ),
//               ),
//             ],
//           ).marginSymmetric(
//             vertical: 15.sp,
//           ),
//           Text(
//               style: AppFonts.subtitle,
//               "Meeting the love of your life, playing stare tag, and\nthen not doing a damn thing about it until one of you leaves. "),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: CustomSelectbaleButton(
//               onTap: (){
//                 // Get.to(ScreenAboutDetails());
//               },
//               borderRadius: BorderRadius.circular(20),
//               width: 104.w,
//               height: 54.h,
//               strokeWidth: 1,
//               gradient: AppColors.buttonColor,
//               titleButton: "Read",
//             ),
//           ).marginSymmetric(
//             vertical: 15.sp,
//           )
//         ],
//       ),
//     );
//   }
// }
