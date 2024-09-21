import 'package:blaxity/views/layouts/item_personal_user_chat_list.dart';
import 'package:flutter/material.dart';

import '../../models/last_message.dart';

class LayoutPersonalChat extends StatelessWidget {
List<LastMessage> lastMessageList;
  @override
  Widget build(BuildContext context) {
    return (lastMessageList.isNotEmpty)?ListView.builder(
      itemCount: lastMessageList.length,
      itemBuilder: (context, index) {
        return ItemPersonalUserChatList(lastMessage: lastMessageList[index],);
      },

    ):Center(child: Text("No Chats"),);
  }

LayoutPersonalChat({
    required this.lastMessageList,
  });
}
