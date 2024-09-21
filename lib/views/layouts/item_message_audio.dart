import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../constants/fcm.dart';
import '../../../constants/firebase_utils.dart';
import '../../../models/message.dart';

class ItemMessageAudio extends StatefulWidget {
  final Message message;
  String chatId;
  final Function(bool isPlaying)? isPlaying;
  final bool? disabled;
  bool showImage;
  bool? personalChat;
  String notificationToken;
  List<String> notificationsList;

  @override
  _ItemMessageAudioState createState() => _ItemMessageAudioState();

  ItemMessageAudio({
    required this.message,
    required this.chatId,
    this.isPlaying,
    this.disabled,
    required this.showImage,
    this.personalChat = false,
    required this.notificationToken,
    required this.notificationsList,
  });
}

class _ItemMessageAudioState extends State<ItemMessageAudio> {
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool loading = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
        if (widget.isPlaying != null) {
          widget.isPlaying!(isPlaying);
        }
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration ?? Duration.zero;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition ?? Duration.zero;
      });
    });
    _startUpdatingSlider();
  }

  @override
  void dispose() {
    _stopUpdatingSlider();
    audioPlayer.dispose();
    super.dispose();
  }

  void _startUpdatingSlider() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (_) async {
      position = (await audioPlayer.getCurrentPosition()) ?? Duration.zero;
      setState(() {});
    });
  }

  void _stopUpdatingSlider() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      key: widget.key,
      alignment: widget.message.senderId == FirebaseUtils.myId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.personalChat == true
                  ? SizedBox()
                  : (widget.message.senderId != FirebaseUtils.myId &&
                          widget.showImage)
                      ? Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${widget.message.senderProfileImage}"))),
                        )
                      : SizedBox(
                          width: 32.w,
                          height: 32.h,
                        ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      widget.message.senderId == FirebaseUtils.myId
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    if (widget.personalChat == false && widget.showImage)
                      Text(
                        widget.message.senderName,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ).marginOnly(top: 4.0),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppColors.chatColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  widget.message.senderId ==
                                          FirebaseUtils.myId
                                      ? 15.0
                                      : 2.0),
                              bottomRight: Radius.circular(
                                  widget.message.senderId ==
                                          FirebaseUtils.myId
                                      ? 2.0
                                      : 15.0),
                              bottomLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 2),
                            width: Get.width * 0.5,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      if (widget.disabled != null &&
                                          widget.disabled! &&
                                          !isPlaying) {
                                        Get.snackbar("Alert",
                                            "Please pause another playing audio first",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                        return;
                                      }

                                      if (!isPlaying) {
                                        setState(() {
                                          loading = true;
                                        });
                                        await audioPlayer.setSourceUrl(
                                            widget.message.voiceMessage!
                                                .voiceUrl);
                                        await audioPlayer.audioCache;
                                        await audioPlayer.resume();
                                        setState(() {
                                          loading = false;
                                        });
                                      } else {
                                        await audioPlayer.pause();
                                      }
                                    },
                                    icon: loading
                                        ? SizedBox(
                                            height: 10.sp,
                                            width: 10.sp,
                                            child:
                                                CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color:
                                                  widget.message.senderId ==
                                                          FirebaseUtils.myId
                                                      ? Colors.white
                                                      : Colors.blue,
                                            ),
                                          )
                                        : (!loading && isPlaying)
                                            ? Icon(
                                                Icons.pause,
                                                color: widget.message
                                                            .senderId ==
                                                        FirebaseUtils.myId
                                                    ? Colors.white
                                                    : Colors.blue,
                                              )
                                            : Icon(
                                                Icons.play_arrow,
                                                color: widget.message
                                                            .senderId ==
                                                        FirebaseUtils.myId
                                                    ? Colors.white
                                                    : Colors.blue,
                                              )),
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.sp,
                                        child: SliderTheme(
                                          data: SliderThemeData(
                                            trackHeight: 3,
                                            thumbColor: Colors.green,
                                            thumbShape:
                                                RoundSliderThumbShape(
                                                    enabledThumbRadius: 6),
                                          ),
                                          child: Slider(
                                            activeColor:
                                                widget.message.senderId ==
                                                        FirebaseUtils.myId
                                                    ? Colors.white
                                                    : Colors.blue,
                                            inactiveColor:
                                                widget.message.senderId ==
                                                        FirebaseUtils.myId
                                                    ? Colors.white
                                                    : Colors.blue,
                                            min: 0,
                                            max: duration.inMilliseconds
                                                .toDouble(),
                                            value: position.inMilliseconds
                                                .toDouble(),
                                            onChanged: (value) {
                                              final position = Duration(
                                                  milliseconds:
                                                      value.toInt());
                                              audioPlayer.seek(
                                                  position); // Assuming this is an asynchronous operation
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    if (widget.message.senderId == FirebaseUtils.myId)
                      Text(
                        widget.message.status,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                  ],
                ),
              ),
              widget.personalChat == true
                  ? SizedBox()
                  : (widget.message.senderId == FirebaseUtils.myId &&
                          widget.showImage)
                      ? Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${widget.message.senderProfileImage}"))),
                        )
                      : SizedBox(
                          width: 35.w,
                          height: 35.h,
                        ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration, String formatPattern) {
    final formatter = DateFormat(formatPattern);
    return formatter.format(DateTime(0, 0, 0, duration.inHours,
        duration.inMinutes % 60, duration.inSeconds % 60));
  }

}



