import 'package:blaxity/views/layouts/item_group_chat_list.dart';
import 'package:flutter/material.dart';

import '../../models/last_message.dart';

class LayoutGroupChat extends StatelessWidget {
List<LastMessage> lastMessageList;
  @override
  Widget build(BuildContext context) {
    return (lastMessageList.isNotEmpty)?ListView.builder(
      itemCount: lastMessageList.length,
      itemBuilder: (context, index) {
        return ItemGroupChatList(lastMessage: lastMessageList[index],);
      },

    ):Center(child: Text("No Group"),);
  }

LayoutGroupChat({
    required this.lastMessageList,
  });
}
