// import 'package:blaxity/constants/colors.dart';
// import 'package:blaxity/models/match_response.dart';
// import 'package:blaxity/views/screens/screen_match_person_profile.dart';
// import 'package:blaxity/widgets/my_input_feild.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../../constants/fonts.dart';
// import '../../../widgets/custom_button.dart';
// import '../../../widgets/custom_divider_gradient.dart';
// import '../../../widgets/custom_selectable_button.dart';
// import '../layouts/item_profile_details.dart';
//
// class ScreenUserProfileInfo extends StatefulWidget {
//   const ScreenUserProfileInfo({super.key});
//
//   @override
//   State<ScreenUserProfileInfo> createState() => _LayoutProfileState();
// }
//
// class _LayoutProfileState extends State<ScreenUserProfileInfo> {
//   late MatchResponse matchResponse;
//   int _selectedButtonIndex = -1;
//   void _onAvatarTap(int index) {
//     setState(() {
//       _selectedButtonIndex = index;
//       if(_selectedButtonIndex == 3)
//         Get.to(ScreenMatchPersonProfile(matchResponse: matchResponse,));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     final height = MediaQuery.sizeOf(context).height * 1;
//     final width = MediaQuery.sizeOf(context).width * 1;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//         ),
//         title: Image.asset(
//             height: height * .23, "assets/images/image_profile_appBar.png"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SvgPicture.asset("assets/icons/icon_myprofile.svg"),
//                 Container(
//                   height: 65.h,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color(0xFFA7713F),
//                       )
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GradientText(
//                         text: 'Sandy&Ralph',
//                         style: AppFonts.homeScreenText,
//                         gradient: AppColors.buttonColor,
//                       ),
//                       SvgPicture.asset(
//                         "assets/icons/icon_dimond.svg",
//                       ).marginOnly(
//                         left: 8.sp,
//                       ),
//                     ],
//                   ),
//                 ).marginOnly(
//                   top: 15.sp,
//                 ),
//                 Container(
//                   width: 194.w,
//                   decoration: BoxDecoration(
//                       gradient: AppColors.buttonColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                       )
//                   ),
//                   child: Center(
//                     child: Text("LIFETIME", style: AppFonts.subtitle,),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           height: height*.15,
//                           width: width*.15,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: Color(0xFFA7713F),
//                               )
//                           ),
//                           child: Stack(
//                             children: [
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: Text("0"),
//                               ),
//                               Positioned(
//                                 bottom:18.0.sp,
//                                 left: 2.sp,
//                                 child: Container(
//                                   height: 20.h,
//                                   width: 50.w,
//                                   decoration: BoxDecoration(
//                                       gradient: AppColors.buttonColor,
//                                       borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(10),
//                                           bottomRight: Radius.circular(10)
//                                       )
//                                   ),
//                                   child: Center(
//                                     child: Text("Level 0"),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Text("Score"),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           height: height*.15,
//                           width: width*.15,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: Color(0xFFA7713F),
//                               )
//                           ),
//                           child: Stack(
//                             children: [
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: Text("0"),
//                               ),
//                               Positioned(
//                                 bottom:18.0.sp,
//                                 left: 2.sp,
//                                 child: Container(
//                                   height: 20.h,
//                                   width: 50.w,
//                                   decoration: BoxDecoration(
//                                       gradient: AppColors.buttonColor,
//                                       borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(10),
//                                           bottomRight: Radius.circular(10)
//                                       )
//                                   ),
//                                   child: Center(
//                                     child: Text("Level 0"),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Text("Days"),
//                       ],
//                     ).marginSymmetric(
//                       horizontal: 20.sp,              ),
//                     Column(
//                       children: [
//                         Container(
//                           height: height*.15,
//                           width: width*.15,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               gradient: AppColors.buttonColor,
//                               border: Border.all(
//                                 color: Color(0xFFA7713F),
//                               )
//                           ),
//                           child:Center(
//                             child: Icon(Icons.done, color: Colors.white,),
//                           ),
//                         ),
//                         Text("Score"),
//                       ],
//                     ),
//                   ],
//                 ),
//                 //When User is not Verified////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                 /////////////////////
//                 /////////////////////
//                 ////////////////////
//                 //////////////////
//                 ///////////////
//                 /////////////
//                 ///////////
//                 /////////
//                 Container(
//                   // height: height*.35.h,
//                   width: width*.8.w,
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color(0xFFA7713F),
//                       )
//                   ),
//                   child: Column(
//                     children: [
//                       SvgPicture.asset("assets/icons/icon_right_tick.svg").marginOnly(
//                         top: 10.sp,
//                         bottom: 10.sp,
//                       ),
//                       Text("Verify Your Profile", style: AppFonts.titleSuccessFullPassword,),
//                       Text(
//                           style: AppFonts.subtitle,
//                           "Enhance your credibility by verifying\n    your profile.").marginSymmetric(
//                         vertical: 8.sp,
//                       ),
//                       CustomSelectbaleButton(
//                         onTap: (){
//                           // Get.to(ScreenAboutDetails());
//                         },
//                         borderRadius: BorderRadius.circular(20),
//                         width: Get.width*.6.w,
//                         height: 54.h,
//                         strokeWidth: 1,
//                         gradient: AppColors.buttonColor,
//                         titleButton: "Start Verification",
//                       ),
//                     ],
//                   ),
//                 ).marginOnly(
//                   top: 30.sp,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: GradientText(
//                     text: 'Photos',
//                     style: AppFonts.homeScreenText,
//                     gradient: AppColors.buttonColor,
//                   ),
//                 ).marginSymmetric(
//                   vertical: 15.sp,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 104.sp,
//                       height: 163.sp,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           // color: Colors.grey.withOpacity(.4),
//                           border: Border.all(
//                             width: 2.w,
//                             color: Color(0xFFA7713F),
//                           )
//                       ),
//                       child: Image.asset(
//                           fit: BoxFit.cover,
//                           "assets/images/profile_image01.png"),
//                     ),
//                     Container(
//                       width: 104.sp,
//                       height: 163.sp,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           // color: Colors.grey.withOpacity(.4),
//                           border: Border.all(
//                             width: 2.w,
//                             color: Color(0xFFA7713F),
//                           )
//                       ),
//                       child: Image.asset(
//                           fit: BoxFit.cover,
//                           "assets/images/profile_image01.png"),
//                     ),
//                     Container(
//                       width: 104.sp,
//                       height: 163.sp,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           // color: Colors.grey.withOpacity(.4),
//                           border: Border.all(
//                             width: 2.w,
//                             color: Color(0xFFA7713F),
//                           )
//                       ),
//                       child: Image.asset(
//                           fit: BoxFit.cover,
//                           "assets/images/profile_image01.png"),
//                     ),
//                     ShaderMask(
//                       shaderCallback: (Rect bounds) {
//                         return AppColors.buttonColor.createShader(bounds);
//                       },
//                       child: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     GradientText(
//                       text: 'Details',
//                       style: AppFonts.subscriptionTitle,
//                       gradient: AppColors.buttonColor,
//                     ),
//                     Spacer(),
//                     Row(
//                       children: [
//                         SvgPicture.asset("assets/icons/icon_male.svg"),
//                         GradientText(
//                           text: 'Sandy',
//                           style: AppFonts.subscriptionTitle,
//                           gradient: AppColors.buttonColor,
//                         ).marginOnly(
//                           left: 5.sp,
//                         ),
//                       ],
//                     ).marginOnly(
//                       right: 70.sp,
//                     ),
//                     Row(
//                       children: [
//                         SvgPicture.asset("assets/icons/icon_male.svg"),
//                         GradientText(
//                           text: 'Ralph',
//                           style: AppFonts.subscriptionTitle,
//                           gradient: AppColors.buttonColor,
//                         ).marginOnly(
//                           left: 5.sp,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ).marginOnly(
//                   top: 15.sp,
//                 ),
//               ],
//             ).marginSymmetric(
//               horizontal: 15.sp,
//               vertical: 10.sp,
//             ),
//             Column(
//               children: [
//                 ItemProfileDetails(detail: "Age",
//                   ageFirstPerson: "23", ageSecondPerson: "25", isGrey: true,
//                 ),
//                 ItemProfileDetails(detail: "Body Type",
//                   ageFirstPerson: "Slim", ageSecondPerson: "Big", isGrey: false,
//                 ),
//                 ItemProfileDetails(detail: "Height",
//                   ageFirstPerson: "5'6", ageSecondPerson: "6'4", isGrey: true,
//                 ),
//                 ItemProfileDetails(detail: "Ethnicity",
//                   ageFirstPerson: "Asian", ageSecondPerson: "Latino", isGrey: false,
//                 ),
//                 ItemProfileDetails(detail: "Smoking",
//                   ageFirstPerson: "Non", ageSecondPerson: "Smoker", isGrey: true,
//                 ),
//                 ItemProfileDetails(detail: "Languages ",
//                   ageFirstPerson: "English\nArabic", ageSecondPerson: "English\nArabic", isGrey: false,
//                 ),
//                 ItemProfileDetails(detail: "Education",
//                   ageFirstPerson: "BA", ageSecondPerson: "Masters", isGrey: true,
//                 ),
//                 ItemProfileDetails(detail: "Drink",
//                   ageFirstPerson: "Sober\ncurious", ageSecondPerson: "Most\nnights", isGrey: false,
//                 ),
//                 ItemProfileDetails(detail: "Safety Practices",
//                   ageFirstPerson: "Always", ageSecondPerson: "Always", isGrey: true,
//                 ),
//                 ItemProfileDetails(detail: "Eye Color",
//                   ageFirstPerson: "Blue", ageSecondPerson: "Green", isGrey: false,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: GradientText(
//                     text: 'Connections',
//                     style: AppFonts.homeScreenText,
//                     gradient: AppColors.buttonColor,
//                   ),
//                 ).marginSymmetric(
//                   vertical: 15.sp,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/icons/profile_SR.svg"),
//                     SvgPicture.asset("assets/icons/profile_j.svg").marginSymmetric(
//                       horizontal: 6.sp,
//                     ),
//                     SvgPicture.asset("assets/icons/profile_w.svg"),
//                     GradientText(
//                       text: '+ 4',
//                       style: AppFonts.homeScreenText,
//                       gradient: AppColors.buttonColor,
//                     ).marginSymmetric(
//                       horizontal: 6.sp,
//                     ),
//                     Spacer(),
//                     ShaderMask(
//                       shaderCallback: (Rect bounds) {
//                         return AppColors.buttonColor.createShader(bounds);
//                       },
//                       child: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//                 GradientDivider(
//                   thickness: 0.4, gradient: AppColors.buttonColor, width: width,
//                 ).paddingOnly(
//                   top: 5.sp,
//                   bottom: 10.sp,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: GradientText(
//                     text: 'Events',
//                     style: AppFonts.homeScreenText,
//                     gradient: AppColors.buttonColor,
//                   ),
//                 ).marginSymmetric(
//                   vertical: 5.sp,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/images/event_image.svg"),
//                     SvgPicture.asset("assets/images/event_image.svg").marginSymmetric(
//                       horizontal: 4.sp,
//                     ),
//                     GradientText(
//                       text: '+ 4',
//                       style: AppFonts.homeScreenText,
//                       gradient: AppColors.buttonColor,
//                     ).marginSymmetric(
//                       horizontal: 6.sp,
//                     ),
//                     Spacer(),
//                     ShaderMask(
//                       shaderCallback: (Rect bounds) {
//                         return AppColors.buttonColor.createShader(bounds);
//                       },
//                       child: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//                 GradientDivider(
//                   thickness: 0.4, gradient: AppColors.buttonColor, width: width,
//                 ).paddingOnly(
//                   top: 5.sp,
//                   bottom: 10.sp,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: GradientText(
//                     text: 'About',
//                     style: AppFonts.homeScreenText,
//                     gradient: AppColors.buttonColor,
//                   ),
//                 ).marginOnly(
//                   top: 20.sp,
//                 ),
//                 Row(
//                   children:[
//                     Text("We are a dynamic duo with a passion\nfor adventure and exploration. We enjoy\ntrying new cuisines."),
//                     Spacer(),
//                     ShaderMask(
//                       shaderCallback: (Rect bounds) {
//                         return AppColors.buttonColor.createShader(bounds);
//                       },
//                       child: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//                 GradientDivider(
//                   thickness: 0.4, gradient: AppColors.buttonColor, width: width,
//                 ).paddingOnly(
//                   top: 5.sp,
//                   bottom: 30.sp,
//                 ),
//                 Container(
//                   width: width*.6,
//                   height: 84.h,
//                   decoration:BoxDecoration(
//                     borderRadius: BorderRadius.circular(40),
//                     border:Border.all(
//                       color: Color(0xFFA7713F),
//                     ),
//                   ),
//                   child:Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () => _onAvatarTap(0),
//                         child: CircleAvatar(
//                           backgroundColor: _selectedButtonIndex == 0
//                               ? Color(0xFFA7713F)
//                               : Colors.grey.withOpacity(0.3),
//                           child: Icon(Icons.close, color: Colors.white),
//                         ),
//                       ),
//                       SizedBox(width: 10), // Add some spacing between avatars if needed
//                       GestureDetector(
//                         onTap: () => _onAvatarTap(1),
//                         child: CircleAvatar(
//                           backgroundColor: _selectedButtonIndex == 1
//                               ? Color(0xFFA7713F)
//                               : Colors.grey.withOpacity(0.3),
//                           child: SvgPicture.asset(
//                             "assets/icons/icon_flah.svg",
//                           ).marginSymmetric(horizontal: 5.sp),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       GestureDetector(
//                         onTap: () => _onAvatarTap(2),
//                         child: Stack(
//                           children:[
//                             CircleAvatar(
//                               backgroundColor: _selectedButtonIndex == 2
//                                   ? Color(0xFFA7713F)
//                                   : Colors.grey.withOpacity(0.3),
//                               child: SvgPicture.asset(
//                                 "assets/icons/icon_chat.svg",
//                               ).marginSymmetric(horizontal: 5.sp),
//                             ),
//                             Positioned(
//                                 top: 0.0,
//                                 left: 20.sp,
//                                 child: CircleAvatar(
//                                   radius: 10.r,
//                                   backgroundColor: Color(0xFFA7713F),
//                                   child: Text("20", style: TextStyle(
//                                     fontSize: 8.sp,
//                                   ),),
//                                 ))
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       GestureDetector(
//                         onTap: () => _onAvatarTap(3),
//                         child: CircleAvatar(
//                           backgroundColor: _selectedButtonIndex == 3
//                               ? Color(0xFFA7713F)
//                               : Colors.grey.withOpacity(0.3),
//                           child: SvgPicture.asset(
//                             "assets/icons/icon_heart.svg",
//                           ).marginSymmetric(horizontal: 5.sp),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ).marginSymmetric(
//               horizontal: 15.sp,
//               vertical: 15.sp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
