import 'package:http/http.dart';

class TodoService {
  Future<Response> getAllTodoRequest() async {
    return await get(Uri.parse("https://snake-blue.cyclic-app.com/todos"));
  }

  Future<Response> getTodoByIdRequest(String id) async {
    return await get(Uri.parse('https://snake-blue.cyclic-app.com/todos/$id'));
  }

  Future<Response>createTodoRequest(
      {required String title,
      required String description,
      required String dateTime}) async {
    Map<String, String> body = {
      "title": title,
      "description": description,
      "date_time": dateTime
    };
    return await post(Uri.parse('https://snake-blue.cyclic-app.com/todos'),
        body: body);
  }

  //update status of todo
  updateTodoRequest({required bool status, required String id}) async {
    Map<String, bool> body = {"status": true};
    return await patch(Uri.parse('https://snake-blue.cyclic-app.com/todos/$id'),
        body: body);
  }

  Future<Response> deleteTodoRequest(String id) async {
    return await delete(
        Uri.parse('https://snake-blue.cyclic-app.com/todos/$id'));
  }
}
