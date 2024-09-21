import 'dart:io';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:blaxity/models/user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/colors.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenCameraVerification extends StatefulWidget {
  User user;

  @override
  State<ScreenCameraVerification> createState() =>
      _ScreenCameraVerificationState();

  ScreenCameraVerification({
    required this.user,
  });
}

class _ScreenCameraVerificationState extends State<ScreenCameraVerification> {
  CameraController? _cameraController;
  late List<CameraDescription> cameras;
  bool _isDetecting = false;
  XFile? _capturedImage;
  ControllerRegistration controllerRegistration =
  Get.put(ControllerRegistration());

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    print('Requesting permissions...');
    await Permission.camera.request();
    await Permission.storage.request();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      print('Initializing camera...');
      cameras = await availableCameras();
      _cameraController = CameraController(cameras[1], ResolutionPreset.high);
      await _cameraController?.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // Future<void> _detectFace(CameraImage image) async {
  //   print('Detecting face...');
  //   try {
  //     final WriteBuffer allBytes = WriteBuffer();
  //     for (final Plane plane in image.planes) {
  //       allBytes.putUint8List(plane.bytes);
  //     }
  //     final bytes = allBytes
  //         .done()
  //         .buffer
  //         .asUint8List();
  //
  //     final inputImage = InputImage.fromBytes(
  //       bytes: bytes,
  //       metadata: InputImageMetadata(
  //         size: Size(image.width.toDouble(), image.height.toDouble()),
  //         rotation: InputImageRotation.rotation0deg, // Verify this rotation
  //         format: InputImageFormat.nv21,
  //         bytesPerRow: image.planes[0].bytesPerRow,
  //       ),
  //     );
  //
  //     final faceDetector = GoogleMlKit.vision.faceDetector(
  //       FaceDetectorOptions(
  //         enableContours: true,
  //         enableClassification: true,
  //         minFaceSize: 0.1,
  //         performanceMode: FaceDetectorMode
  //             .accurate, // Use accurate mode for better detection
  //       ),
  //     );
  //     final faces = await faceDetector.processImage(inputImage);
  //
  //     print('Faces detected: ${faces.length}');
  //
  //     if (faces.isNotEmpty) {
  //       print('Face detected');
  //       await _cameraController?.stopImageStream();
  //       await _takePicture();
  //     } else {
  //       print('No face detected');
  //     }
  //   } catch (e) {
  //     print('Error detecting face: $e');
  //   }
  //   _isDetecting = false;
  // }

  Future<void> _takePicture() async {
    try {
      print('Taking picture...');
      final image = await _cameraController?.takePicture();
      if (image != null) {
        print('Picture taken: ${image.path}');
        setState(() {
          _capturedImage = image;
          controllerRegistration.selfie = File(_capturedImage!.path);
        });
        // Optionally, perform face detection on the captured image here
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void _retakePicture() {
    setState(() {
      _capturedImage = null;
      _initializeCamera();
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _cameraController == null
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : _capturedImage == null
              ? Expanded(
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CameraPreview(_cameraController!)),
          )
              : Expanded(
            child: Image.file(
              File(_capturedImage!.path),
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
            ),
          ),
          Obx(() {
            return CustomSelectbaleButton(
              isLoading: controllerRegistration.isLoading.value,
              onTap: () async {
                await _takePicture().then((value) {
                  controllerRegistration.updateSelfie(widget.user);
                });
              },
              borderRadius: BorderRadius.circular(20),
              width: Get.width,
              height: 54.h,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Take Selfie",
            );
          }).marginSymmetric(horizontal: 20.w, vertical: 10.h),
        ],
      ),
    );
  }
}
