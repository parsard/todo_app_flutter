import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';

class SearchBoxWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBoxWidget({
    super.key,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF6F8D5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged:onChanged,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: tdGray,
            )
        ),
      ),
    );
  }
}
