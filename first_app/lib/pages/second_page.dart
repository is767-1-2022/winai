import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    List<int> colorCodes = <int>[600, 500, 100, 600, 400, 200, 100];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second page'),
        actions: [
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () => Navigator.pushNamed(context, '/3'),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            color: Colors.amber[colorCodes[index]],
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_alarm_rounded),
                  Text(' Item ${entries[index]}'),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
