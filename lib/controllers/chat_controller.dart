import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/chat_constant.dart';
import '../constants/fcm.dart';
import '../constants/firebase_utils.dart';
import '../models/group.dart' as g;
import '../models/message.dart';

class ChatController extends GetxController {
  Future<void> clearMessageCounter(String groupId, String userId) async {
    try {
      await chatGroupRef
          .child(groupId)
          .child('messageCounters')
          .child(userId)
          .set(0);

      log("Unread message counter for user $userId in group $groupId cleared.");
    } catch (error) {
      log("Error clearing message counter: $error");
    }
  }

  RxList<Message> messages = RxList([]);

  // TextEditingController messageController = TextEditingController();
  RxString image = "".obs;
  RxString messageTyping = "".obs;
  RxString messageImageUrl = "".obs;
  ScrollController scrollController = ScrollController();
  RxBool uploadingLoading = false.obs;
  RxInt remainingTime = 0.obs;
  RxBool canSendMessage = false.obs;

  // DateTime? lastMessageTime;
  List<Message> getMyMessages() {
    return messages.value
        .where((message) => message.senderId == FirebaseUtils.myId)
        .toList();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }
  }


  Future<void> sendMessage({
    required g.Group group,
    required String message,
    required List<String?> tokens,
    required MessageType messageType,
    VoiceMessage? voiceMessage,
    AudioMessage? audioMessage,
    VideoMessage? videoMessage,
    FileMessage? fileMessage,
    ImageMessage? imageMessage,
    List<Map<String, String>>? mentions,
  }) async {
    List<String> tokensList =
        tokens.where((token) => token != null).cast<String>().toList();
    log("Mention List$mentions");
    log("Tokens List$tokensList");
    int id = DateTime.now().millisecondsSinceEpoch;
    Message messageModel = Message(
      id: id.toString(),
      senderId: FirebaseUtils.myId,
      senderName: FirebaseUtils.myName,
      senderProfileImage: FirebaseUtils.myImage,
      content: message,
      type: messageType,
      cleared: {},
      status: "sent",
      timestamp: DateTime.now().millisecondsSinceEpoch,
      voiceMessage: messageType == MessageType.voice ? voiceMessage : null,
      audioMessage: messageType == MessageType.audio ? audioMessage : null,
      imageMessage: messageType == MessageType.image ? imageMessage : null,
      videoMessage: messageType == MessageType.video ? videoMessage : null,
      fileMessage: messageType == MessageType.file ? fileMessage : null,
    );

    try {
      Map<String, dynamic> messageData = messageModel.toJson();
      await chatGroupRef
          .child(group.id.toString())
          .child('messages')
          .child(messageModel.id)
          .set(messageData);
      log("Message sent successfully.");
      for (var member in group.members) {
        if (member.userId.toString() != FirebaseUtils.myId) {
          log(member.userId.toString());
          await chatGroupRef
              .child(group.id.toString())
              .child('messageCounters')
              .child(member.userId.toString())
              .runTransaction((Object? counter) {
            if (counter == null) {
              return Transaction.success(1);
            } else {
              int currentValue = counter as int;
              return Transaction.success(currentValue + 1);
            }
          });
        }
      }

      // Update remaining time and send  notifications
      updateRemainingTimeAndSendNotification(tokensList, messageModel, group);
      scrollToBottom();
    } catch (error) {
      log("Error sending message: $error");
    }
  }

  void updateRemainingTimeAndSendNotification(
      List<String> tokensList, Message messageModel, g.Group group) {
    if (tokensList.isNotEmpty) {
      String notificationMessage = "";
      switch (messageModel.type) {
        case MessageType.text:
          notificationMessage = messageModel.content;
          break;
        case MessageType.voice:
          notificationMessage = "Sent a voice message";
          break;
        case MessageType.audio:
          notificationMessage = "Sent an audio message";
          break;
        case MessageType.image:
          notificationMessage = "Sent an image";
          break;
        case MessageType.video:
          notificationMessage = "Sent a video";
          break;
        case MessageType.file:
          notificationMessage = "Sent a file";
          break;
      }
      for(var token in tokensList) {
        if (token != null) {
          FCM.sendPushMessage(token: token, body: notificationMessage, title: "Group.${group.title}");
        }
      }
    }
  }



}
