import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

Future<void> showEditDialog({
  required BuildContext context,
  required ToDo todo,
  required Function(String) onSave,
}) async {
  TextEditingController editController = TextEditingController(text: todo.todoText);

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: Color(0xFFF6F8D5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        title: Text("Edit Todo"),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter updated todo",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF205781)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text("Cancel", style: TextStyle(color: Color(0xFFF38C79))),
          ),
          TextButton(
            onPressed: () {
              String updatedText = editController.text.trim();
              if (updatedText.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "You can't add empty item.",
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Color(0xFFF6F8D5),
                  ),
                );
                return;
              }
              onSave(updatedText);
              Navigator.of(dialogContext).pop();
            },
            child: Text("Save", style: TextStyle(color: Color(0xFF4F959D))),
          ),
        ],
      );
    },
  );
}