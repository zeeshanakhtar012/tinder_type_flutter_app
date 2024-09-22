import 'dart:convert';
import 'dart:developer';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/SettingController.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_couple_profile.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_single_user_profile.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/screens/call/controller_call.dart';
import 'package:blaxity/views/screens/call/screen_agora_audio_call.dart';
import 'package:blaxity/views/screens/call/screen_agora_video_call.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_about_details_page7.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_country_page2.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_height_page6.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_partner_page1.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_passion_page9.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_photos_page5.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_describe_page8.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_wait_list_club.dart';
import 'package:blaxity/views/screens/screen_clubs_home.dart';
import 'package:blaxity/views/screens/screen_exploring_together.dart';
import 'package:blaxity/views/screens/screen_individual/screen_create_event.dart';
import 'package:blaxity/views/screens/screen_splash.dart';
import 'package:blaxity/views/screens/screen_view_organizer_profile.dart';
import 'package:blaxity/views/screens/screen_welcome.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_identity_verification.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_selfie_verification_05.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_wait_list_sinlge_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'controllers/authentication_controllers/controller_registration.dart';
import 'controllers/controller_home.dart';
import 'controllers/controller_payment.dart';
import 'controllers/conttoller_get_partner.dart';
import 'firebase_options.dart';
// import 'package:uni_links/uni_links.dart';
import 'dart:async';
LocationData? locationData ;



late RtcEngine engine;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SettingController settingController = Get.put(SettingController());
  PaymentsController controllerMakePayment = Get.put(PaymentsController());

  Stripe.publishableKey = PaymentsController.stripePublishableKey;

  String jsonString = await rootBundle.loadString('assets/countries.json');
   locationData = await LocationData.loadFromJson(jsonString);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.lazyPut<ControllerRegistration>(() => ControllerRegistration());
  // Get.lazyPut<ControllerHome>(() => ControllerHome());
  Widget screen=await checkLoginStatus();

  runApp( MyApp(screen: screen,));
}
Future<Widget> checkLoginStatus() async {
  Widget screen = ScreenSplash();
  Get.put(ControllerLogin());
  String? token = await ControllerLogin.getToken();
  log("{token} $token");
  if (token!=null) {
    Get.put(ControllerHome());
    UserResponse userResponse= await ControllerHome().fetchUserProfile();
    User user=userResponse.user;
    if (user.userType == "couple") {
      if (user.reference == null|| user.reference!.height==null) {
       screen=ScreenChooseHeight(step: "6 of 11", user: user);
      }
      else if (user.reference!.eyeColor==null){
        screen=ScreenAboutDetails(step: "7 of 11", user: user);
        // Get.offAll();
      }
      else if (user.commonCoupleData!.description==null&&user.reference!.shareLink==null){
        screen=ScreenDescribe(step: "8 of 11",user: user,);
        // Get.offAll();
      }
      else if (user.commonCoupleData!.lookingFors==null&&user.reference!.shareLink==null){
        screen=ScreenPassion(step: "9 of 11",user: user,);
      }
      else if (user!.coupleRecentImage==null&&user.reference!.shareLink==null){
        screen=ScreenAddPhotos(step: "10 of 11",user: user,);
        // Get.offAll(ScreenAddPhotos(step: '9 of 11',user: user,));
      }
      // else if (user.reference!.longitude==null||user.reference!.latitude==""){
      //   screen=ScreenPermissions(user: user,);
      //   // Get.offAll(ScreenPermissions(user: user,));
      // }
      else if(user.reference!.shareLink==null) {
        screen = ScreenExploring(user: user,);
        // Get.offAll(ScreenExploring());
      }
      else if (userResponse.has_couple=="0") {
        screen=ScreenExploring(user: user,);
      }
      else{
        screen=HomeScreen();
        // Get.offAll();
      }

    }
    else if (user.userType=="single") {
      if (user!.country==null) {
        screen=ScreenChooseCountry(step: "5 of 11", user: user);
        // Get.offAll(ScreenChooseCountry(step: "5 of 11", user: user));
      }
      // else if (user.verification==null||user.verification!.idDocument==null) {
      //   screen=ScreenIdentityVerification(step: "6 of 11", user: user);
      //   // Get.offAll(ScreenIdentityVerification(step: "6 of 11", user: user));
      // }
      else if (user.verification!.selfie==null) {
        screen=ScreenSelfieSingleUser(step: " 7 of 11", user: user);
        // Get.offAll(ScreenSelfieSingleUser(step: " 7 of 11", user: user));
      }
      else if (user.reference==null||user.reference!.description==null){
        Get.offAll(ScreenDescribe(step: "8 of 11",user: user,));
      }
      else if(user.reference!.eyeColor!.isEmpty){
        screen=ScreenAboutDetails(step: "9 of 11",user: user,);
      }
      else if(user.reference!.lookingFor!.isEmpty){
        screen=ScreenPassion(step: "10 of 11",user: user,);
      }
      else if (user.singleRecentImage==null) {
        screen=ScreenAddPhotos(step: "11 of 11", user: user);
      }
      else if(user.waitListStatus==1&&user.goldenMember==0){
       screen=ScreenWaitListSingleUser();
      }
      else {
        screen=HomeScreen();
      }


    }
    else if (user.userType=="individual_event_organizer") {
      // log()
      if(user.ownerEvent==null||user.ownerEvent!.isEmpty) {
        screen=ScreenCreateEventIndividual(user: user);
        // Get.offAll(ScreenCreateEventIndividual(user: user));
      }

       else if (user.singleRecentImage==null) {
        screen=ScreenAddPhotos(step: "11 of 11", user: user);
      }
       else if (user.waitListStatus==1&&user.goldenMember==0){
        screen=ScreenWaitListClub(user: user);
       }
      else{
        screen=ScreenClubsHome();
        // Get.offAll(HomeScreen());
      }
    }
    else if (user.userType=="club_event_organizer") {
      if (user.clubs!.first.recentImages==null|| user.clubs!.first.recentImages!.isEmpty) {
        screen=ScreenAddPhotos(step: "11 of 11", user: user);
        // Get.offAll(ScreenAddPhotos(step: "11 of 11", user: user));
      }
      else if (user.ownerEvent==null) {
        screen=ScreenCreateEventIndividual(user: user);
        Get.offAll(ScreenCreateEventIndividual(user: user));
      }
      else if(user.waitListStatus==1&&user.goldenMember==0){
        screen=ScreenWaitListClub(user: user);
      }
      else{
        screen=ScreenClubsHome();
        // Get.offAll(HomeScreen());
      }

    }
    else {
      screen=ScreenSplash();
      // Get.offAll(ScreenSplash());
    }
  }
  else{
    screen=ScreenSplash();
    // Get.offAll(ScreenSplash());
  }
  return screen;
}

