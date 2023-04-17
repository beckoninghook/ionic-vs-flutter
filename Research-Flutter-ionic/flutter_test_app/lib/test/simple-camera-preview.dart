import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: CameraPreviewWidget(),
    ),
  );
}

class CameraPreviewWidget extends StatefulWidget {
  @override
  _CameraPreviewWidgetState createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // Get the list of available cameras
    availableCameras().then((cameras) {
      // Initialize the camera controller
      _controller = CameraController(cameras[0], ResolutionPreset.medium);

      // Initialize the camera controller future
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  void dispose() {
    // Dispose of the camera controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the camera preview
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading spinner
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
