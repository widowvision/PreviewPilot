import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// class CameraTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Camera Tab'));
//   }
// }

void main() {
  runApp(
    const MaterialApp(
      home: Upload(),
  ));
}

class Upload extends StatefulWidget {
   const Upload({super.key});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (img != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PhotoScreen(image: image))
      );
    }

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
          // backgroundColor: Colors.black,
          content: Container(
            height: MediaQuery.of(context).size.height / 25,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView( 
              child: Column(
              children: [
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

  // This Widget is for the showing the selected photo on a new page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image")
      ),
      body: Center(
        child: Column(
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


// New page for selected image
class PhotoScreen extends StatelessWidget{
  const PhotoScreen({super.key, required this.image});

  final XFile? image;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Chosen Photo")),
      body: 
        image != null
          ? Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.file(File(image!.path)))
          : null
    );
  }

}  


