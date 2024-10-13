import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  final Box _todoBox = Hive.box('todoBox');

  // Get all Todos
  List<Todo> get todos {
    return _todoBox.values
        .map((e) => Todo.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  // Add a new Todo
  void addTodo(String title) {
    final newTodo = Todo(title: title);
    _todoBox.add(newTodo.toMap());
    notifyListeners();
  }

  // Update Todo
  void updateTodo(int index, String title, bool isCompleted) {
    final todo = Todo(title: title, isCompleted: isCompleted);
    _todoBox.putAt(index, todo.toMap());
    notifyListeners();
  }

  // Delete Todo
  void deleteTodo(int index) {
    _todoBox.deleteAt(index);
    notifyListeners();
  }

  // Toggle the completion status of a Todo
  void toggleTodoCompletion(int index) {
    var todo = Todo.fromMap(Map<String, dynamic>.from(_todoBox.getAt(index)));
    todo.isCompleted = !todo.isCompleted;
    _todoBox.putAt(index, todo.toMap());
    notifyListeners();
  }
}