class MyApp extends StatefulWidget {
  final Widget screen;

  MyApp({required this.screen});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if it is not granted
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Permission granted, navigate to the next screen
      Get.offAll(widget.screen);
    } else {
      // Permission denied, show a message or handle accordingly
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permission Denied'),
          content: Text('Location permission is required to use this app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Optionally, exit the app
                // SystemNavigator.pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    checkNotificationPermission();
    _checkPermissions();
    initUniLinks();

  }


  late StreamSubscription _sub;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    // sound: RawResourceAndroidNotificationSound('notification'),
    enableLights: true,
    enableVibration: true,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('ringtone.mp3'),
    ledColor: const Color.fromARGB(255, 255, 0, 0),
    audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
    // custom ringtone

  );


// Function to check permissions for notifications
  void checkNotificationPermission() async {
    var settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      setupInteractedMessage();
      initNotificationChannel();
      setupNotificationChannel();
    }
  }

// Initialize notification channel for Android/iOS
  void initNotificationChannel() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        String? payload = notificationResponse.payload;
        log("Pay $payload");
        // var data=
        // if (payload != null) {
        //   if (data['type'] == 'call') {
        //     log("Now calling");
        //     handleNotificationAction(data);
        //   }
        //   else{
        //     showCallNotification(message.notification!, data);
        //   }
        // }
      },
    );
  }

