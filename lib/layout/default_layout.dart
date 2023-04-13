import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final AppBar? appBar;
  final Widget? bottomSheet;

  const DefaultLayout({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.floatingActionButton,
    this.appBar,
    this.bottomSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: renderAppBar(),
      bottomSheet: bottomSheet,
      body: child,
    );
  }

  AppBar? renderAppBar() {
    if (appBar == null) {
      return null;
    } else {
      return appBar;
    }
  }
}
