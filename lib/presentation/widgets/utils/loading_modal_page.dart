import 'package:flutter/material.dart';

import 'text_view.dart';
import 'custom_indicator_progress.dart';

class LoadingModalPage extends StatelessWidget {
  const LoadingModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: maxWidth * 8,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIndicatorProgress(
                radius: 15,
              ),
              SizedBox(height: 15),
              TextView(
                  text: 'Simulando Credito',
                  color: Color.fromARGB(255, 0, 90, 126),
                  fontWeight: FontWeight.bold,
                  fontSize: 20)
            ],
          ),
        ),
      ),
    );
  }
}
