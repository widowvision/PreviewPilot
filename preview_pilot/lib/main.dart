import 'package:flutter/material.dart';
import 'pages/camera.dart';
import 'pages/overlay.dart'; 
import 'pages/catalog.dart';
import 'pages/share.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<Widget> _children = [
    CameraTab(),
    OverlayTab(),
    CatalogTab(),
    ShareTab(),
  ]; 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_counter],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _counter,
        selectedItemColor: Colors.red, // Set the color of the selected icon
        unselectedItemColor: Colors.grey, // Set the color of the unselected icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Overlay',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
        ],
      )
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _counter = index;
    });
  }
}
