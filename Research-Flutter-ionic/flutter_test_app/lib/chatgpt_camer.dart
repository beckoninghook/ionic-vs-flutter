import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(CameraApp());

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    final firstCamera = cameras.first;

    controller = CameraController(firstCamera, ResolutionPreset.medium);
    await controller.initialize();

    setState(() {
      isReady = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // Future<String> takePicture() async {
  //   try {
  //     final image = await controller.takePicture();
  //     final path = join(
  //       (await getTemporaryDirectory()).path,
  //       '${DateTime.now()}.png',
  //     );
  //     await image.saveTo(path);
  //     return path;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Camera App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(controller),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {},
              child: Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String imagePath;

  const PreviewScreen(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
