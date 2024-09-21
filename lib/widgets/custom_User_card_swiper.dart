import 'dart:developer';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/boost_controller.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/controllers/controller_like_user.dart';
import 'package:blaxity/controllers/user_controller.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_couple_profile.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_single_user_profile.dart';
import 'package:blaxity/views/layouts/item_user_card_swiper.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../controllers/controller_get_couple.dart';
import '../controllers/controller_home.dart';
import '../controllers/users_controllers/controller_get_user_all_data.dart';
import '../views/screens/screen_userChat.dart';

class CustomUserCardSwiper extends StatefulWidget {
  final RxList<User> userList;

  CustomUserCardSwiper({Key? key, required this.userList}) : super(key: key);

  @override
  State<CustomUserCardSwiper> createState() => _CustomUserCardSwiperState();
}

class _CustomUserCardSwiperState extends State<CustomUserCardSwiper> {
  MatchEngine? _matchEngine;
  final List<SwipeItem> _swipeItems = [];
  late Worker _userListListener;

  // Animation state variables
  double _heartSize = 1.0;
  double _crossSize = 1.0;

  @override
  void initState() {
    super.initState();

    // Listen to changes in the user list
    _userListListener = ever(widget.userList, (_) => _loadSwipeItems());

    _loadSwipeItems();
  }

  CoupleController coupleController = Get.put(CoupleController());
  UserController userController = Get.put(UserController());

  void _loadSwipeItems() {
    _swipeItems.clear(); // Clear existing items to avoid duplicates
    for (var user in widget.userList) {
      _swipeItems.add(SwipeItem(
        content: ItemUserCardSwiper(user: user, onTap: () {}),
        likeAction: () {
          // Check if user has swipes left and if they are a golden member
          if (_canSwipe()) {
            _handleLikeAction(user);
          } else {
            FirebaseUtils.showError(
                'You have no swipes left. Please buy more swipes or become a golden member for unlimited swipes!'
            );
          }
        },
        nopeAction: () {
          if (_canSwipe()) {
            _handleNopeAction();
          } else {
            FirebaseUtils.showError(
                'You have no swipes left. Please buy more swipes or become a golden member for unlimited swipes!'
            );
          }
        },
      ));
    }
    if (mounted) {
      setState(() {
        _matchEngine = MatchEngine(swipeItems: _swipeItems);
      });
    }
  }

  BoostController boostController = Get.put(BoostController());

  bool _canSwipe() {
    var currentUser = Get
        .find<ControllerHome>()
        .user
        .value!
        .user;
    log(currentUser.swipes.toString());

    // Check if user is not a golden member and has zero swipes
    return currentUser.swipes! > 0 || currentUser.goldenMember == 1;
  }
  void _handleLikeAction(User user) {
    LikeController likeController = Get.put(LikeController());
    likeController.likeEntity(
      likedUserId: user.userType == "single" ? int.tryParse(user.id!) : null,
      likedCoupleId: user.userType == "couple" ? user.coupleId : null,
    );
    _animateHeart(); // Trigger heart icon animation
    print('Swiped Right');

    // Trigger right swipe programmatically
    _matchEngine!.currentItem?.like();

    // Decrease swipe count for free users
    if (Get.find<ControllerHome>().user.value!.user.swipes! > 0 &&
        Get.find<ControllerHome>().user.value!.user.goldenMember == 0) {
      userController.swipeAction();
      Get.find<ControllerHome>().fetchUserInfo(); // Call API to decrease swipes
    }
  }

  void _handleNopeAction() {
    _animateCross(); // Trigger cross icon animation
    print('Swiped Left');

    // Trigger left swipe programmatically
    _matchEngine!.currentItem?.nope();

    // Decrease swipe count for free users
    if (Get.find<ControllerHome>().user.value!.user.swipes! > 0 &&
        Get.find<ControllerHome>().user.value!.user.goldenMember == 0) {
      userController.swipeAction();
      Get.find<ControllerHome>().fetchUserInfo();
    }
  }

  // void _handleLikeAction(User user) {
  //   LikeController likeController = Get.put(LikeController());
  //   likeController.likeEntity(
  //     likedUserId: user.userType == "single" ? int.tryParse(user.id!) : null,
  //     likedCoupleId: user.userType == "couple" ? user.coupleId : null,
  //   );
  //   _animateHeart(); // Trigger heart icon animation
  //   print('Swiped Right');
  //
  //   // Decrease swipe count for free users
  //   if (Get
  //       .find<ControllerHome>()
  //       .user
  //       .value!
  //       .user
  //       .swipes! > 0 &&
  //       Get
  //           .find<ControllerHome>()
  //           .user
  //           .value!
  //           .user
  //           .goldenMember==0) {
  //     userController.swipeAction();
  //     Get.find<ControllerHome>().fetchUserInfo(); // Call API to decrease swipes
  //   }
  // }
  //
  // void _handleNopeAction() {
  //   _animateCross(); // Trigger cross icon animation
  //   print('Swiped Left');
  //
  //   // Decrease swipe count for free users
  //   if (Get
  //       .find<ControllerHome>()
  //       .user
  //       .value!
  //       .user
  //       .swipes! > 0 &&
  //       Get
  //           .find<ControllerHome>()
  //           .user
  //           .value!
  //           .user
  //           .goldenMember==0) {
  //     userController.swipeAction();
  //     Get.find<ControllerHome>().fetchUserInfo();
  //     // Call API to decrease swipes
  //   }
  // }

