import 'package:flutter/material.dart';
import 'dart:math';
import 'package:entering_test/bottom.dart';
import 'package:get/get.dart';

class One extends StatefulWidget {
  const One({Key? key}) : super(key: key);

  @override
  State<One> createState() => _OneState();
}

class _OneState extends State<One> {
  late List<Color> colors;
  late List<Color> containerColors;

  @override
  void initState() {
    super.initState();
    colors = [
      Colors.red[300]!,
      Colors.blue[300]!,
      Colors.purple[300]!,
      Colors.green[300]!,
      Colors.yellow[300]!,
    ];

    containerColors = List<Color>.filled(5, Colors.white);
  }

  int index = 0;
  bool isVisible = false;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 5; i++)
              GestureDetector(
                onTap: () {
                  if (isActive == false) {
                    var random = Random();
                    setState(() {
                      containerColors[i] = colors[random.nextInt(colors.length)];
                    });
                    if (i == 4) {
                      Get.to(transition: Transition.fade, () => const Board(), duration: const Duration(seconds: 3));
                      isActive = true;
                    }
                  }
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.2,
                  color: containerColors[i],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
