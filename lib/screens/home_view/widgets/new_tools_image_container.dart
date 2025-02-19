import 'package:flutter/cupertino.dart';

class NewToolsImageContainer extends StatelessWidget {
  const NewToolsImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 172,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/tools.png',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
    );
  }
}