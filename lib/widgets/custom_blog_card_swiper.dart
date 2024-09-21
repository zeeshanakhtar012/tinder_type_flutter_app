import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/models/blog.dart';
import 'package:blaxity/models/event.dart';
import 'package:blaxity/views/layouts/item_blog/item_blog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../views/layouts/item_club_home_event.dart';
import 'package:get/get.dart';
class CustomBlogCardSwiper extends StatefulWidget {
  RxList<Blog> blogList;
  CustomBlogCardSwiper({Key? key, required this.blogList}) : super(key: key);

  @override
  State<CustomBlogCardSwiper> createState() => _CustomBlogCardSwiperState();
}



class _CustomBlogCardSwiperState extends State<CustomBlogCardSwiper> {
  MatchEngine? _matchEngine;
  final List<SwipeItem> _swipeItems = [];

  @override
  void initState() {
    super.initState();

    // Listen to changes in the events list
    ever(widget.blogList, (_) => _loadSwipeItems());
    _loadSwipeItems();
  }

  void _loadSwipeItems() {
    _swipeItems.clear(); // Clear existing items to avoid duplicates
    for (var event in widget.blogList) {
      _swipeItems.add(SwipeItem(
        content: ItemBlog(blog: event, ),
        likeAction: () {
          print('Swiped Right');
        },
        nopeAction: () {
          print('Swiped Left');
        },
      ));
    }
    setState(() {
      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    });
  }
  void _resetSwipeItems() {
    // Reset swipe items to start over from the beginning
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    setState(() {}); // Rebuild the UI to reflect the changes
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
          _resetSwipeItems(); // Reset swipe items to start again

          // eventController.fetchEvents();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You have reached the end of the events.")),
          );
        },
        itemChanged: (SwipeItem item, int index) {
          print("Item: ${item.content} Index: $index");
        },
        upSwipeAllowed: false,
        fillSpace: true,
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}
