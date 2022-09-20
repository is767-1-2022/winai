import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fifth_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LoginProfileModel>(
          builder: (context, value, child) {
            return Text('Hello ${value.firstName} ${value.lastName}');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tiktok),
            onPressed: () => Navigator.pushNamed(context, '/3'),
          ),
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () => Navigator.pushNamed(context, '/2'),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.pushNamed(context, '/home');
              } else {
                Navigator.pushNamed(context, '/${index + 1}');
              }
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.75),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home),
                    Text('Go to page ${index + 1}'),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
