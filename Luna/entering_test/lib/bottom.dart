import 'package:entering_test/four.dart';
import 'package:entering_test/one.dart';
import 'package:entering_test/three.dart';
import 'package:entering_test/two.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int selectedIndex = 0;

  final List<Widget> widgetsList = [
    const One(),
    const Two(),
    const Three(),
    const Four(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widgetsList[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink[300],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Increment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove),
            label: 'Decrement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Get API',
          ),
        ],
      ),
    );
  }
}