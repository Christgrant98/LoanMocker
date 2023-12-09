import 'dart:ui';

import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatelessWidget {
  final double? height;
  final Widget content;
  final double? blurredIdx;
  const CustomModalBottomSheet({
    super.key,
    required this.content,
    this.height,
    this.blurredIdx,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurredIdx ?? 5,
        sigmaY: blurredIdx ?? 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.5),
                topRight: Radius.circular(12.5),
              ),
              color: Color.fromARGB(255, 230, 230, 230),
            ),
            width: MediaQuery.of(context).size.width * .95,
            height: 10,
          ),
          Container(
            height: height ?? MediaQuery.of(context).size.height * .55,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.5),
                  topRight: Radius.circular(12.5)),
              color: Colors.white,
            ),
            child: content,
          )
        ],
      ),
    );
  }
}
