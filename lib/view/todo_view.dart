import 'package:flutter/material.dart';


class TodoListScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            child: const Text('Add Todo'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "title",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Edit Todo Dialog
  void _editTodoDialog(BuildContext context) {
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
              onPressed: () {},
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
