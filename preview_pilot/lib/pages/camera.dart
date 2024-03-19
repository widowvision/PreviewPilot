import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

File? _imageFile;

class CameraTab extends StatefulWidget {
  final Function(int, File?)? onImageSelected; // Callback function to be called when an image is picked

  CameraTab({this.onImageSelected});           // Constructor for the CameraTab class

  @override
  _CameraTabState createState() => _CameraTabState(); // Create a state object for the CameraTab class
}

class _CameraTabState extends State<CameraTab> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    setState(() {
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller!.initialize();
    });
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print("Camera is not initialized");
      return;
    }

    // Attempt to take a picture and get the XFile where the image is temporarily stored
    try {
      final XFile image = await _controller!.takePicture();

      // Optionally, you can save the image to a permanent location
      final directory = await getTemporaryDirectory(); // or getApplicationDocumentsDirectory();
      final String imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File imageFile = File(imagePath);

      // Copy the file to a new path
      await image.saveTo(imagePath);

      setState(() {
        _imageFile = imageFile;
      });

      // Call the callback to pass the image back to the parent widget
      widget.onImageSelected?.call(1, _imageFile);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_controller != null)
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller!); // Display the camera preview
                } else {
                  return CircularProgressIndicator(); // Display a loading spinner
                }
              },
            )
          else
            ElevatedButton(
              onPressed: _initializeCamera,
              child: Text('Capture Photo'),
            ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              // Use the image_picker package to select a photo from the gallery
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                final file = File(pickedFile.path);
                setState ((){    // Set the state of the image file to the selected file
                  _imageFile = file;
                });

                widget.onImageSelected?.call(1, file);
              }
            },
            child: Text('Upload a Photo'),
          ),
        ],
      ),
    );
  }
}
