import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewToolsImageContainer extends StatelessWidget {
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final String? imageUrl;

  const NewToolsImageContainer({
    super.key,
    required this.height,
    this.borderRadius,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image:
              imageUrl != null && imageUrl!.isNotEmpty
                  ? NetworkImage(imageUrl!) as ImageProvider
                  : const AssetImage('assets/images/tools.png'),
          fit: BoxFit.fill, // Changed to cover for better aspect ratio
        ),
      ),
    );
  }
}
