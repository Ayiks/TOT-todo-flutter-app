import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utilities/utils.dart';

//this is to view the details of each Todo.

class TodoDetailView extends StatelessWidget {
  const TodoDetailView({Key? key, required this.todo}) : super(key: key);

  final Datum todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Todo')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              todo.dateTime,
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: dateColor(todo.dateTime)),
            ),
            const SizedBox(height: 10,),
            Text(
              todo.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(todo.description),
          ],
        ),
      ),
    );
  }
}
