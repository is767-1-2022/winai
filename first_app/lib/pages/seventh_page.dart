import 'package:first_app/controllers/todo_controller.dart';
import 'package:first_app/models/todo_model.dart';
import 'package:first_app/services/services.dart';
import 'package:flutter/material.dart';

class SeventhPage extends StatefulWidget {
  @override
  State<SeventhPage> createState() => _SeventhPageState();
}

class _SeventhPageState extends State<SeventhPage> {
  List<Todo> todos = List.empty();
  bool isLoading = false;

  TodoController contoller = TodoController(FirebaseServices());

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

  void _updateTodo(Todo todo) {
    contoller.updateTodo(todo);
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
                  _updateTodo(todos[index]);
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
