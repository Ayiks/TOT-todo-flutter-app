import 'dart:convert';

import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/todo_services.dart';

class TodoController {
  final TodoService _todoService = TodoService();

  Future<Todo?> getAllTodos({bool status = false}) async {
    Todo? _todo;
    await _todoService.getAllTodoRequest(status).then((response) {
      int statusCode = response.statusCode;
      print(response.body);
      if (statusCode == 200) {
        //success
        _todo = Todo.fromMap(json.decode(response.body));
      } else {
        //error
        _todo = null;
      }
    }).catchError((onError) {
      print(onError);
      _todo = null;
    });
    return _todo;
  }

  Future<bool> createTodo(
      {required String title,
      required String description,
      required String dateTime}) async {
    try {
      // bool isSuccessful = false;
      var response = await _todoService.createTodoRequest(
          title: title, description: description, dateTime: dateTime);
      print(response);
      return true;
    } catch (error) {
      print('Something went wrong creating Todo: $error');
    }
    return false;
  }

  Future<bool> deleteTodo(String id) async {
    bool isDeleted = false;
    await _todoService.deleteTodoRequest(id).then((response) {
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        isDeleted = true;
      } else {
        isDeleted = false;
      }
    }).catchError((onError) {
      isDeleted = false;
    });
    return isDeleted;
  }

  //update
  Future<bool> updateTodoStatus(
      {required String id, required bool status}) async {
    bool isUpdated = false;
    await _todoService
        .updateTodoRequest(status: status, id: id)
        .then((response) {
          int statusCode = response.statusCode;
          if(statusCode == 200){
            isUpdated=true;
          }else{
            isUpdated = false;
          }
        }).catchError((onError){
          isUpdated = false;
        });
        return isUpdated;
  }
}
