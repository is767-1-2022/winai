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
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailPage(
                    detail: ItemDetail(
                      entries[index],
                      colorCodes[index],
                    ),
                  ),
                ),
              );
            },
            child: Container(
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
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class ItemDetail {
  final String item;
  final int colorShade;

  const ItemDetail(this.item, this.colorShade);
}

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key, required this.detail});

  final ItemDetail detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Item - ${detail.item}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Color shade - ${detail.colorShade}'),
          )
        ],
      ),
    );
  }
}
