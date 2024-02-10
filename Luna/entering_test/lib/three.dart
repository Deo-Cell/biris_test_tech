import 'package:flutter/material.dart';
import 'dart:async';

class Three extends StatefulWidget {
  const Three({Key? key}) : super(key: key);

  @override
  State<Three> createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
  late Timer _timer;
  int _counter = 50;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter--;
        if (_counter <= 0) {
          _counter = 50;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: Text(
            '$_counter',
            key: ValueKey<int>(_counter),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink[300]!),
          ),
        ),
      ),
    );
  }
}