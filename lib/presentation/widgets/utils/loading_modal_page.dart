import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class SpinnerLoader extends StatefulWidget {
  const SpinnerLoader({super.key});

  @override
  _SpinnerLoaderState createState() => _SpinnerLoaderState();
}

class _SpinnerLoaderState extends State<SpinnerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: SvgPicture.asset(
        'assets/loader_spinner${(_controller.value * 4).floor() + 1}.svg',
      ),
    );
  }
}

class RotatingSvg extends StatefulWidget {
  final String svgAsset;

  const RotatingSvg({super.key, required this.svgAsset});

  @override
  _RotatingSvgState createState() => _RotatingSvgState();
}

class _RotatingSvgState extends State<RotatingSvg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: SvgPicture.asset(widget.svgAsset),
    );
  }
}
