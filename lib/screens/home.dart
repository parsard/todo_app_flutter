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
        backgroundColor: tdBGColor,
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
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                          ),
                        ),
                        for (ToDo todoo in _foundToDo.reversed)
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleChange,
                            onDeleteItem: _deleteItem,
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
    if (toDo
        .trim()
        .isEmpty) {
      print('can not add empty item');
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
