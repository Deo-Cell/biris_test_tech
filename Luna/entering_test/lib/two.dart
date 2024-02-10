import 'package:flutter/material.dart';
import 'dart:async';

class Two extends StatefulWidget {
  const Two({Key? key}) : super(key: key);

  @override
  State<Two> createState() => _TwoState();
}

class _TwoState extends State<Two> {
  late Timer _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
        if (_counter >= 50) {
          _counter = 0;
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