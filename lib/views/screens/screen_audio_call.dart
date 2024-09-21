// import 'package:blaxity/constants/fonts.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../../constants/colors.dart';
// import '../../widgets/custom_button.dart';
// import '../layouts/item_voice_call/item_timer.dart';
//
// class ScreenAudioCall extends StatelessWidget {
//   String userName;
//   ScreenAudioCall({
//    required this.userName,
//     super.key
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//               size: 20.sp,
//             ),
//           ),
//           title: Container(
//             height: 44.h,
//             width: 90.w,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25.r),
//               border: Border.all(
//                 color: Color(0xFFA7713F),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 userName!,
//                 style: TextStyle(fontSize: 16.sp),
//               ),
//             ),
//           ),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Stack(
//         children: [
//               Align(
//                   alignment: Alignment.center,
//                   child: Image.asset("assets/images/Image_call.png")),
//           Positioned(
//             left: 140.sp,
//             top: 110.sp,
//             child: SvgPicture.asset("assets/icons/icon_phone.svg"),
//           ),
//         ],
//             ),
//             Text("Jad Trump", style: AppFonts.titleLogin,),
//             AudioCallTimer(),
//             Spacer(),
//             CustomButton(
//               onTap: (){
//                 Get.back();
//               },
//               text: "Back to chat",
//               textColor: Colors.white,
//               buttonGradient: AppColors.buttonColor,
//             ).marginSymmetric(
//               vertical: 10.sp,
//             ),
//             CustomButton(
//               onTap: (){
//                 Get.back();
//               },
//               text: "End call",
//               textColor: Colors.red,
//               // buttonGradient: AppColors.buttonColor,
//             ),
//           ],
//         ).marginSymmetric(
//           horizontal: 15.sp,
//           vertical: 15.sp,
//         ),
//       ),
//     );
//   }
// }
