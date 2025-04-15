import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/provider/todo_provider.dart';

void main() async {
  await GetStorage.init();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoModel(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Home()),
    );
  }
}
