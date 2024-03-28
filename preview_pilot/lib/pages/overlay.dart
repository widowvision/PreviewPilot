import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';

// Main widget for overlay with necesary callback functions
class OverlayTab extends StatefulWidget {
  File? imageFile;
  final Function(int, File?)? onImageErased;
  final Function(double, Offset)? onOverlayUpdated;
  final double? initialScale;
  final Offset? initialPosition;

  OverlayTab({
    this.imageFile, 
    this.onImageErased,  
    this.onOverlayUpdated, 
    this.initialScale, 
    this.initialPosition
    });

  @override
  _OverlayTabState createState() => _OverlayTabState();
}

// class _OverlayTabState extends State<OverlayTab> {
//   late double scale;
//   late Offset position;
//   Offset? startingFocalPoint;

//   @override
//   void initState() {          // sets init scale/position
//     super.initState();
//     scale = widget.initialScale ?? 1.0;
//     position = widget.initialPosition ?? Offset.zero;
//   }

//   double startScale = 1.0;    // Scale value at the start of a scaling gesture

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Overlay'),
//         actions: [
//           if (widget.imageFile != null)   // Display the close button if an image is selected
//             IconButton(onPressed: (){     // reset button to reset scale/position of overlay
//               setState(() {
//                 scale = 1.0;
//                 position = Offset.zero;
//               });
//               widget.onOverlayUpdated!(scale, position);
//             }, icon: Icon(Icons.restore)
//             ),
//           if (widget.imageFile != null)  // Display the close button if an image is selected
//             IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 setState(() {
//                   widget.imageFile = null;
//                 });
//                 widget.onImageErased!(0, widget.imageFile); // callback when user erases the selected image
//                                                             // switches back to first tab and sets that to null.
//               },
//             ),
//         ],
//       ),
//       body: widget.imageFile != null
//         ? GestureDetector(
//           onScaleStart: (ScaleStartDetails details) {
//             startScale = scale;
//             startingFocalPoint = details.localFocalPoint;
//           },
//           onScaleUpdate: (ScaleUpdateDetails details) {
//               if (startingFocalPoint != null) {
//                 final Offset delta = details.localFocalPoint - startingFocalPoint!;
                
//                 setState(() {
//                   position += delta;
//                   scale = startScale * details.scale;

//                 });
//                 startingFocalPoint = details.localFocalPoint; // Update the focal point

//                 widget.onOverlayUpdated!(scale, position);    // Callback function is called
//               }
//             },

//           child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: Image.file(
//                     widget.imageFile!,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   left: position.dx,
//                   top: position.dy,
//                   child: Transform.scale(
//                     scale: scale,
//                     child: Image.asset(
//                       'assets/images/Trap_01[44]a.png',
//                       width: 200,
//                       height: 200,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         : const Center(child: Text('No image selected.')),
//     );
//   }
// }

// GestureDetector()
class _OverlayTabState extends State<OverlayTab> {

  // Where the rectangle start and stops, initially, in the middle
  Offset _startPosition = Offset(150,150);
  Offset _endPosition = Offset(250,250);

  Rect _rectangle = Rect.fromLTWH(150, 150, 100, 150); // (left, top, width, height)

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
         title: Text('Choose Pegboard'),
      ),
      body: widget.imageFile != null
      ? GestureDetector(
        // onPanStart: (details){
        //   setState(() {
        //     // Check if the touch position is near the corners of the rectangle
        //     if ((details.localPosition - Offset(_rectangle.left, _rectangle.top)).distance < 20) {
        //       _rectangle = _rectangle.translate(details.localPosition.dx - _rectangle.left, details.localPosition.dy - _rectangle.top);
        //     } else if ((details.localPosition - Offset(_rectangle.right, _rectangle.bottom)).distance < 20) {
        //       _rectangle = _rectangle.copyWith(width: details.localPosition.dx - _rectangle.left, height: details.localPosition.dy - _rectangle.top);
        //     }
        //   });
        // },
        onPanUpdate: (details){
          setState(() {
            // Update the position and size of the rectangle based on the drag movement
            _rectangle = Rect.fromLTWH(
              _rectangle.left + details.delta.dx,
              _rectangle.top + details.delta.dy,
              _rectangle.width,
              _rectangle.height,
            );
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                widget.imageFile!,
              ),
            ),
            Positioned(
              left: _rectangle.left,
              top: _rectangle.top,
              child: Container(
                width: _rectangle.width,
                height: _rectangle.height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange, // Border color
                    width: 2.0, // Border width
                  ),
                ),
              ),
            ),
            // CustomPaint(
            //   painter:
            // ),
          ]
        )
      )
      : const Center(child: Text('No image selected.')),
    );
  }
}