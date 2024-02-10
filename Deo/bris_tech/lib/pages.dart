// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:math';
import 'package:bris_tech/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class FstPage extends StatefulWidget {
  final bool isvisible;
  final ValueChanged<bool> onVisibilityChanged;

  const FstPage({
    Key? key,
    required this.isvisible,
    required this.onVisibilityChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FstPageState createState() => _FstPageState();
}

class _FstPageState extends State<FstPage> {
  Color _backgroundColor = Colors.white;

  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  bool _isBottomNavBarZone(Offset tapPosition, Size screenSize) {
    return tapPosition.dy > screenSize.height - 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapUp: (TapUpDetails details) {
          setState(() {
            _backgroundColor = _generateRandomColor();
            widget.onVisibilityChanged(_isBottomNavBarZone(
                details.localPosition, MediaQuery.of(context).size));
          });
        },
        child: Container(
          color: _backgroundColor,
        ),
      ),
    );
  }
}


class sndPage extends StatefulWidget {
  const sndPage({super.key});

  @override
  State<sndPage> createState() => _sndState();
}

class _sndState extends State<sndPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tap to increment the value:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class thrdPage extends StatefulWidget {
  const thrdPage({super.key});

  @override
  State<thrdPage> createState() => _thrdState();
}

class _thrdState extends State<thrdPage> {
  int _counter = 50;

  void _incrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tap to decrement the value:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Tap to decrement the value',
        child: const Icon(Icons.remove),
      ),
    );
  }
}

class FeedsItems extends GetView<FeedsController> {
  const FeedsItems({super.key});

  @override
  Widget build(BuildContext context) {
    FeedsController feedsController = Get.put(FeedsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flux RSS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
       
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (feedsController.rssarticle.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        } else {
          return ListView.builder(
            itemCount: feedsController.rssarticle.length,
            itemBuilder: (context, index) {
              RssArticles article = feedsController.rssarticle[index];
              if (article.image.isEmpty) {
                return Container();
              }
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.pubDate),
                leading: Image.network(article.image),
                onTap: () async {
                  final Uri url = Uri.parse(article.link);
                  await launchUrl(url);
                },
              );
            },
          );
        }
      }),
    );
  }
}

class FeedsController extends GetxController {
  final RxList<RssArticles> rssarticle = <RssArticles>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFeeds();
    if (kDebugMode) {
      print("constructeur est prêt");
    }
  }

  Future<void> getFeeds() async {
    var url = Uri.parse(getFeedsRoute);
    var response = await http.get(url);
    final List<dynamic> data = json.decode(response.body);
    rssarticle.value = data.map((e) => RssArticles.fromJson(e)).toList();
    
  }
}
