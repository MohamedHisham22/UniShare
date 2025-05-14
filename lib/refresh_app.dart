import 'package:flutter/material.dart';

class RefreshApp extends StatefulWidget {
  const RefreshApp({super.key, required this.child});
  final Widget child;

  static void restartApp(BuildContext context) {
    final _RefreshAppState? state = context.findAncestorStateOfType<_RefreshAppState>();
    state?.restartApp();
  }
  @override
  State<RefreshApp> createState() => _RefreshAppState();
}



class _RefreshAppState extends State<RefreshApp> {
   Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey(); // Triggers rebuild with new key
    });
  }
  @override
  Widget build(BuildContext context) {
     return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
