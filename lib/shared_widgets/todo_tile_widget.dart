import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utilities/utils.dart';
import 'package:todo_app/views/todo_detail_view.dart';

class TodoTileWidget extends StatelessWidget {
  const TodoTileWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Datum todo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return  TodoDetailView(todo: todo,);
        }));
      },
      child: Card(
        shadowColor: Theme.of(context).shadowColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListTile(
            leading: Icon(
              todo.status ? Icons.check_circle : Icons.check_circle_outline,
              size: 30,
              color: dateColor(todo.dateTime),
            ),
            title: Text(
              todo.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
            ),
            subtitle: Text(
              todo.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications,
                  color: dateColor( todo.dateTime),
                ),
                Text(
                  todo.dateTime,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: dateColor( todo.dateTime)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
