import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static final String id = '/aboutUs';
  final String aboutText = '''
UniShare was created by a team of senior Computer Science students at Misr University for Science and Technology. Our mission is to empower students by making academic tools—textbooks, lab equipment, electronics, and more—accessible to everyone. Whether you’re graduating and have items to give away, or a newcomer in need of resources, UniShare connects you quickly and safely through:

• Simple Listings: Post or browse items in just a few taps.

• Real‑Time Chat: Coordinate meet‑ups instantly.

• Sustainable Sharing: Reduce waste by reusing what’s already available.



Have feedback or questions? Reach out at 

- mohamed.hisham301@gmail.com /
- omarabdoulrahman@gmail.com. 

We’re here to help you share, save, and succeed!
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(aboutText, style: TextStyle(fontSize: 16.0, height: 1.5)),
      ),
    );
  }
}
