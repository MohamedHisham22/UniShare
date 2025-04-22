import 'dart:io';
import 'package:flutter/material.dart';

class FullScreenFileImageView extends StatelessWidget {
  final dynamic imagePath; // can be File or String (URL)

  const FullScreenFileImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final bool isFile = imagePath is File;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.zero,
              minScale: 1.0,
              maxScale: 8.0,
              child: isFile
                  ? Image.file(
                      imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