// Function to set up incoming message handlers
  Future<void> setupInteractedMessage() async {
    // Handle background messages if the app was closed
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

// Handles the incoming notification message
  void _handleMessage(RemoteMessage message) {
    print("Message Data: ${message.data}");

    Map<String, dynamic> data = message.data;
    log(message.data.toString());


    if (data['type'] == 'call') {
      log("Now calling");
      handleNotificationAction(data);
    }
    else{
      showCallNotification(message.notification!, data);
    }
  }

//////////////////////////////// Show notification for incoming calls/////////////////////////////////////////////////////
  void showCallNotification(RemoteNotification notification, Map<String, dynamic> data) {

    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher', // Customize icon if needed
          priority: Priority.max,
          fullScreenIntent: true,
          enableLights: true,
          playSound: true, // Use default system sound
          silent: false,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true, // Use default system sound
        ),
      ),
      payload: jsonEncode(data), // Pass the call data for further use
    );
  }

  Future<void> handleNotificationAction(Map<String, dynamic> data) async {
    log("handleNotificationAction: $data");

    String uuid = Uuid().v4();

    CallKitParams callParams = CallKitParams(
      id: uuid,
      nameCaller: data['callerName'] ?? 'Unknown Caller', // Fallback if no caller name
      appName: 'Blaxity', // Change to your app name
      handle: 'incoming call', // Handle for the call
      type: 0, // 0 for incoming call
      duration: 30000, // Duration of call screen in milliseconds
      textAccept: 'Answer',
      textDecline: 'Decline',
      missedCallNotification: NotificationParams(
        showNotification: true,
        subtitle: 'Missed Call',
        callbackText: 'Call back',
      ),
      android: AndroidParams(
        ringtonePath: '', // Use default ringtone
        backgroundColor: '#0955fa', // Background color for Android notification
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo', // Ensure this icon exists in iOS assets
        handleType: 'generic', // Set handleType, adjust based on your needs
        supportsVideo: data["callType"] == "VideoCall", // Supports video call for VideoCall
      ),
    );

    // Show CallKit incoming call UI
    await FlutterCallkitIncoming.showCallkitIncoming(callParams);

    // Listen for user actions (accept/decline)
    FlutterCallkitIncoming.onEvent.listen((event) async {
      switch (event?.event) {
        case Event.actionCallAccept:
          log('User accepted the call');
          await _handleAnswerAction(data); // Handle the answer action
          break;

        case Event.actionCallDecline:
          log('User declined the call');
          await _handleDeclineAction(data); // Handle the decline action
          break;

        default:
          log('Unhandled CallKit event: ${event?.event}');
          break;
      }
    });
  }

  Future<void> _handleAnswerAction(Map<String, dynamic> data) async {
    log(data.toString());
    log('Handling answer action...');
    if (data["callType"] == "AudioCall") {
      log('Navigating to AgoraAudioCall...');
      Get.to(() => AgoraAudioCall(
        channelId: data['channelName'],
        callerName: data['callerName']?? "Test",
        callerImageUrl: data['callerImageUrl']?? "",
        token: data['audioCall'],
      ));
    }  else  {
      log('Navigating to AgoraVideoCall...');
      Get.to(() => AgoraVideoCall(
        channelId: data['channelName'],
        callerName: data['callerName'] ?? "Test",
        callerImageUrl: data['callerImageUrl']?? "Tst",
        token: data['videoCall'],
      ));
    }
    log('Finished handling answer action');
  }

  Future<void> _handleDeclineAction(Map<String,dynamic> data) async {
    if (data["callType"] == "AudioCall") {
      log('Navigating to AgoraAudioCall...');
      CallController callController =Get.put(CallController(token: data['audioCall'], channelId: data['channelName'], isVideoCall: false));
      callController.initAgora();
      callController.endCall();
    }  else  {
      CallController callController =Get.put(CallController(token: data['videoCall'], channelId: data['channelName'], isVideoCall: true));
      callController.initAgora();
      callController.endCall();
      // log('Navigating to AgoraVideoCall...');
      // Get.to(() => AgoraVideoCall(
      //   channelId: data['channelName'],
      //   callerName: data['callerName'] ?? "Test",
      //   callerImageUrl: data['callerImageUrl']?? "Tst",
      //   token: data['videoCall'],
      // ));
    }
  }



  // Future<void> _handleDeclineAction() async {
  //   // Handle logic for declined call, such as notifying the server or releasing the engine
  //   log("Call declined. Leaving the Agora channel...");
  //   await engine.leaveChannel();
  //   await engine.release(); // Make sure the Agora engine instance is available
  // }
