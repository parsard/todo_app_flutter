import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';
class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function onToDoChanged;
  final Function onDeleteItem;
  final Function onEditItem;
  const ToDoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.onEditItem
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
          color: Color(0xFF98D2C0),
        ),
        title: Text(todo.todoText,style: TextStyle(
          color: tdBlack,
          fontSize: 16,
          decoration:todo.isDone? TextDecoration.lineThrough
              : null,
        ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35, width: 35,
              decoration: BoxDecoration(
                color: Color(0xFFF38C79),
                borderRadius: BorderRadius.circular(5)
              ),
                child: IconButton(onPressed: (){
                  onDeleteItem(todo.id);
                },
                    icon: Icon(Icons.delete),
                  iconSize: 18,
                color: Colors.white,)
            ),
            SizedBox(width: 20,),
            Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 12),
                height: 35, width: 35,
                decoration: BoxDecoration(
                    color: Color(0xFF4F959D),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: IconButton(onPressed: (){
                  onEditItem(todo);
                },
                  icon: Icon(Icons.edit),
                  iconSize: 18,
                  color: Colors.white,)
            ),

          ],
        ),
      ),
    );
  }
}
