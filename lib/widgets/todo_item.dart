import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';
class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function onToDoChanged;
  final Function onDeleteItem;
  const ToDoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
         todo.isDone? Icons.check_box :
          Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(todo.todoText,style: TextStyle(
          color: tdBlack,
          fontSize: 16,
          decoration:todo.isDone? TextDecoration.lineThrough
              : null,
        ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(onPressed: (){
            onDeleteItem(todo.id);
          },
              icon: Icon(Icons.delete),
            iconSize: 18,
          color: Colors.white,),
        ),
        
      ),
    );
  }
}
