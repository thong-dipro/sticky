import 'package:camera_macos/camera_macos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sticky/drag_area.dart';
import 'package:sticky/sticker_entity.dart';
import 'package:sticky/view_image.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScreenshotController _controller = ScreenshotController();

  List<StickerEntity> stickers = [
    StickerEntity(
      assetsUrl: 'assets/stickers/chat.png',
      width: 200,
      height: 200,
      top: 10,
      left: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Sticky App'),
      // ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.grey),
              child: Screenshot(
                controller: _controller,
                child: Stack(
                  children: [
                    const DragArea(
                      child: VideoView(),
                    ),
                    // const Dra
                    DragArea(
                      child: Image.asset(
                        stickers[0].assetsUrl,
                        width: stickers[0].width,
                        height: stickers[0].height,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    _controller.capture().then((value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Error while capturing the image',
                            ),
                          ),
                        );
                      } else {
                        Navigator.of(
                          context,
                        ).push(
                          MaterialPageRoute(
                            builder: (context) => ViewImage(
                              image: value,
                            ),
                          ),
                        );
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraMacOSController macOSController;
  @override
  Widget build(BuildContext context) {
    return CameraMacOSView(
      fit: BoxFit.fill,
      cameraMode: CameraMacOSMode.photo,
      onCameraInizialized: (CameraMacOSController controller) {
        setState(() {
          macOSController = controller;
        });
      },
    );
  }
}

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print('Start video');
    _controller = VideoPlayerController.asset('assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {
          print('Video is initialized');
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: 300,
      height: 300,
      child: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
