import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SixthPage extends StatefulWidget {
  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  String _preference = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routing Test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Consumer<PreferenceModel>(
                builder: (context, value, child) {
                  return Text('Your preference is - ${value.meatChoice}');
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreferencePage(),
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content:
                        Text('${context.read<PreferenceModel>().meatChoice}'),
                  ));
              },
              child: Text('Choose what you prefer'),
            ),
          ),
        ],
      ),
    );
  }
}

class PreferencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your preference'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<PreferenceModel>().meatChoice = 'Beef';
                Navigator.pop(context);
              },
              child: Text('Beef'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<PreferenceModel>().meatChoice = 'Pork';
                Navigator.pop(context);
              },
              child: Text('Pork'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<PreferenceModel>().meatChoice = 'Chicken';
                Navigator.pop(context, 'Chicken');
              },
              child: Text('Chicken'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<PreferenceModel>().meatChoice = 'Fish';
                Navigator.pop(context, 'Fish');
              },
              child: Text('Fish'),
            ),
          ),
        ],
      ),
    );
  }
}

class PreferenceModel extends ChangeNotifier {
  String _meatChoice = '';
  get meatChoice => this._meatChoice;

  set meatChoice(value) {
    this._meatChoice = value;
    notifyListeners();
  }
}
