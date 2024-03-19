import 'package:flutter/material.dart';
import 'dart:io';

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

class _OverlayTabState extends State<OverlayTab> {
  late double scale;
  late Offset position;
  Offset? startingFocalPoint;

  @override
  void initState() {
    super.initState();
    scale = widget.initialScale ?? 1.0;
    position = widget.initialPosition ?? Offset.zero;
  }

  int _counter = 0;
  double startScale = 1.0; // Scale value at the start of a scaling gesture

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Overlay'),
        actions: [
          if (widget.imageFile != null)  // Display the close button if an image is selected
            IconButton(onPressed: (){ // reset button to reset scale/position of overlay
              setState(() {
                scale = 1.0;
                position = Offset.zero;
              });
              widget.onOverlayUpdated!(scale, position);
            }, icon: Icon(Icons.restore)
            ),
          if (widget.imageFile != null)  // Display the close button if an image is selected
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  widget.imageFile = null;
                });
                widget.onImageErased!(0, widget.imageFile);
              },
            ),
        ],
      ),
      body: widget.imageFile != null
        ? GestureDetector(
          onScaleStart: (ScaleStartDetails details) {
            startScale = scale;
            startingFocalPoint = details.localFocalPoint;
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
              if (startingFocalPoint != null) {
                final Offset delta = details.localFocalPoint - startingFocalPoint!;
                
                setState(() {
                  position += delta;
                  scale = startScale * details.scale;

                });
                startingFocalPoint = details.localFocalPoint; // Update the focal point

                widget.onOverlayUpdated!(scale, position);  // Callback function is called
              }
            },

          child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    widget.imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: position.dx,
                  top: position.dy,
                  child: Transform.scale(
                    scale: scale,
                    child: Image.asset(
                      'assets/images/Trap_01[44]a.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: Text('No image selected.')),
  );
}
}
