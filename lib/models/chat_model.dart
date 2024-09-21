// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
//
// class ItemUserChatList extends StatelessWidget {
//   UserResponse user;
// LastMessage lastMessage;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Get.to(ScreenUserChat(user: user,chatRoomId: lastMessage.chatRoomId,counter: lastMessage.counter,lstMsg: lastMessage,));
//       },
//       child: Container(
//         // height: 75.sp,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(.3),
//               blurStyle: BlurStyle.outer,
//               spreadRadius: 1.0,
//               blurRadius: 3.0,
//               offset: Offset(1, 2),
//             )
//           ]
//         ),
//         padding: EdgeInsets.all(18.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage("${AppEndPoint.userProfile}${user.user.information.profile}"),
//             ),
//             SizedBox(width: 8.0),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     user.user.information.name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 4.0),
//                   Text(lastMessage.lastMessage, style: TextStyle(
//                     fontWeight: FontWeight.w300,
//                     fontSize: 10,
//                     color: Colors.grey,
//                   ),),
//                 ],
//               ),
//             ),
//
//             Text(lastMessage.counter==0?"":lastMessage.counter.toString(), style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black
//             ))
//           ],
//         ),
//       ),
//     );
//   }
//
// ItemUserChatList({
//     required this.user,
//     required this.lastMessage,
//   });
// }