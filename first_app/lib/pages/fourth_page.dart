import 'package:flutter/material.dart';

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fourth page'),
      ),
      body: Center(
        child: Table(
          children: [
            TableRow(
              children: [
                Text('ID'),
                Text('Name'),
                Text('Age'),
              ],
            ),
            TableRow(
              children: [
                Text('1'),
                Text('Winai'),
                Text('25'),
              ],
            ),
            TableRow(
              children: [
                Text('2'),
                Text('Bell'),
                Text('18'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
