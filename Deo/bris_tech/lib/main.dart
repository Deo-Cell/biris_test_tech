import 'package:bris_tech/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  bool isvisible = false;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     final List<Widget> children = [
       FstPage(
        isvisible: isvisible,
        onVisibilityChanged: (isVisible) {
          setState(() {
            isvisible = isVisible;
          });
        },
      ),
      const sndPage(),
      const thrdPage(),
      const FeedsItems(),
    ];
    return Scaffold(
      body:  children.elementAt(_currentIndex),
      
      bottomNavigationBar: Visibility(
        visible: isvisible,
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          selectedIconTheme: const IconThemeData(color: Colors.amberAccent),
          backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'First Page',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Second Page',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Third Page',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed),
              label: 'Fourth Page',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
