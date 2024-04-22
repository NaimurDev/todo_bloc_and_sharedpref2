import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTodoBottomSheet extends StatelessWidget {
  final Function(String, String) onAdd; // Function to handle adding a new Todo

  const AddTodoBottomSheet({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add New Todo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text.trim();
              String description = descriptionController.text.trim();

              if (title.isNotEmpty && description.isNotEmpty) {
                onAdd(title,
                    description); // Call the callback function with the title and description
                Navigator.pop(context); // Close the bottom sheet
              } else {
                Fluttertoast.showToast(
                    msg: "Title and Description cannot be empty.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
