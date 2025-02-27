import 'package:flutter/cupertino.dart';

class NewToolsImageContainer extends StatelessWidget {
  final double height;
  final BorderRadiusGeometry? borderRadius;
  const NewToolsImageContainer({
    super.key,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/tools.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: borderRadius,
      ),
    );
  }
}
