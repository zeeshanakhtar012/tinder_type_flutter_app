// import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
// import 'package:blaxity/models/user.dart';
// import 'package:blaxity/views/screens/single_user_screens/screen_selfie_verification_05.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../constants/colors.dart';
// import '../../../constants/firebase_utils.dart';
// import '../../../constants/fonts.dart';
// import '../../../widgets/custom_divider_gradient.dart';
// import '../../../widgets/custom_selectable_button.dart';
// import '../../../widgets/my_input_feild.dart';
//
// class ScreenIdentityVerification extends StatelessWidget {
//   ControllerRegistration controllerRegistration = Get.put(ControllerRegistration());
//
//   String step;
//   User user;
//   ScreenIdentityVerification({
//     required this.step,
//     required this.user,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             ),
//           ),
//           title: Text(step, style: AppFonts.personalinfoAppBar,),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GradientText(text:"Identity Verification", style: AppFonts.titleLogin,),
//             Text("Securely Upload Your ID for Verification",
//               style: AppFonts.subtitle,),
//             MyInputField(
//               suffix: Icon(Icons.upload),
//               controller: controllerRegistration.idDocumentController,
//               hint: "Upload your ID",
//               readOnly: true,
//               onTap: () {
//                 controllerRegistration.pickDocument(true);
//               },
//             ),
//             GradientDivider(
//               thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
//             ).marginSymmetric(
//               horizontal: 8.w,
//             ),
//             MyInputField(
//               suffix: Icon(Icons.upload),
//
//               controller: controllerRegistration.utilityBillController,
//               readOnly: true,
//               onTap: () {
//                 controllerRegistration.pickDocument(false);
//               },
//               hint: "Upload Utility Bill",
//             ),
//             GradientDivider(
//               thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
//             ).marginSymmetric(
//               horizontal: 8.w,
//             ),
//             Spacer(),
//             Obx(() {
//               return CustomSelectbaleButton(
//                 isLoading: controllerRegistration.isLoading.value,
//                 onTap: () async {
//                  if (controllerRegistration.idDocumentController.text.isNotEmpty && controllerRegistration.utilityBillController.text.isNotEmpty) {
//                    await controllerRegistration.updateDocument(user);
//                  }
//                  else{
//                    FirebaseUtils.showError("Please Upload Your ID and Utility Bill");
//                  }
//                 },
//                 borderRadius: BorderRadius.circular(20),
//                 width: Get.width,
//                 height: 54.h,
//                 strokeWidth: 1,
//                 gradient: AppColors.buttonColor,
//                 titleButton: "Continue",
//               );
//             }),
//           ],
//         ).marginSymmetric(
//           horizontal: 15.sp,
//           vertical: 15.sp,
//         ),
//       ),
//     );
//   }
// }
