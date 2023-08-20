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
      color: const Color.fromARGB(255, 84, 40, 241),
      radius: radius ?? 14,
    );
  }
}
