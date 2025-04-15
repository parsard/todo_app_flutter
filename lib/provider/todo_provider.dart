import 'package:flutter/widgets.dart';
import 'package:todo_app/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoModel extends ChangeNotifier {
  List<ToDo> _allTodos = [];
  List<ToDo> _foundTodos = [];
  String _searchKeyword = '';

  List<ToDo> get allTodos => _allTodos;
  List<ToDo> get foundTodos => _foundTodos;
  String get searchKeyword => _searchKeyword;

  static const todosKey = 'todos';

  TodoModel() {
    loadTodos();
  }
  //load from storage
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoStrings = prefs.getStringList(todosKey) ?? [];
    _allTodos = todoStrings.map((todo) => ToDo.fromJson(todo)).toList();
    runFilter(_searchKeyword);
    notifyListeners();
  }

  // Save to storage
  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoStrings = _allTodos.map((todo) => todo.toJson()).toList();
    await prefs.setStringList(todosKey, todoStrings);
  }

  // Every time there is a change in data, save to storage
  @override
  void notifyListeners() {
    saveTodos();
    super.notifyListeners();
  }

  editItem(ToDo todo, String newText) {
    todo.todoText = newText;
    notifyListeners();
  }

  toggleDone(ToDo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  deleteItem(String id) {
    _allTodos.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  String addItem(String todoText) {
    final trimmedTodo = todoText.trim();
    if (trimmedTodo.isEmpty) {
      return "You can't add empty item.";
    }
    final newItem = ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: trimmedTodo);
    _allTodos.add(newItem);
    runFilter(_searchKeyword);
    return "";
  }

  void runFilter(String keyword) {
    _searchKeyword = keyword;
    List<ToDo> results = [];
    if (keyword.isEmpty) {
      results = _allTodos;
    } else {
      results = _allTodos.where((todo) => todo.todoText.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    _foundTodos = results;
    notifyListeners();
  }
}
