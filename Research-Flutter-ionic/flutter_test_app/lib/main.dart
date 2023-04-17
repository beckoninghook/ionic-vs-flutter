import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      home: HomePage(camera: firstCamera),
    ),
  );
}

Future<void> _showNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  var flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'your_channel_id', 'your_channel_name', 'your_channel_description',
          importance: Importance.high, priority: Priority.high);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, 'New Notification',
      'Hello, Flutter Local Notifications!', platformChannelSpecifics,
      payload: 'item x');
}

class HomePage extends StatefulWidget {
  final CameraDescription camera;

  const HomePage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabs = [
      CameraTab(camera: widget.camera),
      NotificationButton(),
      Container(
        color: Colors.blue,
        child: Center(
          child: Text("Tab 3"),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabs'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _tabController.index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.error),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.square),
            label: 'Tabs',
          ),
        ],
      ),
    );
  }
}

class CameraTab extends StatefulWidget {
  final CameraDescription camera;

  const CameraTab({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  late CameraController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _controller.initialize();
    setState(() {
      _isReady = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: CameraPreview(_controller),
        ),
      ],
    );
  }
}
