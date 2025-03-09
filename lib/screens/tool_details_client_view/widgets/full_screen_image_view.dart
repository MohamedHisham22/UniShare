import 'package:flutter/material.dart';

class FullScreenImageView extends StatelessWidget {
  final String imagePath;
  

  const FullScreenImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              panEnabled: true, 
              boundaryMargin: EdgeInsets.all(0),
              minScale: 1.0,
              maxScale: 8.0,
              child: Image.asset(
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
              onPressed: () {
                Navigator.pop(context); 
              },
            ),
          ),
        ],
      ),
    );
  }
}
