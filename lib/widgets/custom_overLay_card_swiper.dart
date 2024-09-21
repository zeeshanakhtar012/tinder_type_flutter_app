import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:get/get.dart';

import '../views/screens/overlay_screen/screen_overlay.dart';

class CustomOverLayCardSwiper extends StatefulWidget {
  final VoidCallback onDismiss; // Callback for dismiss action

  CustomOverLayCardSwiper({required this.onDismiss});

  @override
  State<CustomOverLayCardSwiper> createState() => _CustomOverLayCardSwiperState();
}

class _CustomOverLayCardSwiperState extends State<CustomOverLayCardSwiper> {
  MatchEngine? _matchEngine;
  final List<SwipeItem> _swipeItems = [];

  @override
  void initState() {
    super.initState();
    _loadSwipeItems();
  }

  void _loadSwipeItems() {
    _swipeItems.clear(); // Clear existing items to avoid duplicates

    // Add multiple items for testing
    for (var i = 0; i < 1; i++) {
      _swipeItems.add(SwipeItem(
        content: OverlayScreen(
          // onDismiss: widget.onDismiss,
        ),
        likeAction: () {
          _handleSwipeAction(isLike: true);
        },
        nopeAction: () {
          _handleSwipeAction(isLike: false);
        },
      ));
    }

    if (mounted) {
      setState(() {
        _matchEngine = MatchEngine(swipeItems: _swipeItems);
      });
    }
  }


  Future<void> _handleSwipeAction({required bool isLike}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOverlay', true);
    widget.onDismiss(); // Notify parent widget when the user interacts
  }

  @override
  Widget build(BuildContext context) {
    return _matchEngine != null
        ? Center(
      child: SwipeCards(
        matchEngine: _matchEngine!,
        itemBuilder: (BuildContext context, int index) {
          return _swipeItems[index].content;
        },
        onStackFinished: () {
          // Notify parent widget when the stack is finished
          widget.onDismiss();
        },
        itemChanged: (SwipeItem item, int index) {
          // Optional: Handle item changed action if needed
        },
        upSwipeAllowed: true,

        leftSwipeAllowed: true,
        rightSwipeAllowed: true,
        fillSpace: true,
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}
