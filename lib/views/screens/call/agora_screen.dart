// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:blaxity/views/screens/call/agora_constants.dart';
// import 'package:flutter/material.dart';
//
// class AgoraScreen extends StatefulWidget {
//   const AgoraScreen({Key? key}) : super(key: key);
//
//   @override
//   _AgoraScreenState createState() => _AgoraScreenState();
// }
//
// class _AgoraScreenState extends State<AgoraScreen> {
//   late AgoraClient client;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the AgoraClient with your App ID and channel name
//     client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//         appId: AgoraConstants.appId,
//         channelName:widget.,
//       ),
//       enabledPermission: [
//         Permission.camera,
//         Permission.microphone,
//       ],
//     );
//     initAgora();
//   }
//
//   // Initialize the Agora connection
//   Future<void> initAgora() async {
//     await client.initialize();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Agora UI Kit'),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               AgoraVideoViewer(
//                 client: client,
//                 layoutType: Layout.floating,
//               ),
//               AgoraVideoButtons(
//                 client: client,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     client.sessionController.dispose();
//     super.dispose();
//   }
// }
