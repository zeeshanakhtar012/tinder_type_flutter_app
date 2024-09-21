import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';

class ScreenTest extends StatefulWidget {
  const ScreenTest({super.key});

  @override
  State<ScreenTest> createState() => _ScreenTestState();
}

class _ScreenTestState extends State<ScreenTest> {
  final Uuid _uuid = Uuid();
  String? _currentUuid;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await FlutterCallkitIncoming.requestNotificationPermission({
      "rationaleMessagePermission": "Notification permission is required to show notifications.",
      "postNotificationMessageRequired": "Please allow notification permissions from settings."
    });
  }

  Future<void> showIncomingCall() async {
    _currentUuid = _uuid.v4();
    CallKitParams params = CallKitParams(
      id: _currentUuid,
      nameCaller: 'Hien Nguyen',
      appName: 'CallKit',
      avatar: 'https://i.pravatar.cc/100',
      handle: '0123456789',
      type: 0,
      // 0 is for incoming call
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      duration: 30000,
      android: AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'https://i.pravatar.cc/500',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  Future<void> startOutgoingCall() async {
    _currentUuid = _uuid.v4();
    CallKitParams params = CallKitParams(
      id: _currentUuid,
      nameCaller: 'Hien Nguyen',
      handle: '0123456789',
      type: 1,  // 1 is for outgoing call
      textAccept: 'Call back',
      textDecline: 'Missed call',
      extra: {'userId': '1a2b3c4d'},
      ios: IOSParams(
        handleType: 'generic',
      ),
      android: AndroidParams(
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'https://i.pravatar.cc/500',
      ),
    );
    try {
      await FlutterCallkitIncoming.startCall(params);
      print('Outgoing call initiated successfully.');
    } catch (e) {
      print('Error starting outgoing call: $e');
    }

  }

  Future<void> endCall() async {
    await FlutterCallkitIncoming.endCall(_currentUuid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CallKit Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: showIncomingCall,
              child: Text('Show Incoming Call'),
            ),
            ElevatedButton(
              onPressed: startOutgoingCall,
              child: Text('Start Outgoing Call'),
            ),
            ElevatedButton(
              onPressed: endCall,
              child: Text('End Call'),
            ),
          ],
        ),
      ),
    );
  }
}

