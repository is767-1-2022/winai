import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/todo_model.dart';
import 'package:http/http.dart';

class FirebaseServices {
  Future<List<Todo>> getTodos() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('todos').get();

    AllTodos todos = AllTodos.fromSnapshot(snapshot);
    return todos.todos;
  }

  void update(Todo todo) async {
    print('Updating todo id=${todo.id}');
    await FirebaseFirestore.instance.collection('todos').doc(todo.id).update({
      'completed': todo.completed,
    });
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

  void update(Todo todo) async {
    final response = await client.put(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo.id}'),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, dynamic>{
        "userId": todo.userId,
        "id": todo.id,
        "title": todo.title,
        "completed": todo.completed,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Cannot update todo");
    }

    print(response.body);
  }
}
