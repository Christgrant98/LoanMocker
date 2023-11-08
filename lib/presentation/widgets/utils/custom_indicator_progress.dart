import 'package:flutter/cupertino.dart';

class CustomIndicatorProgress extends StatelessWidget {
  final double? radius;
  const CustomIndicatorProgress({
    super.key,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: const Color.fromARGB(255, 0, 90, 126),
      radius: radius ?? 14,
    );
  }
}
