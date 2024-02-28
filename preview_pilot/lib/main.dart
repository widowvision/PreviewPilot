import 'package:flutter/material.dart';
import 'pages/camera.dart' as cameraPage;
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
    ImageOptions(),
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

class ImageOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => cameraPage.TakePictureScreen()),
              );
            },
            child: Text('Take a photo'),
          ),
          SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              // Handle 'upload a photo' button press
            },
            child: Text('Upload a photo'),
          ),
        ],
      ),
    );
  }
}