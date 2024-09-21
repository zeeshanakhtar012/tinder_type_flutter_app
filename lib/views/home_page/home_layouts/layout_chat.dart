import 'dart:developer';

import 'package:blaxity/views/layouts/layout_group_chat.dart';
import 'package:blaxity/views/layouts/layout_personal_chat.dart';
import 'package:blaxity/views/screens/archieved/layout_personal_chat_archieved.dart';
import 'package:blaxity/views/screens/screen_create_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../models/last_message.dart';
import '../../../widgets/custom_drawer.dart';
import '../../screens/archieved/archive_manager.dart';

class LayoutChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    ChatPersonalController chatController = Get.put(ChatPersonalController());
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     // Get.to(ScreenCreateGroup());
          //   },
          //   icon: SvgPicture.asset("assets/icons/add_people.svg"),
          // ),
          // IconButton(
          //   onPressed: () {
          //   },
          //   icon: SvgPicture.asset("assets/icons/icon_chat_edit.svg"),
          // ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: SvgPicture.asset("assets/icons/notification.svg"),
          ),
        ],
        centerTitle: true,
        title: Image.asset(
          "assets/images/image_profile_appBar.png",
          height: Get.height * 0.23,
        ),
      ),
      body: DefaultTabController(
          length: 2, // Number of tabs
          child:StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                    .collection("user")
                    .doc(FirebaseUtils.myId)
                    .collection("chats")
                    .orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text("Internet Error");
              }

              List<LastMessage> lastMessages = snapshot.data!.docs
                  .map((e) => LastMessage.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
              List<LastMessage> tempArchiveSingle = [];
                    List<LastMessage> tempArchiveCouple = [];
                    List<LastMessage> tempSingle = [];
                    List<LastMessage> tempCouple = [];

                    for (LastMessage room in lastMessages) {
                      log("Archive ${chatController.archiveIds.contains(room.chatRoomId)}");
                      if (chatController.archiveIds.contains(room.chatRoomId)) {
                        if (room.roomType == 'single') {
                          tempArchiveSingle.add(room);
                        } else if (room.roomType == 'couple') {
                          tempArchiveCouple.add(room);
                        }
                      } else {
                        if (room.roomType == 'single') {
                          tempSingle.add(room);
                        } else if (room.roomType == 'couple') {
                          tempCouple.add(room);
                        }
                      }
                    }

                    // Update the observable lists
                   chatController. archiveSingle.assignAll(tempArchiveSingle);
              chatController.archiveCouple.assignAll(tempArchiveCouple);
              chatController.single.assignAll(tempSingle);
              chatController.couple.assignAll(tempCouple);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    text: 'Messages',
                    style: AppFonts.titleLogin,
                    gradient: AppColors.buttonColor,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 47.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff353535),
                          // blurRadius: 2,
                          // spreadRadius: 2,
                          // offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextField(

                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 12.h),
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                    ),
                  ).marginSymmetric(vertical: 7.h),

                  Center(
                    child: Container(
                      height: 36.h,
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: 175.w,
                      decoration: BoxDecoration(
                          color: Color(0xFF353535),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.transparent,
                          )
                      ),
                      child: TabBar(indicatorPadding: EdgeInsets.zero,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: AppColors.buttonColor,
                            border: Border.all(
                              color: Colors.transparent,
                            )
                        ),
                        tabs: [
                          Tab(text: 'Messages'),
                          Tab(text: 'Groups'),
                        ],
                      ),
                    ).marginOnly(
                      top: 15.sp,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(LayoutChatArchived(archivedCouple:chatController. archiveCouple,
                          archivedSingle: chatController.archiveSingle));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/icon_archieve.svg"),
                        Text("Archived", style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffD2D2D2),
                        ),).marginOnly(
                          left: 10.h,
                        ),

                      ],
                    ).marginSymmetric(
                      vertical: 6.h,
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          LayoutPersonalChat(lastMessageList: chatController.single,),
                          LayoutGroupChat(lastMessageList:chatController. couple,),
                        ],
                      )
                  ),
                ],
              ).marginSymmetric(
                horizontal: 15.sp,
                vertical: 10.sp,
              );
            }
          )
      ),
    );
  }
}



class ChatPersonalController extends GetxController {
  var archiveSingle = <LastMessage>[].obs;
  var archiveCouple = <LastMessage>[].obs;
  var single = <LastMessage>[].obs;
  var couple = <LastMessage>[].obs;
  var isLoading = false.obs;
RxList<String> archiveIds=<String>[].obs;
  @override
  void onInit() {
    super.onInit();
    getArchiveId();
    // listenToRooms(); // Start listening to Firestore rooms in real-time
  }
 Future<void> getArchiveId() async {
   archiveIds.value = await ArchiveManager.getArchivedChats();

 }
  // Listen to Firestore rooms in real-time
  // void listenToRooms() {
  //   FirebaseFirestore.instance
  //       .collection("user")
  //       .doc(FirebaseUtils.myId)
  //       .collection("chats")
  //       .orderBy('timestamp', descending: true)
  //       .get().then((QuerySnapshot snapshot) async {
  //
  //     isLoading(true);
  //     try {
  //       List<LastMessage> rooms = snapshot.docs.map((e) {
  //         return LastMessage.fromMap(e.data() as Map<String, dynamic>);
  //       }).toList();
  //
  //
  //       // Categorize rooms based on archived status and room type
  //       List<LastMessage> tempArchiveSingle = [];
  //       List<LastMessage> tempArchiveCouple = [];
  //       List<LastMessage> tempSingle = [];
  //       List<LastMessage> tempCouple = [];
  //
  //       for (LastMessage room in rooms) {
  //         if (archivedRoomIds.contains(room.chatRoomId)) {
  //           if (room.roomType == 'single') {
  //             tempArchiveSingle.add(room);
  //           } else if (room.roomType == 'couple') {
  //             tempArchiveCouple.add(room);
  //           }
  //         } else {
  //           if (room.roomType == 'single') {
  //             tempSingle.add(room);
  //           } else if (room.roomType == 'couple') {
  //             tempCouple.add(room);
  //           }
  //         }
  //       }
  //
  //       // Update the observable lists
  //       archiveSingle.assignAll(tempArchiveSingle);
  //       archiveCouple.assignAll(tempArchiveCouple);
  //       single.assignAll(tempSingle);
  //       couple.assignAll(tempCouple);
  //     } finally {
  //       isLoading(false);
  //     }
  //
  //   });
  // }
RxBool isArchive = false.obs;
  // Manage archive/unarchive in real-time
  Future<void> toggleArchive(String chatRoomId) async {
    isArchive.value = await ArchiveManager.isRoomArchived(chatRoomId);
    if (isArchive.value) {
      await ArchiveManager.unarchiveRoom(chatRoomId);
      getArchiveId();

    } else {
      await ArchiveManager.archiveRoom(chatRoomId);
      getArchiveId();
    }

    // No need to call fetchRooms() because Firestore stream handles real-time updates
  }
}
