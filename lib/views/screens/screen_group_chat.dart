import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

// import 'package:android_path_provider/android_path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/controller_get_groups.dart';
import 'package:blaxity/models/group.dart' as g;
// import 'package:device_info/device_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:timer_count_down/timer_count_down.dart';

import '../../../constants/chat_constant.dart';
import '../../../constants/colors.dart';
import '../../../constants/file_pick.dart';
import '../../../constants/firebase_utils.dart';
import '../../../controllers/chat_controller.dart';
import '../../models/message.dart';
import '../../widgets/gradient_widget.dart';
import '../layouts/chat_buble.dart';
import '../layouts/item_image_message.dart';
import '../layouts/item_media.dart';
import '../layouts/item_message_audio.dart';
import '../layouts/item_video_message.dart';


class ScreenGroupChat extends StatefulWidget {
  g.Group group;

  @override
  State<ScreenGroupChat> createState() => _ScreenGroupChatState();

  ScreenGroupChat({
    required this.group,
  });
}

class _ScreenGroupChatState extends State<ScreenGroupChat> {
  ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  late Stream<DatabaseEvent> stream = Stream.empty();

  ChatController controller = Get.put(ChatController());
  GroupController groupController = Get.put(GroupController());

  RxList<String> membersName = RxList([]);

  @override
  void initState() {
    super.initState();
    groupController.fetchGroup(widget.group.id);
    controller.clearMessageCounter(
        widget.group.id.toString(), FirebaseUtils.myId);

    stream = chatGroupRef
        .child(widget.group.id.toString())
        .child('messages')
        .onValue;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.scrollToBottom();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isPlayingMsg = true.obs;
  bool isRecording = false,
      isSending = false;

  late bool _isLoading = true;
  late bool _permissionReady;
  late String _localPath;
  TargetPlatform? platform;
  int _selectedIndex = 0;

  final ImagePicker _picker = ImagePicker();

  void _onMenuItemClicked(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }

  void readMessage(List<Message> messages) async {
    for (Message message in messages) {
      if (message.senderId != FirebaseUtils.myId &&
          (message.status == 'sent' || message.status == 'delivered')) {
        await chatref
            .child(widget.group.id.toString())
            .child('messages')
            .child(message.id) // Assuming each message has a unique ID
            .update({'status': 'seen'});
      }
    }
  }

  RxList<Map<String, String>> transformGroupMembersToMentionData = RxList([]);

  @override
  Widget build(BuildContext context) {
    controller.clearMessageCounter(
        widget.group.id.toString(), FirebaseUtils.myId);


    // membersName.value = widget.group.members.where((m) => m.id != FirebaseUtils.myId)
    //     .map((e) => e.user!=null?e.user!.userType=="couple"?"${e.user!.partner1Name} and ${e.user!.partner2Name}":"${e.user!.fName}":"")
    //     .toList();
    // transformGroupMembersToMentionData.value =
    //     widget.group.members.map((member) {
    //       return {
    //         'id': member.id.toString(),
    //         'display': member.user!.userType=="couple"?"${member.user!.partner1Name} and ${member.user!.partner2Name}":"${member.user!.fName}",
    //         'token': member.user!.deviceToken ?? '',
    //         'full_name': member.user!.userType=="couple"?"${member.user!.partner1Name} and ${member.user!.partner2Name}":"${member.user!.fName}",
    //         // 'profile': member.user!.userType=="couple"?"${F}":"${member.user.fName}",
    //       };
    //     }).toList();
    // transformGroupMembersToMentionData.add({
    //   'id': "everyone",
    //   'display': "everyone",
    //   'token': "everyone",
    //   'full_name': "everyone",
    //   'profile': "${APiEndPoint.imageUrl}/4ScYhPACYYn5BKhkAIic.jpg",
    // });

    log("Men${transformGroupMembersToMentionData.toString()}");

    var adminMember = widget.group.members.where((element) =>
    element.isAdmin == 1).toList();
    bool isCurrentUserAdmin = adminMember.any((element) =>
    element.userId.toString() == FirebaseUtils.myId);
    Future.delayed(Duration(milliseconds: 2), () {
      controller.scrollToBottom();
    });


    groupController.fetchGroup(widget.group.id);
    List<String> membersTokens = widget.group.members.map((e) =>
    e.user == null
        ? ""
        : e.user!.deviceToken?? "").toList();
    membersTokens=membersTokens.where((element) => element!=FirebaseUtils.myToken).toList();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 60,
          title: GestureDetector(
            onTap: () {
              // Get.to(
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    widget.group.title,
                    style: TextStyle(fontSize: 18))
              ],
            ),
          ),
          actions: [
          ],
        ),
        body: Column(
          children: [
            Expanded( // Ensures that the ListView takes only the remaining space
              child: StreamBuilder<DatabaseEvent>(
                key: ValueKey(widget.group.id),
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error loading messages"),
                    );
                  }
                  if (!snapshot.hasData ||
                      snapshot.data!.snapshot.value == null) {
                    return Center(
                      child: Text("No message"),
                    );
                  }


                  var messages = snapshot.data!.snapshot.children
                      .map((e) => Message.fromJson(
                      Map<String, dynamic>.from(e.value as dynamic)))
                      .toList();

                  messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.scrollToBottom();
                  });
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    physics: BouncingScrollPhysics(),
                    controller: controller.scrollController,
                    reverse: false,
                    // Ensures that the list starts from the bottom
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      Message messageData = messages[index];
                      String senderId = messageData.senderId;
                      bool showImage = index == 0 ||
                          messages[index - 1].senderId != senderId;

                      switch (messageData.type) {
                        case MessageType.text:
                          return ChatBubble(
                            message: messageData,
                            chatId: widget.group.id.toString(),
                            showImage: showImage,
                            notificationToken: '',
                            notificationsList: membersTokens,
                          );
                        case MessageType.voice:
                          return ItemMessageAudio(
                            message: messageData,
                            chatId: widget.group.id.toString(),
                            showImage: showImage,
                            notificationToken: '',
                            notificationsList: membersTokens,
                          );
                        case MessageType.audio:
                          return ItemMessageAudio(
                            message: messageData,
                            showImage: showImage,
                            chatId: widget.group.id.toString(),
                            notificationToken: '',
                            notificationsList: membersTokens,
                          );
                        case MessageType.image:
                          return ImageMessageBubble(
                            showImage: showImage,
                            message: messageData,
                            chatId: widget.group.id.toString(),
                            notificationToken: '',
                            notificationsList: membersTokens,
                          );
                        case MessageType.video:
                          return VideoMessageBubble(
                            message: messageData,
                            chatId: widget.group.id.toString(),
                            showImage: showImage,
                            notificationToken: '',
                            notificationsList: membersTokens,
                          );
                        case MessageType.file:
                          return ItemMedia(
                            message: messageData,
                            chatId: widget.group.id.toString(),
                            showImage: showImage,
                            notificationToken: '',
                            notificationsList: membersTokens,
                          );
                        default:
                          return Container();
                      }
                    },
                  );
                },
              ),
            ),
            GradientWidget(child: Divider(thickness: 2,)),
            buildTextFieldContainer(context, controller, membersTokens)
          ],
        ));
  }

  RxList<Map<String, String>> _mentions = <Map<String, String>>[].obs;
  final GlobalKey<FlutterMentionsState> mentionsKey =
  GlobalKey<FlutterMentionsState>();

  Widget buildTextFieldContainer(BuildContext context,
      ChatController controller, List<String> tokensList) {
    return Row(
      children: [
        GestureDetector(
            onTap: () async {
              _showBottomSheet(context, tokensList);
            },
            child: Obx(() {
              return controller.uploadingLoading.value
                  ? SizedBox(
                height: 20.sp,
                width: 20.sp,
                child: CircularProgressIndicator(
                  // strokeWidth: 1,
                  backgroundColor: Colors.white,
                ),
              )
                  :SvgPicture.asset("assets/icons/icon_user_chat.svg");
            })),
        Expanded(
          child: FlutterMentions(
            key: mentionsKey,
            textInputAction: TextInputAction.send,
            onMentionAdd: (mention) {
              if (mention['id'] == "everyone") {
                _mentions.clear();
                _mentions.add({
                  'id': mention['id'],
                  'display': mention['display'],
                  'token': mention['token'],
                  'full_name': mention['full_name'],
                  'profile': mention['profile'],
                });
              } else {
                _mentions.add({
                  'id': mention['id'],
                  'display': mention['display'],
                  'token': mention['token'],
                  'full_name': mention['full_name'],
                  'profile': mention['profile'],
                });
              }
              log(_mentions.toString());
            },
            onChanged: (value) {
              controller.messageTyping.value = value;
              annotationcontroller.text = value;
              // Handle text change
            },
            suggestionPosition: SuggestionPosition.Top,
            minLines: 1,
            maxLines: 7,
            cursorColor: Color(0xFFA7713F),
            decoration: InputDecoration(
              hintText: "Type something..",

              hintStyle:TextStyle(
                color: Color(0xFFAAAAAA),
              ),
              contentPadding: EdgeInsets.all(10.sp),
              border: InputBorder.none,
            ),
            mentions: [
              Mention(
                trigger: '@',
                style: TextStyle(color: Colors.blue),
                data: transformGroupMembersToMentionData,
                suggestionBuilder: (data) {
                  return SizedBox(
                    width: Get.width * 0.3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${APiEndPoint.imageUrl}${data['profile']}"),
                      ),
                      title: Text(data['full_name']),
                    ),
                  ).marginOnly(left: 50.w);
                },
              ),
            ],
          ).marginOnly(left: 10.sp, right: 5.w),
        ),
        SendVoiceMessage(tokensList).marginOnly(right: 5.w),
    SendTextMessage(tokensList).marginOnly(right: 5.w),
      ],
    ).marginSymmetric(horizontal: 10.w, vertical: 7.h);
  }

  void _showBottomSheet(BuildContext context, List<String> tokensList) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return buildBottomSheet(context, tokensList);
      },
    );
  }

  final annotationcontroller = TextEditingController();

  InkWell SendTextMessage(List<String> tokensList) {
    return InkWell(
      onTap: () async {
        String message = annotationcontroller.text.trim();
        mentionsKey.currentState?.controller?.clear();

        annotationcontroller.clear();

        if (message.isNotEmpty) {
          log(_mentions.toString());
          List<String> tokens = [];
          if (_mentions.any((mention) => mention['id'] == "everyone")) {
            tokens.addAll(tokensList);
          } else {
            // Only get tokens of mentioned users

            tokensList
                .where((element) =>
                _mentions
                    .any((mention) => mention['token'] == element))
                .forEach((element) {
              _mentions
                  .where((mention) => mention['token'] == element)
                  .forEach((element) {
                tokensList.add(element['token'] ?? "");
              });
            });
          }

          log(tokens.toString());
          controller.messageTyping.value = "";
          controller
              .sendMessage(
            group: widget.group,
            message: message,
            tokens: _mentions.isNotEmpty
                ? tokens
                : tokensList,
            messageType: MessageType.text,
            mentions: _mentions,
          )
              .then((value) {
            controller.image.value = "";
            _mentions.clear();
            controller.scrollToBottom();

            controller.messageTyping.value = "";
          }).catchError((error) {
            log(error.toString());
          });
        }
        controller.image.value = "";
      },
      child: Container(
        height: 35.h,
        width: 70.14.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: AppColors.buttonColor,
        ),
        child: Center(
          child: Text("Send", style: TextStyle(
            color: Colors.white,
            fontSize: 12.36.sp,
          ),),
        ),
      ),
    );
  }

  GestureDetector SendVoiceMessage(List<String> tokensList) {
    return GestureDetector(
      onTap: () async {
        String text = annotationcontroller.text;
        RecorderController recorderController = RecorderController()
          ..androidEncoder = AndroidEncoder.aac
          ..androidOutputFormat = AndroidOutputFormat.mpeg4
          ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
          ..sampleRate = 44100;
        var sendClicked = false.obs;

        RxString duration = "".obs;
        duration.bindStream(recorderController.onCurrentDuration
            .map((event) => "${formatDuration(event, "mm:ss")}"));

        if (text.isEmpty) {
          String id = FirebaseUtils.newId.toString();
          var recordPermissionAllowed =
          (await recorderController.checkPermission());
          var storagePermissionAllowed = await _checkStoragePermission();
          // print(permissionAllowed
          if (recordPermissionAllowed && storagePermissionAllowed) {
            var dir = await _prepareSaveDir();
            var path = "$dir${Platform.pathSeparator}$id.m4a";
            print(path);

            recorderController.record(path: path);

            Get.bottomSheet(StatefulBuilder(builder: (context, setState) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // height: Get.height * .15,
                        child: Column(
                          children: [
                            ListTile(
                              title: AudioWaveforms(
                                size: Size(Get.width * .5, 50),
                                recorderController: recorderController,
                                enableGesture: true,
                                waveStyle: WaveStyle(
                                  // showDurationLabel: true,
                                    spacing: 8.0,
                                    showBottom: false,
                                    extendWaveform: true,
                                    showMiddleLine: false,
                                    gradient: ui.Gradient.linear(
                                      const Offset(70, 50),
                                      Offset(
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width / 2,
                                          0),
                                      [Colors.red, Colors.green],
                                    ),
                                    waveColor: Colors.black),
                              ),
                              trailing: Container(
                                  padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(0xff866e02),
                                      shape: BoxShape.circle),
                                  child: Obx(() {
                                    return IconButton(
                                      onPressed: sendClicked.isTrue
                                          ? null
                                          : () async {
                                        sendClicked.value = true;
                                        var path =
                                        await recorderController
                                            .stop(false);
                                        print(path);
                                        if (path != null) {
                                          await FirebaseStorageUtils
                                              .uploadImage(
                                              (File(path)),
                                              "GroupChat/${widget.group.id
                                                  .toString()}",
                                              "Voice Message ${id}")
                                              .then((value) {
                                            if (path != null) {
                                              controller.sendMessage(
                                                group: widget.group,
                                                message: '',
                                                tokens: tokensList,
                                                messageType:
                                                MessageType.voice,
                                                voiceMessage:
                                                VoiceMessage(
                                                    voiceUrl: value!,
                                                    duration: duration
                                                        .value),
                                              );

                                              sendClicked.value = false;
                                              recorderController
                                                  .dispose();
                                              Get.back();
                                              // Get.back();
                                            }
                                          }).catchError((error) {
                                            sendClicked.value = false;
                                            recorderController.dispose();
                                            Get.back();
                                          });
                                        } else {
                                          sendClicked.value = false;
                                          recorderController.dispose();
                                          Get.back();
                                        }
                                      },
                                      icon: Obx(() {
                                        return (sendClicked.value)
                                            ? CircularProgressIndicator()
                                            : Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        );
                                      }),
                                    );
                                  })),
                              leading: IconButton(
                                  onPressed: () {
                                    recorderController.dispose();
                                    Get.back();
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                            Obx(() {
                              return Text(
                                duration.value,
                                style: TextStyle(fontSize: 16.sp),
                              ).paddingAll(10);
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                isDismissible: false);
          }
        }
      },
      child: Icon(
        CupertinoIcons.mic,
        color: Colors.white,
      ).marginAll(8.sp),
    );
  }


  Container buildBottomSheet(BuildContext context, List<String> tokensList) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 280.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select an option',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOption(
                context,
                icon: Icons.image,
                label: 'Image',
                onTap: () {
                  pickImage(tokensList);
                  Get.back();

                  // Handle image upload
                },
              ),
              _buildOption(
                context,
                icon: Icons.video_library,
                label: 'Video',
                onTap: () {
                  pickVideo(tokensList);
                  Get.back();

                  // Handle video upload
                },
              ),
              _buildOption(
                context,
                icon: Icons.audiotrack,
                label: 'Audio',
                onTap: () {
                  pickAudio(tokensList);
                  Get.back();

                  // Handle audio upload
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOption(
                context,
                icon: Icons.insert_drive_file,
                label: 'Document',
                onTap: () {
                  pickDocument(tokensList);
                  Get.back();
                },
              ),
              _buildOption(
                context,
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () {
                  pickCamera(tokensList);
                  Get.back();
                },
              ),
              _buildOption(
                context,
                icon: Icons.image,
                label: 'Gallery',
                onTap: () {
                  pickGallery(tokensList);
                  Get.back();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector _buildOption(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, size: 30, color: Colors.blue),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Future<String?> _findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        // externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<String> _prepareSaveDir() async {
    _localPath = (await getTemporaryDirectory()).path;
    _localPath = '$_localPath${Platform.pathSeparator}Skorpio';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }
    return savedDir.path;
  }

  Future<bool> _checkStoragePermission() async {
    if (Platform.isIOS) return true;

    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var androidInfo;
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (platform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkStoragePermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }

    setState(() {
      _permissionReady = hasGranted;
    });
  }

  Future<void> pickCamera(List<String> tokensList) async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      controller.uploadingLoading.value = true;
      var file = File(pickedFile.path);
      var fileSize = await file.length();

      var url = await FirebaseStorageUtils.uploadImage(
          file, 'GroupChat/${widget.group.id.toString()}', pickedFile.name)
          .then((value) {
        controller.sendMessage(
            group: widget.group,
            message: "",
            tokens: tokensList,
            messageType: MessageType.file,
            fileMessage: FileMessage(
                fileName: pickedFile.name,
                fileUrl: value!,
                fileSize: fileSize.toString()));
        controller.uploadingLoading.value = false;
      }).catchError((error) {
        Get.snackbar("Alert", error.toString());
        controller.uploadingLoading.value = false;

        // SendMessage(value, 'file', pickedFile.name);
      }).catchError((eror) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(SnackBar(content: Text(eror.toString())));
        controller.uploadingLoading.value = false;
      });
    }
  }

  Future<void> pickGallery(List<String> tokensList) async {
    try {
      final XFile? pickedFile =
      await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Process the picked image file
        print('Gallery image picked: ${pickedFile.path}');
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  void pickDocument(List<String> tokensList) async {
    var pickedFile = await FilePick().pickFile(FileType.any);
    if (pickedFile != null) {
      controller.uploadingLoading.value = true;
      var file = File(pickedFile.path);
      var fileSize = await file.length();

      var url = await FirebaseStorageUtils.uploadImage(
          file, 'GroupChat/${widget.group.id.toString()}', pickedFile.name)
          .then((value) {
        controller.sendMessage(
            group: widget.group,
            message: "",
            tokens: tokensList,
            messageType: MessageType.file,
            fileMessage: FileMessage(
                fileName: pickedFile.name,
                fileUrl: value!,
                fileSize: fileSize.toString()));
        controller.uploadingLoading.value = false;
      }).catchError((error) {
        Get.snackbar("Alert", error.toString());
        controller.uploadingLoading.value = false;

        // SendMessage(value, 'file', pickedFile.name);
      }).catchError((eror) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(SnackBar(content: Text(eror.toString())));
        controller.uploadingLoading.value = false;
      });
    }
  }

  void pickVideo(List<String> tokensList) async {
    var pickedFile = await FilePick().pickFile(FileType.video);
    if (pickedFile != null) {
      controller.uploadingLoading.value = true;
      var file = File(pickedFile.path);
      var fileSize = await file.length();

      var url = await FirebaseStorageUtils.uploadImage(
          file, 'GroupChat/${widget.group.id.toString()}', pickedFile.name)
          .then((value) {
        controller.sendMessage(
            group: widget.group,
            message: "",
            tokens: tokensList,
            messageType: MessageType.video,
            videoMessage:
            VideoMessage(videoUrl: value!, duration: fileSize.toString()));
        controller.uploadingLoading.value = false;
      }).catchError((error) {
        Get.snackbar("Alert", error.toString());
        controller.uploadingLoading.value = false;

        // SendMessage(value, 'file', pickedFile.name);
      }).catchError((eror) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(SnackBar(content: Text(eror.toString())));
        controller.uploadingLoading.value = false;
      });
    }
  }

  void pickAudio(List<String> tokensList) async {
    var pickedFile = await FilePick().pickFile(FileType.audio);
    if (pickedFile != null) {
      controller.uploadingLoading.value = true;
      var file = File(pickedFile.path);
      var fileSize = await file.length();

      var url = await FirebaseStorageUtils.uploadImage(
          file, 'GroupChat/${widget.group.id.toString()}', pickedFile.name)
          .then((value) {
        controller.sendMessage(
            group: widget.group,
            message: "",
            tokens: tokensList,
            messageType: MessageType.audio,
            audioMessage: AudioMessage(
              audioUrl: value!,
              duration: pickedFile.name,
            ));
        controller.uploadingLoading.value = false;
      }).catchError((error) {
        Get.snackbar("Alert", error.toString());
        controller.uploadingLoading.value = false;

        // SendMessage(value, 'file', pickedFile.name);
      }).catchError((eror) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(SnackBar(content: Text(eror.toString())));
        controller.uploadingLoading.value = false;
      });
    }
  }

  void pickImage(List<String> tokensList) async {
    var pickedFile = await FilePick().pickFile(FileType.image);
    if (pickedFile != null) {
      controller.uploadingLoading.value = true;
      var file = File(pickedFile.path);
      var url = await FirebaseStorageUtils.uploadImage(
          file, 'GroupChat/${widget.group.id.toString()}', pickedFile.name)
          .then((value) {
        controller.sendMessage(
            group: widget.group,
            message: "",
            tokens: tokensList,
            messageType: MessageType.image,
            imageMessage: ImageMessage(
              imageUrl: value!,
            ));
        controller.uploadingLoading.value = false;
      }).catchError((error) {
        log(error.toString());
        Get.snackbar("Alert", error.toString());
        controller.uploadingLoading.value = false;

        // SendMessage(value, 'file', pickedFile.name);
      }).catchError((error) {
        log(error.toString());

        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        controller.uploadingLoading.value = false;
      });
    } else {
      controller.uploadingLoading.value = false;
      log("Image not selected");
    }
  }

  String formatDuration(Duration duration, String formatPattern) {
    final formatter = DateFormat(formatPattern);
    return formatter.format(DateTime(0, 0, 0, duration.inHours,
        duration.inMinutes % 60, duration.inSeconds % 60));
  }
}

class FirebaseStorageUtils {
  static Future<String?> uploadImage(File file, String path,
      String name) async {
    try {
      // Create a reference to the location you want to upload to
      var ref = FirebaseStorage.instance.ref().child("$path/$name");

      // Optionally, you can set metadata for the file
      final metadata = SettableMetadata(
        contentType: 'image/jpeg/png/gif/webp/tiff/bmp/pdf/svg',
        customMetadata: {'uploaded-by': 'Blaxity'},
      );

      // Upload the file to Firebase Storage
      await ref.putFile(file, metadata);

      // Get and return the download URL
      var url = await ref.getDownloadURL();
      return url;
    } catch (error) {
      // Log any errors encountered during the upload process
      print("Error uploading image: $error");
      return null;
    }
  }
}
