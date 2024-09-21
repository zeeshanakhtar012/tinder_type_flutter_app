// import 'package:blaxity/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../constants/fonts.dart';
//
// class ScreenSearchBlog extends StatelessWidget {
//   const ScreenSearchBlog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(onPressed: () {
//             Get.back();
//           }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,),),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Blog", style: AppFonts.titleLogin,),
//             Text("Discover, Interact, and Connect with Others", style: AppFonts.subtitle,),
//             SizedBox(height: 20.h), // Add spacing between title and search row
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 50.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xff353535),
//                           // Uncomment if needed
//                           // blurRadius: 2,
//                           // spreadRadius: 2,
//                           // offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Theme(
//                       data: ThemeData(
//                         primaryColor: Colors.transparent, // Removes the primary color highlight
//                         inputDecorationTheme: InputDecorationTheme(
//                           border: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                           contentPadding: EdgeInsets.all(6.0),
//                         ),
//                       ),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           // These should match the ThemeData settings
//                           border: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                           contentPadding: EdgeInsets.all(6.0),
//                           hintText: 'Search...',
//                           prefixIcon: Icon(Icons.search),
//                         ),
//                         onChanged: (value) {},
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10.w), // Add spacing between search field and button
//                 Container(
//                   height: 50.h,
//                   width: 50.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     gradient: AppColors.buttonColor,
//                   ),
//                   child: Icon(
//                     Icons.filter_list,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ).marginSymmetric(
//           horizontal: 15.sp,
//           vertical: 10.sp,
//         ),
//       ),
//     );
//   }
// }
