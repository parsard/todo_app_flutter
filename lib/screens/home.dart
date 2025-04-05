import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/add_item.dart';
import 'package:todo_app/widgets/app_bar.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/search_box.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF4F959D),
        appBar: AppBarWidget(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric
                (horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  SearchBoxWidget(onChanged: _runFilter),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text('Todo App', style:
                          TextStyle(color: tdBlack,
                              fontSize: 34,
                              fontWeight: FontWeight.w600),
                          ),
                        ),
                        for (ToDo todoo in _foundToDo.reversed)
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleChange,
                            onDeleteItem: _deleteItem,
                            onEditItem: _editItem,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AddItemWidget(
              todoController:_todoController,
              onAddItem: ()=> _addToDoItem(_todoController.text),
            )

          ],
        )
    );
  }

  void _editItem(ToDo todo) {
    TextEditingController editController = TextEditingController(text: todo.todoText);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Todo"),
          content: TextField(
            controller: editController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Edit your todo",
              hintText: "Enter updated todo",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: tdBlack)),
            ),
            TextButton(
              onPressed: () {
                String updatedText = editController.text.trim();
                if (updatedText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You can't add empty item.",
                      style: TextStyle(
                        color: Colors.black
                      ),),
                      backgroundColor: Color(0xFFF6F8D5),
                      )
                  );
                  return;
                }
                setState(() {
                  todo.todoText = updatedText;
                });
                Navigator.of(context).pop();
              },
              child: Text("Save", style: TextStyle(color: tdBlack)),
            ),
          ],
        );
      },
    );
  }
  void _handleChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteItem(String id) {
    setState(() {
      todosList.removeWhere(
              (item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    final trimmedTodo = toDo.trim();
    if (trimmedTodo
        .isEmpty) {
      if(!mounted) return;
      _todoController.clear();
      ScaffoldMessenger.of(context).showMaterialBanner(
       MaterialBanner(
         content:
           const Text("You can't add empty item.",
            style: TextStyle(
             color: Colors.white,
            ),
           ),
           backgroundColor: Color(0xFF205781),
           leading: Icon(Icons.warning_amber_rounded,
           color: Colors.red),
            actions:<Widget>[
              TextButton(onPressed:(){
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
                  child: const Text('DISMISS',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
              ),
            ],
       )
      );
          Future.delayed
            (const Duration(seconds: 3),
              () {
            if(mounted)
            {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            }
          }
      );
      return;
    }

    setState(() {
      final newItem =
      ToDo(
          id: DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()
          , todoText: toDo.trim());
      todosList.add(newItem);
      _todoController.clear();
      _runFilter('');
    });
  }

  void _runFilter(String keyWord) {
    List<ToDo> results = [];
    if (keyWord.isEmpty) {
      results = todosList;
    }
    else {
      results = todosList.where((item) =>
          item.todoText.toLowerCase()
              .contains(keyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}


