import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
 class AddItemWidget extends StatelessWidget {
   final VoidCallback onAddItem;
   final TextEditingController todoController;
   const AddItemWidget({Key?key,
   required this.onAddItem,
   required this.todoController
   }): super(key: key);

   @override
   Widget build(BuildContext context) {
     return Align(
       alignment: Alignment.bottomCenter,
       child: Row(
         children: [
           Expanded(
             child: Container(
               margin: EdgeInsets.only
                 (bottom: 30, right: 30, left: 30),
               height: 60,
               padding: EdgeInsets.symmetric(
                   horizontal: 20,
                   vertical: 5
               ),
               decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: const [
                   BoxShadow(
                       color: Colors.grey,
                       offset: Offset(0, 0),
                       blurRadius: 10.0,
                       spreadRadius: 0.0
                   ),
                 ],
                 borderRadius: BorderRadius.circular(10),

               ),
               child: TextField(
                 controller: todoController,
                 decoration: InputDecoration(
                   hintText: 'Add New Item.',
                   border: InputBorder.none,
                 ),
               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(
               bottom: 30,
               right: 30,
             ), child:
           ElevatedButton(
             onPressed: onAddItem,
             child:
             Text(
               '+', style: TextStyle(fontSize: 40,
                 color: Colors.white),
             ),
             style: ElevatedButton.styleFrom(
                 backgroundColor: tdBlue,
                 minimumSize: Size(60, 60),
                 elevation: 5
             ),
           ),)
         ],
       ),
     );
   }
 }
