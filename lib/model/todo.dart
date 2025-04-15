// This file defines the ToDo class, which represents a to-do item with an ID, text, and completion status.

import 'dart:convert';

class ToDo {
  String? id;
  String todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {'id': id, 'todoText': todoText, 'isDone': isDone};
  }

  static ToDo fromMap(Map<String, dynamic> map) {
    return ToDo(id: map['id'], todoText: map['todoText'], isDone: map['isDone']);
  }

  String toJson() => jsonEncode(toMap());

  static ToDo fromJson(String source) => ToDo.fromMap(jsonDecode(source));
}