  // Animation methods
  void _animateHeart() {
    setState(() {
      _heartSize = 1.5; // Increase size for animation
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _heartSize = 1.0; // Reset size after animation
      });
    });
  }

  void _animateCross() {
    setState(() {
      _crossSize = 1.5; // Increase size for animation
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _crossSize = 1.0; // Reset size after animation
      });
    });
  }

  void _resetSwipeItems() {
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    if (mounted) {
      setState(() {});
    }
  }

  RxInt indexValue = RxInt(0);

  @override
  void dispose() {
    _userListListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log(message)
    return _matchEngine != null
        ? Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              SwipeCards(
                matchEngine: _matchEngine!,
                itemBuilder: (BuildContext context, int index) {
                  return _swipeItems[index].content;
                },
                onStackFinished: () {
                  Get.find<ControllerGetUserAllData>().getUserData();
                  _resetSwipeItems();


                  FirebaseUtils.showSuccess("Swiped All Successfully");
                },
                itemChanged: (SwipeItem item, int index) {
                  print("Item: ${item.content} Index: $index");
                  indexValue.value = index;
                },
                upSwipeAllowed: false,
                fillSpace: true,
                leftSwipeAllowed: _canSwipe(),
                rightSwipeAllowed: _canSwipe(),
              ),
            ],
          ),
        ),
        // Bottom controls for swiping actions (left/right)
        _buildSwipeControls(),
      ],
    )
        : Center(
      child: CircularProgressIndicator(
        color: Color(0xFFA26837),
      ),
    );
  }

  // Custom bottom controls for swiping
  Widget _buildSwipeControls() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: Get.width * .65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(
          color: Color(0xFFA7713F),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (_canSwipe()) {
                _handleNopeAction();
              } else {
                FirebaseUtils.showError(
                    'You have no swipes left. Please buy more swipes or become a golden member for unlimited swipes!'
                );
              }
            },
            child: Transform.scale(
              scale: _crossSize,
              child: CircleAvatar(
                backgroundColor: Color(0xFF1D1D1D),
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
          Obx(() {
            return GestureDetector(
              onTap: () {
                log(Get.find<ControllerHome>().user.value!.user.boostCount.toString());
                boostController.activateBoost();
              },
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: Color(0xFFA7713F),
                child: (boostController.isLoading.value)?Center(child: CircularProgressIndicator(),):SvgPicture.asset(
                  "assets/icons/icon_flah.svg",
                ).marginSymmetric(horizontal: 5.h),
              ),
            );
          }),
          // Other controls like chat button, boost button, etc.
          Obx(() {
            return GestureDetector(
              onTap: () async {
                if (Get
                    .find<ControllerHome>()
                    .user
                    .value!
                    .user
                    .goldenMember == 1 && Get
                    .find<ControllerHome>()
                    .user
                    .value!
                    .user
                    .message_count! > 0) {
                  if (widget.userList[indexValue.value].userType ==
                      "couple") {
                    await coupleController.fetchCoupleDetails(widget
                        .userList[indexValue.value]
                        .coupleId.toString())
                        .then((userCouple) async {
                      List<User> userList = userCouple.data;
                      if (userList.length > 1) {
                        User currentUser = Get
                            .find<ControllerHome>()
                            .user
                            .value!
                            .user;
                        if (currentUser.userType == "couple") {
                          await coupleController.fetchCoupleDetails(
                              currentUser.coupleId.toString()).then((myCouple) {
                            userList = myCouple.data.where((e) => e.id !=
                                currentUser.id)
                                .toList();
                            Get.to(ScreenUserChat(usersList: userList));
                          });
                        } else {
                          Get.to(ScreenUserChat(usersList: userList));
                        }
                      } else {
                        FirebaseUtils.showError(
                            "Your partner is not available");
                      }
                    });
                  } else {
                    log(widget.userList[indexValue.value].toString());
                    Get.to(ScreenUserChat(usersList: [
                      widget.userList[indexValue.value]
                    ]));
                  }
                }
                else {
                  FirebaseUtils.showError(
                      "You have to become a golden member to chat with this user");
                  Get.to(ScreenSubscription(isHome: true,));
                }
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Color(0xFF1D1D1D),
                    child: (coupleController.isLoading.value) ? SizedBox(
                      height: 14.h,
                      width: 14.w,
                      child: CircularProgressIndicator(color: Color(
                          0xFFA7713F),),) : SvgPicture.asset(
                      "assets/icons/icon_chat.svg",
                    ).marginSymmetric(horizontal: 5.sp),
                  ),
                  // Positioned(
                  //   top: 0.0,
                  //   right: 0.sp,
                  //   child: CircleAvatar(
                  //     radius: 8.r,
                  //     backgroundColor: Color(0xFFA7713F),
                  //     child: Text(
                  //       "20",
                  //       style: TextStyle(
                  //         fontSize: 7.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }),
          GestureDetector(
            onTap: () {
              if (_canSwipe()) {
                _handleLikeAction(widget.userList[indexValue.value]);
              } else {
                FirebaseUtils.showError(
                    'You have no swipes left. Please buy more swipes or become a golden member for unlimited swipes!'
                );
              }
            },
            child: Transform.scale(
              scale: _heartSize,
              child: CircleAvatar(
                backgroundColor: Color(0xFFA7713F),
                child: SvgPicture.asset(
                  "assets/icons/icon_heart.svg",
                ).marginSymmetric(horizontal: 5.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chat button implementation
  Widget _buildChatButton() {
    return GestureDetector(
      onTap: () async {
        // Chat action logic
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: Color(0xFF1D1D1D),
            child: SvgPicture.asset(
              "assets/icons/icon_chat.svg",
            ).marginSymmetric(horizontal: 5.sp),
          ),
        ],
      ),
    );
  }
}
