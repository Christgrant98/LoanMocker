import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  const Layout({
    super.key,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          bottomNavigationBar: bottomNavigationBar,
          body: body,
        );
      },
    );
  }
}
