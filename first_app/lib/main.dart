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
      home: const MyHomePage(title: 'First App Home Page'),
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
                  height: 500,
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
