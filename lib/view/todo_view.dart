import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_model.dart';
import '../view_model/todo_view_model.dart';

class TodoListScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<TodoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          // Input field for new Todo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter new todo',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                todoViewModel.addTodo(_controller.text);
                _controller.clear();
              }
            },
            child: const Text('Add Todo'),
          ),
          Expanded(
            child: Consumer<TodoViewModel>(
              builder: (context, todoViewModel, child) {
                return ListView.builder(
                  itemCount: todoViewModel.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoViewModel.todos[index];
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _editTodoDialog(context, todoViewModel, todo, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              todoViewModel.deleteTodo(index);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        todoViewModel.toggleTodoCompletion(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Edit Todo Dialog
  void _editTodoDialog(BuildContext context, TodoViewModel todoViewModel, Todo todo, int index) {
    _controller.text = todo.title;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter new todo'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  todoViewModel.updateTodo(index, _controller.text, todo.isCompleted);
                  _controller.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
