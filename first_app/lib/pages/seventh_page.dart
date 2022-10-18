import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SeventhPage extends StatefulWidget {
  @override
  State<SeventhPage> createState() => _SeventhPageState();
}

class _SeventhPageState extends State<SeventhPage> {
  List<Todo> todos = List.empty();
  bool isLoading = false;

  TodoController contoller = TodoController(HttpServices());

  void initState() {
    super.initState();
    contoller.onSync.listen((bool synState) => setState(() {
          isLoading = synState;
        }));
  }

  void _getTodos() async {
    var newTodos = await contoller.fetchTodos();
    setState(() => todos = newTodos);
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: !todos.isEmpty ? todos.length : 1,
          itemBuilder: (context, index) {
            if (!todos.isEmpty) {
              return CheckboxListTile(
                onChanged: (value) {
                  setState(() => todos[index].completed = value!);
                },
                value: todos[index].completed,
                title: Text(todos[index].title),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tap button to fetch todos'),
                ],
              );
            }
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Todos"),
      ),
      body: Center(
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getTodos(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo {
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }
}

class AllTodos {
  final List<Todo> todos;

  AllTodos(this.todos);

  factory AllTodos.fromJson(List<dynamic> json) {
    List<Todo> todos;

    todos = json.map((item) => Todo.fromJson(item)).toList();

    return AllTodos(todos);
  }
}

class HttpServices {
  Client client = Client();

  Future<List<Todo>> getTodos() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(json.decode(response.body));
      return all.todos;
    } else {
      throw Exception('Fail to load todos');
    }
  }
}

class TodoController {
  final HttpServices services;
  List<Todo> todos = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  TodoController(this.services);

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await services.getTodos();
    onSyncController.add(false);
    return todos;
  }
}
