import 'dart:io';
import 'package:flutter/material.dart';

class OverlayConfig {
  String id;
  String name;
  String basePath;
  List<String> configPaths;
  Map<String, bool> configToggles;

  OverlayConfig({
    required this.id,
    required this.name,
    required this.basePath,
    required this.configPaths,
  }) : configToggles = { for (var item in configPaths) item : false };

  void toggleConfig(String path) {
    if (configToggles.containsKey(path)) {
      configToggles[path] = !configToggles[path]!;
    }
  }
}

class CatalogTab extends StatelessWidget {
  final List<OverlayConfig> overlayConfigs;

  CatalogTab({required this.overlayConfigs});

  Widget buildOverlay(OverlayConfig config) {
  List<Widget> layers = [Image.asset(config.basePath)]; // Start with the base layer

  // Add active configs
  config.configToggles.forEach((path, isActive) {
    if (isActive) {
      layers.add(Image.asset(path));
    }
  });

  return Stack(children: layers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
      ),
      body: ListView.builder(
        itemCount: overlayConfigs.length,
        itemBuilder: (context, index) {
          final overlay = overlayConfigs[index];
          return ListTile(
            tileColor: Colors.grey,
            leading: Image.asset(overlay.basePath, width: 50, height: 50),
            title: Text(overlay.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OverlayDetailsPage(overlayConfig: overlay, overlayChanged: (int , File ) {  },),
                ),
              );
            },
          );
        },
      ),
    );
  }

}

class OverlayDetailsPage extends StatefulWidget {
  final Function(int, File?) overlayChanged;

  final OverlayConfig overlayConfig;

  OverlayDetailsPage({required this.overlayConfig, required this.overlayChanged});

  @override
  _OverlayDetailsPageState createState() => _OverlayDetailsPageState();
}

class _OverlayDetailsPageState extends State<OverlayDetailsPage> {
  String? displayedImagePath;

  @override
  void initState() {
    super.initState();
    displayedImagePath = widget.overlayConfig.basePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.overlayConfig.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(displayedImagePath!), // Display the base or selected config image
            SizedBox(height: 16),
            Container(
              height: 200,
              child: Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.overlayConfig.configPaths.length,
                  itemBuilder: (context, index) {
                    final path = widget.overlayConfig.configPaths[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.overlayConfig.toggleConfig(path);
                            displayedImagePath = path;
                          });
                        },
                        child: Image.asset(path, width: 200, height: 200),
                      ),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.overlayChanged.call(1, File(displayedImagePath!) );
              },
              child: Text('Select This Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}
