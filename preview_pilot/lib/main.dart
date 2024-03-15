import 'package:flutter/material.dart';
import 'pages/camera.dart' as camera;
import 'pages/overlay.dart'; 
import 'pages/catalog.dart';
import 'pages/share.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  final List<Widget> _children = [ // list of widgets to be displayed for each tab
    ImageOptions(), 
    OverlayTab(),
    CatalogTab(),
    ShareTab(),
  ]; 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold is a layout for the major Material Components
      body: _children[_counter],
      bottomNavigationBar: BottomNavigationBar( // This is the bottom navigation bar
        onTap: onTabTapped, // this will be set when a new tab is tapped
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

  void onTabTapped(int index) { // this function will be called when a new tab is tapped
    setState(() {
      _counter = index; // set the current tab to the new tab
    });
  }
}

// This group of two buttons makes up the widget for the first tab
// Setting it up this way allows for easier testing using the simulator
class ImageOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context: context;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () { // When the button is pressed, the app will navigate to the camera page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => camera.TakePictureScreen()),
              );
            },
            child: Text('Take a photo'),
          ),
          SizedBox(width: 16),
          camera.UploadPicture()
        ],
      ),
    );
  }
}