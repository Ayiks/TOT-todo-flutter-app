import 'dart:convert';

import 'package:http/http.dart';

class TodoService {
  Future<Response> getAllTodoRequest(bool status) async {
    return await get(
        Uri.parse("https://snake-blue.cyclic-app.com/todos/$status"));
  }

  Future<Response> getTodoByIdRequest(String id) async {
    return await get(Uri.parse('https://snake-blue.cyclic-app.com/todos/$id'));
  }

  //create a todo
  Future<Response> createTodoRequest(
      {required String title,
      required String description,
      required String dateTime}) async {
    Map<String, String> body = {
      "title": title,
      "description": description,
      "date_time": dateTime
    };

    Map<String, String> header = {'Content-Type': 'application/json'};
    return await post(Uri.parse('https://snake-blue.cyclic-app.com/todos'),
        body: jsonEncode(body), headers: header);
  }

  //update status of todo
  updateTodoRequest({required bool status, required String id}) async {
    Map<String, bool> body = {"status": status};

  Map<String, String> header = {
    'Content-type': 'application/json'
  }; 

    return await patch(
        Uri.parse('https://snake-blue.cyclic-app.com/todos/$id'),
        body: jsonEncode(body), headers: header);
  }

  Future<Response> deleteTodoRequest(String id) async {
    return await delete(
        Uri.parse('https://snake-blue.cyclic-app.com/todos/$id'));
  }
}
