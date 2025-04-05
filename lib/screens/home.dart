import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/add_item.dart';
import 'package:todo_app/widgets/app_bar.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/search_box.dart';
import 'package:todo_app/widgets/show_edit_dialog.dart';
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
          ListView(
            padding: EdgeInsets.all(20),
            children: [
              SearchBoxWidget(onChanged: _runFilter),
              Container(
                margin: EdgeInsets.only(
                    top: 50, bottom: 20
                ),
                child: Text(
                  'Todo App',
                  style: TextStyle(
                    color: tdBlack,
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // The list of TodoItem widgets
              for (ToDo todo in _foundToDo.reversed)
                ToDoItem(
                  todo: todo,
                  onToDoChanged: _handleChange,
                  onDeleteItem: _deleteItem,
                  onEditItem: _editItem,
                ),
              SizedBox(height: 100),
            ],
          ),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: AddItemWidget(
              todoController: _todoController,
              onAddItem: () => _addToDoItem(_todoController.text),
            ),
          ),
        ],
      ),
    );

  }
  void _editItem(ToDo todo) {
    showEditDialog(
      context: context,
      todo: todo,
      onSave: (newText) {
        setState(() {
          todo.todoText = newText;
        });
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


