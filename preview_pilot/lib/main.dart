import 'package:flutter/material.dart';
import 'pages/camera.dart';
import 'pages/overlay.dart'; 
import 'pages/catalog.dart';
import 'pages/share.dart';
import 'dart:io';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 58)),
        useMaterial3: true,
      ),
      home: MyHomePage(), // This is the home page of the app
    );
  }
}

class MyHomePage extends StatefulWidget { 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; //keeps track of the current tab
  File? _imageFile; //keeps track of the image file
  double? _overlayScale;    //keeps track of the scale of the overlay
  Offset? _overlayPosition; //keeps track of the position of the overlay

  void updateOverlayState(double scale, Offset position) {
    setState(() {
      _overlayScale = scale;
      _overlayPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
      final List<Widget> _children = [ // list of widgets to be displayed for each tab
        CameraTab(onImageSelected: handleImageSelection),
        OverlayTab(imageFile: _imageFile, 
        onImageErased: handleImageSelection,
        onOverlayUpdated: updateOverlayState,
        initialScale: _overlayScale,
        initialPosition: _overlayPosition,),
        CatalogTab(),
        ShareTab(),
      ]; 


      return Scaffold( // Scaffold is a layout for the major Material Components
        body: _children[_counter],
        bottomNavigationBar: BottomNavigationBar( // This is the bottom navigation bar
          onTap: switchTab,       // this will be set when a new tab is tapped
          currentIndex: _counter, // keeps track of current tab
          selectedItemColor: Colors.red, 
          unselectedItemColor: Colors.grey, 
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

    void handleImageSelection(int index, File? file) {
    setState(() {
      _counter = index;  // switch tab to this index
      _imageFile = file; // set the image file
    });

  }

    void switchTab(int index) {
    setState(() {
      _counter = index;
    });
  }
}