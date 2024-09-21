import 'dart:convert';
import 'dart:developer';

import 'package:agora_token_service/agora_token_service.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_get_couple.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/ApiEndPoint.dart';
import '../constants/chat_constant.dart';
import '../constants/fcm.dart';
import '../constants/firebase_utils.dart';
import '../models/last_message.dart';
import '../models/message.dart';
import '../models/user.dart';

class ControllerPersonalChat extends GetxController {

  createCallRoom(String chatRoomId,List<User> userList) async{
    List<String?> idsList=userList.map((user)=>user.id).toList();
    idsList.add(FirebaseUtils.myId);
    var callRef=await FirebaseFirestore.instance.collection("user").doc(FirebaseUtils.myId).collection("chats").doc(chatRoomId).collection("calls").doc(chatRoomId).get();
     log("My Call Ref ${callRef.exists}");
    if (callRef.exists==false) {
      final audioToken = RtcTokenBuilder.build(
        appId: "4933a44ec0ef4d35957206e0c86e0035",
        appCertificate: "e6979c4dca344694a8b709bf1ed96d2c",
        channelName: "${chatRoomId}",
        uid: "",
        role: RtcRole.publisher,
        expireTimestamp: 0,
      );
      final videoToken = RtcTokenBuilder.build(
        appId: "4933a44ec0ef4d35957206e0c86e0035",
        appCertificate: "e6979c4dca344694a8b709bf1ed96d2c",
        channelName: "${chatRoomId}",
        uid: "",
        role: RtcRole.publisher,
        expireTimestamp: 0,
      );
      callsMap.value={
        "audioCall":audioToken,
        "videoCall":videoToken,
        "channelName":chatRoomId,
        "uid":"",
        "isCall":false
      };
      idsList.forEach((id) async {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(id)
            .collection("chats")
            .doc(chatRoomId).collection("calls").doc(chatRoomId).set(callsMap);
      });
    }
    getCalls(chatRoomId);
  }

  RxList<Message> messagesList = RxList([]);
  TextEditingController messageController = TextEditingController();
  RxString image = "".obs;
  RxString messageTyping = "".obs;
  RxString messageImageUrl = "".obs;
  ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  void getCalls(String chatRoomId)async{
     await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseUtils.myId).collection("chats").doc(chatRoomId)
        .collection("calls")
        .doc(chatRoomId)
        .get()
        .then((value) {
          log(value.data().toString());
          var myCalls=value.data();
          log("Call Value$myCalls");

          if(myCalls!=null){

            callsMap.value = myCalls as Map<String, dynamic>;
            log("Call log${myCalls.values}");
          }
      // Check if the document exists and has data
      // if (value.exists && value.data() != null) {
      //   return value.data() as Map<String, dynamic>; // Safely cast the data
      // }

    }).catchError((e) {
      // Log any potential errors
      print("Error fetching document: $e");
    });



