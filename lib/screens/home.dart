import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/add_item.dart';
import 'package:todo_app/widgets/app_bar.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/search_box.dart';
import 'package:todo_app/provider/todo_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final todoController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFF4F959D),
      appBar: AppBarWidget(),
      body: Consumer<TodoModel>(
        builder: (context, todoModel, child) {
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  SearchBoxWidget(onChanged: todoModel.runFilter),
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    child: const Text(
                      'Todo App',
                      style: TextStyle(color: Colors.black, fontSize: 34, fontWeight: FontWeight.w600),
                    ),
                  ),

                  for (ToDo todo in todoModel.foundTodos.reversed)
                    ToDoItem(
                      todo: todo,
                      onToDoChanged: (_) => todoModel.toggleDone(todo),
                      onDeleteItem: (_) => todoModel.deleteItem(todo.id!),
                      onEditItem: (_) {
                        final editController = TextEditingController(text: todo.todoText);
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('Edit Todo'),
                                content: TextField(controller: editController),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                                  TextButton(
                                    onPressed: () {
                                      todoModel.editItem(todo, editController.text);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                  const SizedBox(height: 100),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: AddItemWidget(
                  todoController: todoController,
                  onAddItem: () {
                    final result = todoModel.addItem(todoController.text);
                    todoController.clear();
                    if (result.isNotEmpty) {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          content: Text(result, style: const TextStyle(color: Colors.white)),
                          backgroundColor: const Color(0xFF205781),
                          leading: const Icon(Icons.warning_amber_rounded, color: Colors.red),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                              },
                              child: const Text('DISMISS', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                      });
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


  // void _editItem(ToDo todo) {
  //   showEditDialog(
  //     context: context,
  //     todo: todo,
  //     onSave: (newText) {
  //       setState(() {
  //         todo.todoText = newText;
  //       });
  //       _saveTodos();
  //     },
  //   );
  // }

  // void _handleChange(ToDo todo) {
  //   setState(() {
  //     todo.isDone = !todo.isDone;
  //   });
  //   _saveTodos();
  // }

  // void _deleteItem(String id) {
  //   setState(() {
  //     _allTodos.removeWhere((item) => item.id == id);
  //     _runFilter(''); // Refresh filtered list
  //   });
  //   _saveTodos();
  // }

  // void _addToDoItem(String toDo) {
  //   final trimmedTodo = toDo.trim();
  //   if (trimmedTodo.isEmpty) {
  //     _todoController.clear();
  //     ScaffoldMessenger.of(context).showMaterialBanner(
  //       MaterialBanner(
  //         content: const Text("You can't add empty item.", style: TextStyle(color: Colors.white)),
  //         backgroundColor: const Color(0xFF205781),
  //         leading: const Icon(Icons.warning_amber_rounded, color: Colors.red),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  //             },
  //             child: const Text('DISMISS', style: TextStyle(color: Colors.white)),
  //           ),
  //         ],
  //       ),
  //     );
  //     Future.delayed(const Duration(seconds: 3), () {
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  //       }
  //     });
  //     return;
  //   }

  //   setState(() {
  //     final newItem = ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: trimmedTodo);
  //     _allTodos.add(newItem);
  //     _todoController.clear();
  //     _runFilter('');
  //   });
  //   _saveTodos();
  // }

  // void _runFilter(String keyWord) {
  //   List<ToDo> results = [];
  //   if (keyWord.isEmpty) {
  //     results = _allTodos;
  //   } else {
  //     results = _allTodos.where((item) => item.todoText.toLowerCase().contains(keyWord.toLowerCase())).toList();
  //   }
  //   setState(() {
  //     _foundToDo = results;
  //   });

