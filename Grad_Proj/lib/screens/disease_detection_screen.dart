// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/disease_detected_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  final String farmName;
  final String cropName;
  final String farmId;
  final String fieldId;
  const DiseaseDetectionScreen(
      {super.key,
      required this.farmName,
      required this.cropName,
      required this.farmId,
      required this.fieldId});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? _mediaFile;
  bool _isVideo = false;
  ControlBloc? _controlBloc;
  bool isAnalysis = false;
  VideoPlayerController? _videoController;
  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.camera.request();
      await Permission.storage.request(); // for Android < 13
      await Permission.photos.request(); // for Android 13+
      await Permission.videos.request(); // optional for videos
    } else if (Platform.isIOS) {
      await Permission.camera.request();
      await Permission.photos.request();
    }
  }

  @override
  void initState() {
    _controlBloc = context.read<ControlBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    if (!isAnalysis) {
      _controlBloc!.add(OpenFarmDiseaseDetectionEvent(farmId: widget.farmId));
    }
    super.dispose();
  }

  bool isVideoFile(String path) {
  final lower = path.toLowerCase();
  return lower.endsWith('.mp4') || lower.endsWith('.mov') || lower.endsWith('.avi');
}


  Future<void> _pickMedia(ImageSource source) async {
  final status = await Permission.photos.request();

  if (status.isGranted) {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickMedia();

    if (picked != null) {
      final file = File(picked.path);
      final isVideo = isVideoFile(file.path); // ✅ استخدمي الدالة الجديدة

      setState(() {
        _mediaFile = file;
        _isVideo = isVideo;
      });

      print('📦 Picked file path: ${file.path}');
      print('🎞️ Is video? $_isVideo');

      if (isVideo) {
        _videoController?.dispose();
        _videoController = VideoPlayerController.file(file)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      }
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Permission denied")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final bool isSelected = _mediaFile != null;

    return BlocConsumer<ControlBloc, ControlState>(
      listener: (context, state) {
        if (state is DiseaseDetectionFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else {
          isAnalysis = true;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DiseaseDetectedScreen(
                        farmId: widget.farmId,
                      )));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 70, 16, 30),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "New Disease Detection",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Upload an image or video of the crop for disease detection analysis.',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/green_location.png',
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.farmName,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(width: 32),
                      Image.asset(
                        'assets/images/leaf.png',
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.cropName,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 84),
                  Text(
                    'Upload Image or Video',
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  if (isSelected) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: _isVideo
                          ? (_videoController != null &&
                                  _videoController!.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoController!.value.aspectRatio,
                                  child: VideoPlayer(_videoController!),
                                )
                              : Container(
                                  height: 260,
                                  width: double.infinity,
                                  color: Colors.black12,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ))
                          : Image.file(
                              _mediaFile!,
                              height: 260,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: Size.fromHeight(54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                        onPressed: () => _pickMedia(ImageSource.camera),
                        icon: Image.asset(
                          'assets/images/camera.png',
                          height: 24,
                          width: 24,
                        ),
                        label: const Text(
                          'Open Camera',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: const Size.fromHeight(53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                        onPressed: () => _pickMedia(ImageSource.gallery),
                        icon: Image.asset(
                          'assets/images/upload.png',
                          height: 24,
                          width: 24,
                        ),
                        label: const Text(
                          'Select a File',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text('JPG, PNG, GIF, MP4, max 10 MB',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[700],
                          )),
                    ),
                  ],
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: testColor,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Cancle",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w600,
                                  color: testColor,
                                ),
                              ),
                            ),
                          )),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            _controlBloc!.add(UseDiseaseDetectionEvent(
                                farmId: widget.farmId,
                                fieldId: widget.fieldId,
                                media: _mediaFile!));
                          }
                        },
                        child: Container(
                          width: 160,
                          height: 45,
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : borderColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF616161),
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Analyze Media",
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.w600,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
