import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/1',
      routes: {
        '/home': (context) => const MyHomePage(title: 'Home'),
        '/1': (context) => FirstPage(),
        '/2': (context) => SecondPage(),
        '/3': (context) => ThirdPage(),
        '/4': (context) => FourthPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.network(
                  'https://mis.tbs.tu.ac.th/wp-content/uploads/MSMIS-Triple-2020.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 100.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Image.asset(
                  "images/AvatarMe.jpg",
                  height: 100,
                ),
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter = _counter - 1;
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              CounterButton(),
            ],
          ),
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

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Submit'),
    );
  }
}

class CounterButton extends StatefulWidget {
  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _counter = _counter + 1;
        });
      },
      child: Text('Counter : $_counter'),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First page'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('First page'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              child: const Text('Home'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/2'),
              child: const Text('Go to 2'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/3'),
              child: const Text('Go to 3'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/4'),
              child: const Text('Go to 4'),
            ),
          ],
        ),
      ),
    );
  }
}

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

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third page'),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 90,
              height: 90,
              color: Colors.green,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

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
