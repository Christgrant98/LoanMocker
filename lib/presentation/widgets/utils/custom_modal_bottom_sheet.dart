import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatelessWidget {
  final Widget content;
  const CustomModalBottomSheet({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: MediaQuery.of(context).size.height * .5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.5),
                topRight: Radius.circular(12.5)),
            color: Colors.white,
          ),
          child: content,
        )
      ],
    );
  }
}