import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


CameraDescription? firstCamera; // A variable to store the first camera, the ? allows for null values

// A function that initializes the camera
Future<CameraDescription?> initializeCamera() async {

  // Ensure that plugin services are initialized so that `availableCameras()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

  return firstCamera;
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key,});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  CameraDescription? _cameraDescription; 

  @override
  void initState() {
    super.initState();
    initializeCamera().then((CameraDescription? cameraDescription) {
      setState(() {
        _cameraDescription = cameraDescription;
      });

      if (_cameraDescription != null) {
        _controller = CameraController(
          _cameraDescription!,
          ResolutionPreset.medium,
        );

        _initializeControllerFuture = _controller.initialize();
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}


// For uploading a photo from the gallery
class UploadPicture extends StatefulWidget {
   const UploadPicture({super.key});

  @override
  UploadPictureState createState() => UploadPictureState();
}

class UploadPictureState extends State<UploadPicture> {
  
  // variable to hold the image
  XFile? image;

  // for opening the gallery to choose a picture
  final ImagePicker picker = ImagePicker();

  // function to wait for user to choose a photo
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (img != null) {
      Navigator.push(
        context,

        // forward to Display page
        MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: img.path))
      );
    }

    // assigning the chosen image to the image variable
    setState(() {
      image = img;
    });
  }


  // This is the pop-up at the bottom to show the open gallery button.
  void getPhotoAlert() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: const Alignment(0,1),
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          content: Container(
            height: MediaQuery.of(context).size.height / 25,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView( 
              child: Column(
              children: [
                // Button that opens gallery
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  }, 
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)
                      )
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          children:[
                            Icon(Icons.image),
                            Text("Choose Photo from Gallery")
                          ]
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            )
          ),
        );
      }
    );
  }

  // Upload Photo button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image")
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                getPhotoAlert();
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero))
              ),
              child: const Text("Upload Photo"),
            ),
          ],
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath))
    );
  }
}
