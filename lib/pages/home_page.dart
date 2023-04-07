import 'dart:async';

import 'package:flutter/material.dart';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_lab_culture/widgets/custom_clipper_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _maxValue = 20000;
  final ValueNotifier<int> _digitValueNotifier = ValueNotifier<int>(0);
  final ValueNotifier<double> _percValueNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        incrementValues();
      },
    );
  }

  void incrementValues() {
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        _digitValueNotifier.value += 1000;
        _percValueNotifier.value = _digitValueNotifier.value / _maxValue;

        if (_digitValueNotifier.value == _maxValue) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _digitValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: CustomClipperBackground(),
            child: Container(
              width: double.infinity,
              height: 210,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.grey[800]!,
                  Colors.grey[700]!,
                ], begin: Alignment.bottomLeft, end: Alignment.topRight),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: 118,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: const Offset(0, 8),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.asset(
                    'assets/images/lab_culture_carolina.jpg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            child: SvgPicture.asset(
              'assets/images/logo_lab.svg',
              width: MediaQuery.of(context).size.width * 0.42,
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: 250,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Carolina Bessa',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'COO na Lab Culture | UX Designer',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Fala sobre #uidesign, #uxdesign, #tecnologia,\n#experiencia e #criatividade',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Seguidores',
                  style: TextStyle(
                    fontFamily: 'poppinsSemiBold',
                    fontSize: 16,
                    color: Color.fromARGB(255, 71, 33, 207),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 14,
                    right: 30,
                    bottom: 24,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _percValueNotifier,
                      builder: (_, listenableValue, __) => LinearPercentIndicator(
                        animation: true,
                        animateFromLastPercent: true,
                        percent: listenableValue,
                        lineHeight: 14,
                        backgroundColor: Colors.blue.shade100.withOpacity(0.6),
                        barRadius: const Radius.circular(20),
                        progressColor: const Color.fromARGB(255, 71, 33, 207),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _digitValueNotifier,
                  builder: (_, listenableValue, __) => AnimatedDigitWidget(
                    duration: const Duration(milliseconds: 500),
                    value: listenableValue,
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 71, 33, 207),
                      fontFamily: 'poppinsSemiBold',
                    ),
                    enableSeparator: true,
                    separateSymbol: '.',
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _digitValueNotifier,
            builder: (_, listenableValue, __) => Visibility(
              visible: listenableValue == _maxValue,
              child: Positioned(
                bottom: -MediaQuery.of(context).size.height * 0.70,
                child: Lottie.asset(
                  'assets/linkedin.json',
                  width: 180,
                  height: 180,
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _digitValueNotifier,
            builder: (_, listenableValue, __) => Visibility(
              visible: listenableValue == _maxValue,
              child: Positioned(
                bottom: -MediaQuery.of(context).size.height * 0.62,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Lottie.asset(
                    'assets/fireworkb.json',
                    width: 180,
                    height: 180,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
