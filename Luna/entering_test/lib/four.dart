import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ATeam {
  final String name;
  final String city;

  ATeam({required this.name, required this.city});
}

class Four extends StatefulWidget {
  const Four({super.key});

  @override
  State<Four> createState() => _FourState();
}

class _FourState extends State<Four> {
  List<ATeam> allTeams = [];

  Future getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData = json.decode(response.body);

    for (var oneTeam in jsonData['data']) {
      final team = ATeam(name: oneTeam['name'], city: oneTeam['city']);
      allTeams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: const Text(
            'NBA Teams',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.pink[200],
        ),
        body: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: allTeams.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: 380,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100]!,
                          ),
                          child: ListTile(
                            title: Text(allTeams[index].name),
                            subtitle: Text(allTeams[index].city),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[100]!),
                ));
              }
            }));
  }
}