// Function to set up the notification channel for FCM
  void setupNotificationChannel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // if (notification != null && android != null) {
      //   if (message.data['type'] == 'call') {
      //     showCallNotification(notification, message.data);
      //   }
      //   else{
      //
      //     showCallNotification(notification, message.data);
      //   }
      // }
    });
  }

  Future<void> initUniLinks() async {
    // Listen for incoming links
    // _sub = linkStream.listen((String? link) {
    //   if (link != null) {
    //     _handleDeepLink(link);
    //   }
    // }, onError: (err) {
    //   print('Error: $err');
    // });

    // Handle links when the app is opened from a terminated state
    try {
      final initialLink ;
      // = await getInitialLink();
      // if (initialLink != null) {
      //   _handleDeepLink(initialLink);
      // }
    } catch (err) {
      print('Error retrieving initial link: $err');
    }
  }

  Future<void> _handleDeepLink(String link) async {
    Uri uri = Uri.parse(link);
    log(uri.toString());

    // Extract parameters
    String? id = uri.queryParameters['data'];
    String? userType = uri.queryParameters['type'];

    if (id != null && userType != null) {
      log('ID: $id');
      log('User Type: $userType');
      int myId=await ControllerLogin.getUid()??0;
     if (id!=0) {
       if(userType=="couple"){
         Get.to(LayoutCoupleProfile(coupleId: int.parse(id)));
       }
       else{
         Get.to(LayoutSingleUserProfile(id: id));
       }

       }  else{
       FirebaseUtils.showError("Please make registration first then open link again to match with friend");
       Get.to(() => ScreenSplash());
     }
    } else if (id != null) {
      log('ID: $id');
      ControllerGetPartner controllerGetPartner=Get.put(ControllerGetPartner());
        controllerGetPartner.getPartner("${uri}");
      // Handle link with only id
      Get.to(() => ScreenChoosePartner(id: id,link: uri.toString(),));
    } else {
      // Handle link without id and userType
      Get.to(() => ScreenSplash());
    }
  }

  // void _handleDeepLink(String link) {
  //   Uri uri = Uri.parse(link);
  //   ControllerGetPartner controllerGetPartner=Get.put(ControllerGetPartner());
  //   controllerGetPartner.getPartner("${uri}");
  //
  //   // Extract the ID from the query parameters
  //   String? dataId = uri.queryParameters['data'];
  //
  //   if (uri.path == '/content' && dataId != null) {
  //   Get.offAll(ScreenChoosePartner(id: dataId,link: "${uri}",));
  //   }
  //
  //   // Handle other paths if needed
  // }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            final ThemeData darkTheme = ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
              ),
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              scaffoldBackgroundColor: Colors.black,
            );
            return Portal(
              child: GetMaterialApp(

                supportedLocales:
                [
                  Locale("af"),
                  Locale("am"),
                  Locale("ar"),
                  Locale("az"),
                  Locale("be"),
                  Locale("bg"),
                  Locale("bn"),
                  Locale("bs"),
                  Locale("ca"),
                  Locale("cs"),
                  Locale("da"),
                  Locale("de"),
                  Locale("el"),
                  Locale("en"),
                  Locale("es"),
                  Locale("et"),
                  Locale("fa"),
                  Locale("fi"),
                  Locale("fr"),
                  Locale("gl"),
                  Locale("ha"),
                  Locale("he"),
                  Locale("hi"),
                  Locale("hr"),
                  Locale("hu"),
                  Locale("hy"),
                  Locale("id"),
                  Locale("is"),
                  Locale("it"),
                  Locale("ja"),
                  Locale("ka"),
                  Locale("kk"),
                  Locale("km"),
                  Locale("ko"),
                  Locale("ku"),
                  Locale("ky"),
                  Locale("lt"),
                  Locale("lv"),
                  Locale("mk"),
                  Locale("ml"),
                  Locale("mn"),
                  Locale("ms"),
                  Locale("nb"),
                  Locale("nl"),
                  Locale("nn"),
                  Locale("no"),
                  Locale("pl"),
                  Locale("ps"),
                  Locale("pt"),
                  Locale("ro"),
                  Locale("ru"),
                  Locale("sd"),
                  Locale("sk"),
                  Locale("sl"),
                  Locale("so"),
                  Locale("sq"),
                  Locale("sr"),
                  Locale("sv"),
                  Locale("ta"),
                  Locale("tg"),
                  Locale("th"),
                  Locale("tk"),
                  Locale("tr"),
                  Locale("tt"),
                  Locale("uk"),
                  Locale("ug"),
                  Locale("ur"),
                  Locale("uz"),
                  Locale("vi"),
                  Locale("zh"),
                ],
                localizationsDelegates: [
                  DefaultCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                home: widget.screen,
                theme: darkTheme,
                builder: (context, child) {
                  final mediaQueryData = MediaQuery.of(context);
                  final scale = mediaQueryData.textScaleFactor.clamp(0.8, 0.9);
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                    child: child!,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}


class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}

class NoColorScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

// Future<Widget> checkLoginStatus() async {
//   Widget screen = ScreenSplash();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString('access_token');
//   String? usertype = prefs.getString('usertype');
//   int id = prefs.getInt('id') ?? 0;
//   if (token != null) {
//     ControllerHome controllerHome = Get.put(ControllerHome());
//     controllerHome.fetchUserInfo().then((value) {
//       if (controllerHome.user.value != null) {
//       } else {}
//     }).catchError((error) {});
//   } else {
//     screen = ScreenSplash();
//   }
//   return screen;
// }
class LocationData {
  final Map<String, List<String>> countryCityData;

  LocationData(this.countryCityData);

  static Future<LocationData> loadFromJson(String jsonString) async {
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    return LocationData(
      data.map((key, value) => MapEntry(key, List<String>.from(value))),
    );
  }
}