    log(callsMap.toString());
  }
  RxMap<String,dynamic> callsMap=RxMap({});

  RxBool uploadingLoading = false.obs;

  Future<void> sendMessage({
    required String chatRoomId,
    required String message,
    required List<String> token,
    required MessageType messageType,
    required List<User> usersList,
    required int counter,
    VoiceMessage? voiceMessage,
    AudioMessage? audioMessage,
    VideoMessage? videoMessage,
    FileMessage? fileMessage,
    ImageMessage? imageMessage,
  })
  async {
    if (callsMap.values.isEmpty) {
     getCalls(chatRoomId);
    }
    bool isConnection=Get.find<ControllerHome>().user.value!.Connections!.contains(usersList.first.id.toString());
    log(isConnection.toString());
    if (Get.find<ControllerHome>().user.value!.user.goldenMember==1&&!isConnection) {
      checkMessageAndMembership();
      Get.find<ControllerHome>().fetchUserInfo();
    }
    int id = DateTime.now().millisecondsSinceEpoch;
    counter = counter;
/// For each
         Map<String,bool> cleared = {
           "${FirebaseUtils.myId}": false,
         };
        for (var user in usersList) {
          cleared[user.id.toString()] = false;
        }

    List<String> membersId = usersList.map((user) => user.id.toString()).toList();
        log(membersId.toString());
    membersId.add(FirebaseUtils.myId);
  log(membersId.toString());
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
     var callRef=await FirebaseFirestore.instance.collection("user").doc(FirebaseUtils.myId).collection("chats").doc(chatRoomId).get();
    // Create the last message map
    var lastMessageMap = LastMessage(
      sender: messageModel.senderId,
      lastMessage: messageType == MessageType.text
          ? message
          : messageType == MessageType.voice
              ? "Sent a voice message"
              : messageType == MessageType.video
                  ? "Sent a video"
                  : messageType == MessageType.image
                      ? "Sent an image"
                      : "Sent a file",
      timestamp: messageModel.timestamp,
      counter: counter,
      chatRoomId: chatRoomId,
      type: messageType,
      status: 'sent',
      membersId: membersId,
      roomType:
          "${usersList.length > 1 || Get.find<ControllerHome>().user.value!.user.userType == "couple" ? "couple" : "single"}", 
       // Specify the room type if applicable
    );

    // Save the last message and create the chat rooms
    for (String id in membersId) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(id)
          .collection("chats")
          .doc(chatRoomId)
          .set(
            lastMessageMap.toMap(),
          ).then((value) async {
            log("Call Exsit${!callRef.exists}");
            if (!callRef.exists==false) {
              final audioToken = RtcTokenBuilder.build(
                appId: "4933a44ec0ef4d35957206e0c86e0035",
                appCertificate: "e6979c4dca344694a8b709bf1ed96d2c",
                channelName: "${chatRoomId}",
                uid: "",
                role: RtcRole.publisher,
                expireTimestamp: 0,
              );
              final videoToken = RtcTokenBuilder.build(
                appId: "4933a44ec0ef4d35957206e0c86e0035",
                appCertificate: "e6979c4dca344694a8b709bf1ed96d2c",
                channelName: "${chatRoomId}",
                uid: "",
                role: RtcRole.publisher,
                expireTimestamp: 0,
              );
              await FirebaseFirestore.instance
                  .collection("user")
                  .doc(id)
                  .collection("chats")
                  .doc(chatRoomId).collection("calls").doc(chatRoomId).set({
                "audioCall":audioToken,
                "videoCall":videoToken,
                "channelName":chatRoomId,
                "uid":"",
                "isCall":false
              });
            }
          })
          .catchError((onError) {
        log("Other $onError");
        FirebaseUtils.showError(onError.toString());
      });
    }

    // Special handling for couples

    // Save the message to the chat room
    await chatref
        .child(chatRoomId)
        .child(messageModel.id)
        .set(messageModel.toJson())
        .then((value) {
      // Optional: Add logic after saving the message
    }).catchError((onError) {
      log(onError.toString());
    });
    for (var user in usersList) {

      if (user.id != FirebaseUtils.myId&&counter!=null) {
        log("message${user.id}");
        FirebaseFirestore.instance.collection('user').doc(user.id).collection('chats').get().then((value) async {
          if (value.docs.isNotEmpty) {

            for (var doc in value.docs) {
              log("message${user.id} ${doc['chatRoomId']}");
              if (doc['chatRoomId'] == chatRoomId) {
                FirebaseFirestore.instance.collection('user').doc(user.id).collection('chats').doc(doc.id).update({
                  'counter': FieldValue.increment(1),
                });
              }
            }
          }
        });

      }
    }
    // Send push notifications
    if (token.isNotEmpty) {
      String notificationMessage = _getNotificationMessage(messageModel);
      for (var token in token) {
        if (token.isNotEmpty) {
          FCM.sendPushMessage(
              token: token, body: notificationMessage, title: "New Message");
        }
      }
    }
  }

  String _getNotificationMessage(Message messageModel) {
    switch (messageModel.type) {
      case MessageType.text:
        return messageModel.content;
      case MessageType.voice:
        return "Sent a voice message";
      case MessageType.audio:
        return "Sent an audio message";
      case MessageType.image:
        return "Sent an image";
      case MessageType.video:
        return "Sent a video";
      case MessageType.file:
        return "Sent a file";
      default:
        return "New message";
    }
  }
  Future<void> clearChatForUser(String chatRoomId) async {
    var userId = FirebaseUtils.myId;

    // Get all messages in the chat room
    await chatref.child(chatRoomId).once().then((snapshot) {
      if (snapshot.snapshot.exists) {
        Map<dynamic, dynamic> messages = snapshot.snapshot.value as Map<dynamic, dynamic>;

        // Mark each message as cleared for the current user
        messages.forEach((messageId, messageData) async {
          await chatref
              .child(chatRoomId)
              .child(messageId)
              .child('cleared')
              .update({
            userId: true, // Mark the message as cleared for this user
          });
        });
      }
    });
  }
  RxBool isLoading = false.obs; // Observable to track the loading state
  Future<void> checkMessageAndMembership() async {
    String? token = await ControllerLogin.getToken(); // Get token for authorization
    if (token == null) {
      FirebaseUtils.showError('Authentication token is missing');
      return;
    }

    isLoading(true); // Start loading

    // API URL (replace {{local}} with actual base URL)
    String url = '${APiEndPoint.baseUrl}/user/messages';
    log("Url$url");

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set content type as JSON
          // Bearer token for authentication
        },
      );
      log("response: ${response}");
      log(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Extract relevant data for message count and golden membership status
        int remainingMessages = jsonResponse['remaining_messages'] ?? 0;
        bool isGoldenMember = jsonResponse['is_golden_member'] ?? false;

        if (!isGoldenMember) {
          // Case: User is not a golden member
          // Get.snackbar('Status', 'Please buy and become a golden member for unlimited services');
          // FirebaseUtils.showError('Please buy and become a golden member for unlimited services');
        }
        else if (remainingMessages > 0 && remainingMessages <= 5) {
          // Case: User has 5 or fewer messages left
          Get.snackbar('Message', 'You have $remainingMessages messages left. Match for unlimited messages!');
        } else if (remainingMessages == 0) {
          // Case: User has no messages left
          Get.snackbar('Message', 'You have no messages left. Please match the user for unlimited messages!');
        }
      } else {
        // Handle errors based on different status codes
        var jsonResponse = json.decode(response.body);
        FirebaseUtils.showError(jsonResponse['message'] ?? 'Failed to fetch data');
      }
    } catch (e) {
      log(e.toString());
      // Error in the request
      FirebaseUtils.showError('An error occurred: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }

}
