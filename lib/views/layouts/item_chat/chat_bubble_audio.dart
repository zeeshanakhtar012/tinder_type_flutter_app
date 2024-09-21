import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioBubble extends StatefulWidget {
  final String audioUrl;

  const AudioBubble({required this.audioUrl, Key? key}) : super(key: key);

  @override
  _AudioBubbleState createState() => _AudioBubbleState();
}

class _AudioBubbleState extends State<AudioBubble> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayingAudio = false;
  late RecorderController _waveformController;

  @override
  void initState() {
    super.initState();
    _waveformController = RecorderController();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    // Load or prepare the waveform if necessary
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _waveformController.dispose();
    super.dispose();
  }

  Widget _buildAudioBubble() {
    return Container(
      width: 200.w, // Set appropriate width
      height: 50.h, // Set appropriate height
      decoration: BoxDecoration(
        color: Color(0xff615F5F),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isPlayingAudio ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () async {
              if (_isPlayingAudio) {
                await _audioPlayer.pause();
              } else {
                await _audioPlayer.play(UrlSource(widget.audioUrl));
              }
              setState(() {
                _isPlayingAudio = !_isPlayingAudio;
              });
            },
          ),
          SizedBox(width: 8.w),
          Container(
            width: 150.w, // Fixed width for the waveform
            height: 50.h, // Fixed height for the waveform
            child: AudioWaveforms(
              size: Size(150.w, 50.h), // Adjusted size
              recorderController: _waveformController,
              enableGesture: true,
              waveStyle: WaveStyle(
                waveColor: Colors.white,
                showDurationLabel: true,
                spacing: 8.0,
                showBottom: false,
                extendWaveform: true,
                showMiddleLine: false,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFC09960),
                    Color(0xFFBC935A),
                    Color(0xFFB88C55),
                    Color(0xFFB48750),
                    Color(0xFFAE7D48),
                    Color(0xFFA7713F),
                    Color(0xFFA26837),
                    Color(0xFF9C6031),
                  ],
                ).createShader(Rect.fromLTWH(0, 0, 200.w, 50.h)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAudioBubble();
  }
}
