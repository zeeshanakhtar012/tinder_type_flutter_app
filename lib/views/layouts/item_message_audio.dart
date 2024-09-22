import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../models/message.dart';

class ItemMessageAudio extends StatefulWidget {
  final Message message;
  final String chatId;
  final Function(bool isPlaying)? isPlaying;
  final bool? disabled;
  final bool showImage;
  final bool? personalChat;
  final String notificationToken;
  final List<String> notificationsList;

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
  final audioplayers.AudioPlayer audioPlayer = audioplayers.AudioPlayer();
  final PlayerController playerController = PlayerController();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool loading = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
    _initializeWaveform();
    _startUpdatingSlider();
  }

  Future<void> _initializeAudioPlayer() async {
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == audioplayers.PlayerState.playing;
        widget.isPlaying?.call(isPlaying);
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future<void> _initializeWaveform() async {
    try {
      await playerController.preparePlayer(
        path: widget.message.voiceMessage!.voiceUrl,
        shouldExtractWaveform: true,
      );

      playerController.addListener(() {
        setState(() {}); // Update the UI when waveform data changes
      });

      // Extract waveform data while playing
      playerController.onCurrentExtractedWaveformData.listen((data) {
        // You can process the waveform data here if needed
        setState(() {});
      });
    } catch (e) {
      print("Error initializing waveform: $e");
    }
  }

  @override
  void dispose() {
    _stopUpdatingSlider();
    audioPlayer.dispose();
    playerController.dispose();
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
      alignment: widget.message.senderId == FirebaseUtils.myId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSenderImage(),
              Expanded(
                child: _buildAudioMessage(),
              ),
              _buildProfileImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSenderImage() {
    if (widget.personalChat == true) return SizedBox();
    return widget.message.senderId != FirebaseUtils.myId && widget.showImage
        ? Container(
      width: 35.w,
      height: 35.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.message.senderProfileImage),
        ),
      ),
    )
        : SizedBox(width: 32.w, height: 32.h);
  }

  Widget _buildAudioMessage() {
    return Column(
      crossAxisAlignment: widget.message.senderId == FirebaseUtils.myId
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if (widget.personalChat == false && widget.showImage)
          Text(
            widget.message.senderName,
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12),
          ).marginOnly(top: 4.0),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.chatColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.message.senderId == FirebaseUtils.myId ? 15.0 : 2.0),
                  bottomRight: Radius.circular(widget.message.senderId == FirebaseUtils.myId ? 2.0 : 15.0),
                  bottomLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2),
                width: Get.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPlayPauseButton(),
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: AudioFileWaveforms(
                          size: Size(MediaQuery.of(context).size.width, 50.0),
                          playerController: playerController,
                          waveformType: WaveformType.long,
                          enableSeekGesture: true,
                          playerWaveStyle: PlayerWaveStyle(
                            waveCap: StrokeCap.round,
                            fixedWaveColor: Colors.blueGrey,
                            liveWaveColor: Colors.lightBlueAccent,
                            backgroundColor: Colors.transparent,
                            waveThickness: 4,
                          ),
                        ),
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
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
      ],
    );
  }

  Widget _buildPlayPauseButton() {
    return IconButton(
      onPressed: () async {
        if (widget.disabled == true && !isPlaying) {
          Get.snackbar(
            "Alert",
            "Please pause another playing audio first",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        if (!isPlaying) {
          setState(() {
            loading = true;
          });
          await audioPlayer.setSourceUrl(widget.message.voiceMessage!.voiceUrl);
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
        height: 10.h,
        width: 10.w,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: widget.message.senderId == FirebaseUtils.myId ? Colors.white : Colors.blue,
        ),
      )
          : Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        color: widget.message.senderId == FirebaseUtils.myId ? Colors.white : Colors.blue,
      ),
    );
  }

  Widget _buildProfileImage() {
    if (widget.personalChat == true) return SizedBox();
    return widget.message.senderId == FirebaseUtils.myId && widget.showImage
        ? Container(
      width: 35.w,
      height: 35.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.message.senderProfileImage),
        ),
      ),
    )
        : SizedBox(width: 35.w, height: 35.h);
  }

  String formatDuration(Duration duration, String formatPattern) {
    final formatter = DateFormat(formatPattern);
    return formatter.format(DateTime(0, 0, 0, duration.inHours, duration.inMinutes % 60, duration.inSeconds % 60));
  }
}
